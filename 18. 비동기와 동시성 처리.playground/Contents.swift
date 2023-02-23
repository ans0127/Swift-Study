import UIKit
import Foundation
import PlaygroundSupport

//비동기작업으로 인해 플레이그라운드 모든 작업이 끝났다고 인식하지 않도록 사용 - 작업 중간에 멈추지 못하게 하기 위함
PlaygroundPage.current.needsIndefiniteExecution = true


/*==============================================================================
 ✨✨✨✨동기 vs 비동기
 ==============================================================================*/
func task1( ){
    print("task 1 시작")
    print("task 1 종료------>")
}
func task2( ) {
    print("task 2 시작")
    print("task 2 종료------>")
}
func task3( ){
    print("task 3 시작")
    print("task 3 종료------>")
}
//task1( )
//task2( )
//task3( )

func task4(){
    print("task 4 시작")
    sleep(2)
    print("task 4 종료------>")
}
func task5(){
    print("task 5 시작")
    sleep(2)
    print("task 5 종료------>")
}
func task6(){
    print("task 6 시작")
    sleep(2)
    print("task 6 종료------>")
}
//비동기처리를 하지않으면 모두 출력시 6초정도 걸림
//task4()
//task5()
//task6()


//✨비동기 처리 방법
//DispatchQueue.global().async ( globalQueue를 생성하고, Queue로 보낸다. ) 사용하면 된다.
//비동기는 기다리지 않기 때문에 뭐가 먼저 출력될 지 알수 없다. 미리 처리되는 것들이 먼저 출력됨
print("1")
//DispatchQueue.global().async {
//    task4()
//}
//DispatchQueue.global().async {
//    task5()
//}
//DispatchQueue.global().async {
//    task6()
//}
print("2")


//DispatchQueue.global().async 는 하나의 묶음이기 때문에, 안에 들어있는 것들은 통으로 한번에 출력된다.
DispatchQueue.global().async {
    //하나의 묶음이기 때문에 순서대로 출력될 수 밖에 없다.
    print("DispatchQueue 안에서 시작 1 ")
    print("DispatchQueue 안에서 시작 2 ")
    print("DispatchQueue 안에서 시작 3 ")
    print(" 종료  ")
}


//비동기적인 함수의 정의
func task7(){
    DispatchQueue.global().async {
        print(" 비동기적 함수의 실행 ! ")
         }
}
/*==============================================================================
 ✨✨✨✨직렬 (Serial) & 동시 (Concurrent)
 ==============================================================================*/
//직렬 큐 만드는 방법
let serialQueue = DispatchQueue(label: "serial")   //문자열은 개발자 마음대로 쓴다.
//직렬큐이기 떄문에 task가 비동기적이다 하더라도 순서대로 출력됨
serialQueue.async {
    //task1()
}
serialQueue.async {
   // task2()
}
serialQueue.async {
   // task3()
}

//동시큐
let concurrentQueue = DispatchQueue.global()
concurrentQueue.async {
//    task1()
}
concurrentQueue.async {
//    task2()
}
concurrentQueue.async {
//    task3()
}

/*==============================================================================
💠💠큐( Queue) 의 종류💠💠
 1. 메인큐
 2. 글로벌큐
 3.커스텀큐
 ==============================================================================*/

//1. 메인큐
let mainQueue = DispatchQueue.main

//2. 글로벌큐
//6가지의 Qos를 가지고 있음 (default 글로벌 큐나 유틸리티 큐를 주로 사용)
let defaultQueue = DispatchQueue.global()
let defaultQueue1 = DispatchQueue.global(qos: .default)
let backgroundQueue = DispatchQueue.global(qos: .background)
let unspecifiedQueue = DispatchQueue.global(qos: .unspecified)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let utilityQueue = DispatchQueue.global(qos: .utility)

//3.커스텀큐
//기본 설정은 serial, 단, concurrent로 설정도 가능하다
let privateQueue = DispatchQueue(label: "mySerialQueue")



/*==============================================================================
✨✨✨✨ GDC  사용시 주의사항 ✨✨✨✨
 1. UI  관련 작업은 메인스레드에서 한다.
 2.⭐️비동기함수는 return이 아닌 콜백함수를 사용해야 한다.
        1.  return이 아닌 콜백함수를 사용해서 끝나는 시점을 알려줘야 한다.
            [=> return 을 사용하면 안되는 이유?
                    :메인스레드에서 다른 스레드로 작업을 시키고, 바로 return해버리기 때문에 무조건 nil로 반환된다. 따라서 콜백함수를 사용해서 작업이 끝나는 시점을 전달받아야 한다.]
        2. 컴플리션해들러의 존재 이유?
 3. weak, strong 캡처 주의
 ==============================================================================*/

//⭐️1. UI  관련 작업은 메인스레드에서 한다.
var imageView : UIImageView? = nil

let url = URL(string: "https://bit.ly/32ps0DI")!

/*URLSession자체가 내부적으로 globalQueue안에서 동작하고 있기 때문에 UI작업을 할 때는 mainQueue에서 작업하도록 해준다.*/

URLSession.shared.dataTask(with: url){ (data, response, error) in
    if let error = error{
        print("에러있음")
    }
    guard let imageData = data else { return }
    
    //데이터를 가지고 이미지로 변환
    let photoImage = UIImage(data: imageData)
    
    // UI관련 작업은 DispatchQueue.main  에서 한다.
    DispatchQueue.main.async {
        imageView?.image = photoImage
    }
}.resume()


//2.⭐️비동기함수는 return이 아닌 콜백함수를 사용해야 한다.
//일반적으로, 콜백함수의 함수명을 💎completionHandler💎 라고 칭한다.
//1. func properlyGetImages(with urlString : String 를 실행을 하고,
//2. 실행하고 나온 값으로 callback 클로저 함수를 실행하겠다.
func properlyGetImages(with urlString : String, completionHandler: @escaping (UIImage? ) -> Void) {
    let url = URL(string: urlString)!    //urlString어디서 가져왔지..
    
    var photoImage: UIImage? = nil
    
    URLSession.shared.dataTask(with: url) { (data, response, error ) in
        if error != nil{
            print("에러있음 : \(error!)")
        }
        //옵셔널 바인딩
        guard let imageData = data else { return }
        
        //데이터를 UIImage 타입으로 변형
        photoImage = UIImage(data: imageData)
        
        //콜백함수실행
        completionHandler(photoImage)
    }.resume()
}


//실행
properlyGetImages(with: "https://bit.ly/32ps0DI") { image  in
    DispatchQueue.main.async {
        
    }
}


//⭐️3. 비동기함수 사용시 메모리누수가 생길 수 있기 때문에 weak self를 주로 사용한다.
class ViewController : UIViewController {
    var name: String = "비동기 뷰컨트롤러!!"
    
    func doSomething(){
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }  //self 가 nil 이면 guard문에서 바로 return해버려서 출력이 안됨
            sleep(3)
            print("글로벌큐에서 출력하기 : \(weakSelf.name)")  //self(ViewController) 가 사라졌으면 print 안함
        }
    }
    deinit{
        print("\(name) 메모리 해제 ")
    }
}

func localScopeFunction1(){
    let vc = ViewController()
    vc.doSomething()
}

localScopeFunction1()
//비동기 뷰컨트롤러!! 메모리 해제 만 출력되어야한다.

//⭐️4.동기함수를 비동기함수로 변형
// -- 동기함수 --
func longtimePrint(name: String) -> String{
    print("프린트 - 1")
    sleep(1)
    print("프린트 - 2")
    sleep(2)
    print("프린트 - 3")
    sleep(3)
    print("프린트 - 4")
    sleep(4)
    return "작업종료"
}

// -- 비동기함수 --
//return형이 있는 경우에는 출력값 전달하기 위해서 closure 로 설계를 한다 ( 함수명은 completionHandler)
func asyncLongtimePrint(name : String, completionHandler: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        let n = longtimePrint(name: name)
        completionHandler(n)
    }
}


asyncLongtimePrint(name: "잡스"){ (result) in
    print(result)
}
//< 비동기적으로 구현된 메소드 >
// URLSession : 내부적으로 비동기로 처리되어있다. 무조건 다른 스레드로 task를 보낸다.( 기다리지 않는다.)


/*==============================================================================
Async/ Await
 ==============================================================================*/
func longtimePrint(completionHandler: @escaping (Int) -> Void){
    //기존에는 이렇게 비동기적으로 처리
    DispatchQueue.global().async {
        print("aync/await 프린트 1 ")
        sleep(1)
        print("aync/await 프린트 2 ")
        sleep(1)
        print("aync/await 프린트 3 ")
        sleep(1)
        print("aync/await 프린트 4 ")
        completionHandler(7)
    }
}

//기존의 들여쓰기의 불편함이 있는 코드
func linkedPrint( completionHandler : @escaping (Int) -> Void){
    longtimePrint { num in
        longtimePrint { num in
            longtimePrint { num in
                longtimePrint { num in
                    completionHandler(num)  //모든 비동기 함수의 종료시점
                }
            }
        }
    }
}

//async/ await  사용한 코드==============================================
//async를 붙이면 알아서 비동기 코드로 변환하겠다 하는 것.
func longtimeAsyncAwait() async -> Int{
    print("aync/await 프린트 1 ")
    sleep(1)
    print("aync/await 프린트 2 ")
    sleep(1)
    print("aync/await 프린트 3 ")
    sleep(1)
    print("aync/await 프린트 4 ")
    return 7
}

//실제 실행 함수(ex. longtimeAsyncAwait())  앞에 await를 붙여서 함수 종료까지 기다려줌.
func linkedPrint2() async -> Int{
    _ = await longtimeAsyncAwait()
    _ = await longtimeAsyncAwait()
    _ = await longtimeAsyncAwait()
    _ = await longtimeAsyncAwait()
    _ = await longtimeAsyncAwait()
    return 7
}

print("⭐️Thread-safe 하도록 처리하는 방법⭐️ ")
//⭐️Thread-safe 하도록 처리하는 방법⭐️
//동시큐에서 직렬큐로 보내기
//배열은 여러 Thread에서 동시에 접근하면 문제가 발생할 수 있다.
var array = [String]()

let serialQueue1 = DispatchQueue(label: "serialQ")

for i in 1...20 {
    DispatchQueue.global().async {
        print("\(i)")
        array.append("\(i)")      // <- 동시큐에서 실행하면 여러 스레드에서 동시에 메모리에 접근해서 원하는 출력이 제대로 안될 수 있다.
        
//        serialQueue.async {    //serialQueue 로 보내서 thread-safe 하도록 처리해준다.
//            array.append("\(i)")
//        }
    }
}


DispatchQueue.main.asyncAfter(deadline: .now() + 5){
    print(array)
}
