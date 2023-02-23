import UIKit

//싱글톤 패턴----------------------------------------------------------------------------------------------
//싱글톤 패턴이란? 앱 구현시 앱이 종료될 때까지 유일하게 하나만 존재하는 객체만 다뤄야 할 때 사용한다. (유일하게 하나만 메모리에 있어야 함)
//private init() 을 통해 새로운 객체 추가 생성을 막을 수 있다.
class Singleton{
    
    static let shared = Singleton()  //<<형태암기! : 자신의 객체를 생성해서 전역변수로 선언
    var userId = "ans0127"
    private init(){}  //private init로 초기화를 선언하면 추가로 객체를 생성할 수 없다. < 일반적인경우 붙여준다!
    
}

//싱글톤 패턴은 접근시 메모리에 할당되는, lazy하게 동작한다.
Singleton.shared

let sgl = Singleton.shared
sgl.userId
sgl.userId = "mhj5601"
sgl.userId


let sgl2 = Singleton.shared // 동일한 메모리 주소를 가리키고 있기 때문에 같은 값이 나온다.
sgl2.userId


let sgl3 = Singleton.shared
sgl3.userId


//새로운 객체 생성. 하지만 객체는 유일하기 때문에 선언된 ans0127을 가져온다.
//let newSgl = Singleton()
//newSgl.userId



//싱글톤 패턴을 사용하는 예시 !!-----------------
let screen = UIScreen.main //화면을 관리하는 유일한 객체
let fileManager = FileManager.default  // 등 ..


