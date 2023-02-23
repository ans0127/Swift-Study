import UIKit

var greeting = "Hello, playground"
/*=============================================================================================
 ✨Result Type이란?  결과값을 가질 수 있는 타입을 말한다.
:  에러처리 할 때, throws함수를 만들고, do{  }catch{ }블록을 만들어서 처리해 주는 번거로움이있어서 ResultType이란 것을 만들었다.
 💠Result Type의 내부구현
    - enum Result<success, Failure> where Failure : Error
    - https://developer.apple.com/documentation/swift/result
 
 💠 Result Type은 열거형으로 이루어져있다,
    - case success(연관값)
    - case failure(연관값)
 =============================================================================================*/

//에러정의
enum HeightError: Error{
    case maxHeight
    case minHeight
}

//기존 throws 함수를 이용한 에러처리
func checkingHeight(height: Int) throws -> Bool{
    if height > 190{
        throw HeightError.maxHeight
    }else if height < 130 {
        throw HeightError.minHeight
    }else{
        if height >= 160{
            return true
        }else{
            return false
        }
    }
}

do{
    let _ = try checkingHeight(height: 200)
    print("놀이기구 탈 수 있음 ")
}catch{
    print("놀이기구 못탐")
}


//ResultType을 사용한 에러처리
//ResultType에는 성공, 실패의 정보가 모두 들어있음.
func resultTypeCheckingHeight(height: Int) -> Result<String, HeightError> {    //성공했을 때는 Bool 연관값에 t/f를 주고, 실패했을 때는 HeightError 에 에러메세지를 던져줌
    if height > 190 {
        return Result.failure(HeightError.maxHeight)    //에러를 던져야 할 곳에 Result를 반환하는 return을 해줌
    }else if height < 130{
        return Result.failure(HeightError.minHeight)
    }else {
        // 키가 190 이상이거나 130 미만일경우는 정상적인 경우이고, 키가 160 이상일경우 t/f를 반환한다.
        if height >= 160{
                return Result.success("160 이상입니다.")
        }else{
                return Result.success("160 미만입니다.")
        }
    }
}

//throws가 없기 때문에 try문을 사용할 필요가 없음. ( 타입이 Result이기 때문에  )
let result = resultTypeCheckingHeight(height: 149)

//처리
switch result{
case .success(let data):
    print("success 결과값은 \(data) 입니다. ")
case .failure(let error):
    print("error failure결과값은 \(error) 입니다. ")
}



/*======================================================================
 ✨네트워킹 코드에서 Result 타입의 활용✨
 ======================================================================*/
//에러를 정의
enum NetworkError: Error{
    case someError
}


//💠result type 을 사용하지 않고 네트워킹 처리를 했을 경우💠
func performRequest(with url : String, completion : @escaping (Data?, NetworkError?) -> Void){
    guard let url = URL(string: url ) else {return}
    URLSession.shared.dataTask(with: url) {(data, response, error) in
        if error != nil{
            print(error!)
            completion(nil, NetworkError.someError)
            return
        }
        guard let safeData = data else {
            completion(nil, NetworkError.someError)  //옵셔널 바인딩 실패 ... data 는 nil전달
            return
    }
        completion(safeData, nil )
    }.resume()
}

performRequest(with: "https://..주소") { data, error in
    if error != nil{
        print(error!)
    }
    //데이터 처리 관련 코드 작성
}



//💠result type 을 사용해서 네트워킹 처리를 할 경우💠
//파라미터 두개가 아닌  Result 타입만 넣음. 성공인경우 Data, 실패인 경우 NetworkError 전달
func performRequest2(with urlString: String, completion: @escaping (Result<Data, NetworkError>)-> Void){
    guard let url = URL(string: urlString) else {return}
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil{                    // 에러가 발생했을경우
            print(error!)                   //실패 케이스 전달
            completion(Result.failure(NetworkError.someError))  //열거형 내부의 열거형 전달
            return
        }
        guard let safeData = data else{
            completion(Result.failure(NetworkError.someError))    //실패 케이스 전달
            return
        }
        completion(Result.success(safeData))       //성공 케이스 전달
    }
}

performRequest2(with: "주소"){ result in
    switch result{
    case .failure( let error ) :
        print(error)
    case .success( let data ) :
        //데이터 처리 관련 코드
        break
    }
}
