import UIKit
/**
 < 에러의 종류 >
 1. 컴파일 에러 : 문법과 관련된 에러
 2. 런타임 에러 : 프로그램이 실행되는 동안 발생 -> 에러처리를 미리 해두면 앱이 종료되지 않음( 개발자가 처리 필요!) ⭐️
 */


/**===========================================
<< 에러 처리의 3단계 >>
1.에러를정의
2.에러가 발생할 수 있는 함수를 정의
3.함수에 대한 처리
 ===========================================*/

//1. 어떤 종류의 에러가 발생할지 미리 에러를 정의
enum SomeError: Error {   //swift의 Error 프로토콜을 채택해야 한다.
    case firstError
    case secondError
    case thirdError
}

 //2.에러가 발생할 수 있는 함수에 대해 정의 throws 사용
func numCount ( num : Int ) throws -> Bool {   //throws: 에러가 발생할 수 있는 함수이다.
    if num >= 7 {
        return true
    }else {
        if num < 1 {
            throw SomeError.firstError
        }else{
            throw SomeError.secondError
        }
    }
}

//3. 에러 처리 함수 실행 (try, do-catch문 사용)
//do 블럭 : 함수를 통한 정상적인 처리가 가능한 경우 실행하는 블럭
//catch 블럭 : 함수가 에러를 던졌을 때 실행하는 블럭
do{                              //정상적인 경우의 처리 상황 (true,false가 나오는 정사적인 경우)
    var rslt = try numCount(num : 0)  // 여기서 실행하다가 에러를 던지면 catch 블럭으로 간다.
    if rslt {
        print("참")
    }else{
        print("거짓")
    }
}catch{
    print(" catch이후 ~ 함수가 에러를 던졌을 때 처리하는 곳 ")
}

/**==============================================================
 에러를 처리하는 방법
 1. try
 2. try?  : 옵셔널 try
 3. try!  : forced try
 ==============================================================*/
//1. try
do{
    var rslt = try numCount(num : 0)
    if rslt {
        print("참")
    }else{
        print("거짓")
    }
}catch{
    print(" catch이후 ~ 함수가 에러를 던졌을 때 처리하는 곳 ")
}

//2. try?
//사용시 옵셔널을 벗겨서 사용해야 함.
var rslt = try? numCount(num: 1)


//3. try!
//에러가 나지 않는다고 확신하는 경우에만 사용
//정상 = 리턴값 호출 , 에러 = 런타임에러
var rslt1 = try! numCount(num: 1)

//catch 블럭 처리-------------------------------------------------------------------------------------------------
//do 블럭에서 발생한 에러만을 처리하는 블럭
//반드시 모든 에러를 처리 해야함.
do{
    var rslt = try numCount(num : 0)
    if rslt {
        print("참")
    }else{
        print("거짓")
    }
}catch SomeError.firstError{
    print(" 함수가 에러를 던졌을 때 첫번째 방법으로 에러처리 ")
}catch SomeError.secondError{
    print(" 함수가 에러를 던졌을 때 두번째 방법으로 에러처리 ")
}catch SomeError.thirdError{
    print(" 함수가 에러를 던졌을 때 세번째 방법으로 에러처리 ")
}


//catch 패턴 없이도 처리 가능
do{
    var rslt = try numCount(num : 0)
    print(" 숫자 : \(rslt)")
}catch{   //error 상수 제공
    print(error.localizedDescription) //에러를 로컬 환경설정에 맞춰서 출력해줌.
    
    if let error = error as? SomeError{  //에러타입을 SomeError 타입으로 변환해줌
        
        switch error{
        case .firstError:
            print("첫번째 에러 핸들링")
        case .secondError:
            print("두번째 에러 핸들링")
        case .thirdError:
            print("세번째 에러 핸들링")
        }
    }
}


//에러를 처리하는 함수
//1. 함수 내부에서 에러함수를 다루는 경우
enum SomeError1 : Error {
    case aError
}

func throwFun() throws{
    throw SomeError1.aError
}

func handleError(){
    do{
        try throwFun()          //함수 내부에서 에러함수를 다룰 수 있다.
    } catch{
        print(error)
    }
    
}

//2. rethrow 키워드 사용
/*=====================================================
✨ rethrowing 함수 : rethrow 키워드를 사용하는 함수✨
                    rethrow  키워드 : throw (에러를 던지는)함수를 파라미터로 가질 경우 rethrow 키워드를 사용하여 처리한다.
 =====================================================*/
//방법1
func someFunction1(callback : () throws -> Void) rethrows  {
    try callback()      //에러를 다시 던짐
}



//✨defer문 : 할일을 미루는 역할 - 한번은 반드시 호출이 되어야 한다
//일반적으로 하나의 defer문만 사용하는 것이 좋지만, 여러 defer문을 사용할 경우, 등록한 역순으로 호출이 된다.
func deferStatement1(){
    defer{
        print("나중에 실행할거야")
    }
    print("먼저 실행할거야")
}
deferStatement1()
//먼저 실행할거야
//나중에 실행할거야


func deferStatement2(){
    if true{
        print("2 먼저 실행하기")
        return
    }
    defer{
        print("2 나중에 실행하기 ")
    }
}

deferStatement2()
//2 먼저 실행하기



