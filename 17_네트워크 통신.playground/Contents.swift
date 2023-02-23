import UIKit


/*네트워킹하는 코드 작성=========================================================
 1. url구조체 생성
 2. urlSession 생성(브라우저 킴)
 3.dataTask (url입력 , 이 단계에서 dataTask가 알아서 처리를 다 해줌)
 4. 시작(resume) : 엔터키를 눌러서 실행하는 역할을 함.
 
 세션이란? 일정시간 하나의 브라우저가 서버와 연결되어있는 상태.
 ==========================================================================*/



//일별 영화정보를 가져오는 url을 가져왔다고 가정하자.
//✨1. string을 가지고 url을 만들자
let movieURL = "www.naver.com:1111?k=v&k=v..."   //예시!!!


//✨2. url을 구조체 url로 바꿔주자.
//URL(string: <#T##String#>) 문자열을 가지고url 구조체를 생성하는 것
//이 구조체는 optional이다.
let structURL = URL(string: movieURL)!   //붕어빵

//✨3. URLsession 을 만들자. ( 서버와 통신하는, 브라우저와 같은 역할을 하는 것)
let session = URLSession(configuration: .default)    // 보통 configuration: .default을 자주 사용한다.
let session1 = URLSession.shared // <- 가장 많이 사용한다 (싱글톤 패턴임=  객체를 메모리에 딱 하나만 생성함.

//✨4. 세션에 접근해서 url을 입력을 하자 ( dataTask with: completionHandler )  메소드 선택
//dataTask : 데이터를 받아서 처리해야하기 때문에 completionHandler를 사용한다. <- 이게 있는 메소드를 선택하자
//session.dataTask 는 보통 task 변수에 넣어준다.
let task = session.dataTask(with: structURL) {  Data, URLResponse, Error in
    //with: URL 을 가지고 작업을 한 후 Data, URLResponse,Error 를 리턴한다.  ( http  메세지를 날리고, 서버에서 http 메세지를 반환하면 받는다.
    //Data
    //URLResponse
    //Error 를 파라미터로 받는다.
    
    //일반적으로 에러처리를 먼저한다.
    if Error != nil {
        print(Error!)
        return
    }
    if let safeData = Data {   //data 가 optional 일 수도 있으니까 optional을 벗겨준다.
        //swift how to print data as String 검색! 데이터를 string으로 출력하는 방법을 검색해서 붙여넣기 하자.
        print(String(decoding: safeData, as: UTF8.self))
    }
}.resume()    //resume을 이렇게도 사용이 가능하다.

//task가 보통 멈춤 상태에서 시작하기 때문에,  resume 메소드를 추가해준다. ( resume = enter를 쳐야 시작 )
//task.resume() ⭐️ 중요!!!
