import UIKit

//프로토콜이란? 규약/협약이라는 뜻.  - 자격증의 기능.
//프로토콜이 왜 필요할까? - "클래스 상속의 단점"을 보완하기 위해 사용된다!
//                     상속의 단점: 자식클래스가 부모클래스의 필요없는 기능을 받을 수 있다.


//상속의 단점의 예시-------------------------------------------------------------------
class Bird{
    var isFemale = true
   
    func layEgg(){
        if isFemale{
            print("알을 낳는다.")
        }
    }
    
    func fly(){
        print("날아간다. ")
    }
}

class Penguin: Bird {
    //layEgg()
    //fly()        // <----  Bird를 상속하기 때문에 팽귄이 알을 낳게 됨. (무조건적인 멤버 상속의 단점)
    func swim(){
        print("헤엄친다")
    }
}


//프로토콜의 사용----------------------------------------------------------------------
//fly()기능을 따로 분리해서, 상속을 하지 않고도 기능을 사용하도록 하자.

//fly()기능을 따로 분리
protocol CanFly{
    func fly()  //프로토콜은 구체적인 구현은 하지 않는다.  구체적인 구현은 프로토콜은 채택한 클래스에서 한다.
}



//상속할 클래스, 채택할 프로토콜을 동시에 받을 때
//클래스는 다중상속이 불가능하기 때문에 자동으로 ":" 뒤 처음에 작성한 것이 상속받을 클래스, 두번째 작성한 것이 프로토콜이 된다.
class Aclass{
    func takeClass(){
        print(" a 수업듣기")
    }
}

class Bclass : Aclass, CanFly{
    func fly() {
       print("fly()의 구체적인 구현은 프로토콜을 채택한 Bclass에서 한다. ")
    }
}

//프로토콜 문법 ----------------------------------------------------------------------
/**
 1. 프로토콜을 정의한다.
 2. 프로토콜을 채택한다. ( 클래스, 구조체, 열거형 모두에서 채택이 가능하다.)
 3. 프로토콜의 구체적인 구현을 해준다.
 */



//프로토콜 [[속성]] 의 요구사항
/**===========================================================================================
 0. 프로토콜은 최소한의 요구사항만 정의해 놓은 곳이다! ( 자격증 취득의 자격요건! )
 1. 프로토콜의 속성은 var 만 사용 가능하다. ( let 안됨 )         - 최소한의 요구사항만 정의하는 것이기 때문에 속성이라는 의미에서  var를 사용한다.
 2. get, set 을 이용해서 읽기,쓰기 여부를 설정한다.
 ===========================================================================================
 */
protocol remoteControl{
    
    //저장속성 : var / 계산속성 : get, set   (var 일 경우 변수가 변할 수 있으니까 get(읽기), set(쓰기) 모두 됨)
    //저장속성 : let / 계산속성 : get   (let 일 경우 변수가 불변이라 get(읽기)만 됨.)
    var id : String {get}
    
    // 저장속성 : var / 계산속성 : get, set
    var name : String { get set}
    
    //static = 타입 속성으로 구현해야 한다.( 최소한의 요구사항은 타입저장속성으로 구현해라, 라는 뜻! class를 사용할 수도 있다.)
    //static : 타입저장속성
    //class :  타입계산속성 - 타입계산속성을 사용할 경우 class 라는 키워드를 붙여도 상관없다! - 재정의 가능하다.
    static var type : String { get set}
}


struct TV : remoteControl{
    let id : String = "AC remote control 0001"
    var name : String = "AC remote control"
    static var type : String = "r/c"
}

let myTv : TV = TV()
myTv.id
myTv.name
TV.type


//프로토콜 [[메소드]] 의 요구사항
/**===========================================================================
 0. 메소드의 헤드부분( 메소드이름. 인풋, 아웃풋)만 정의하면 됨.
 1. mutating 키워드 :  구조체에서 프로토콜을 채택할 경우, 구조체에서 저장속성을 변경하고 싶은 경우 붙임
 2. statidc 키워드 : 타입 메소드로 제한하고 싶은 경우 붙임.
 =============================================================================
 */

protocol RandomNum{
    func random() -> Int         //0.
    mutating func doSomething()  //1.
    static func reset()          //2. RandomnNum 프로토콜을 채택해서 사용하는 곳에서 최소 타입 메소드가 되어야 함.
}

struct Num: RandomNum {
    var name = "벼리"
    func random() -> Int {
        return Int.random(in: 1...100)
    }
    mutating func doSomething() {
        self.name = "벼리"  //struct 에서 저장속성을 바꾸고 싶을 때 mutating 사용
    }
    static func reset() {
        print("reset")
    }
}

//열거형에서의 프로토콜 사용 -----------------------------------------------------------------
//열거형 타입에서 프로토콜을 받아서 사용할 경우, 저장속성의 값을 변경하고 싶을 경우 mutating 키워드를 붙여야 한다.
//(열거형도 구조체처럼 값 타입 이니까!)
protocol Toggle{
        mutating func toggle()
    
}

//mutating 사용
enum OnOff : Toggle{
    case on
    case off
    
    mutating func toggle() {
        switch self{
        case.off:
            self = .on
        case.on:
            self = .off
        }
    }
}

var onoff = OnOff.on
onoff.toggle()


//class이기때문에 mutating 필요없는 경우의 예시
class MySwitch : Toggle{
    var isOn = false
    
    func toggle() {
        isOn = isOn ? false : true   //삼항연산자 사용
    }
}


var mys = MySwitch()
print(mys.isOn)   //false
mys.toggle()
print(mys.isOn)   //true



//프로토콜에서 [[ 생성자 ]] 의 요구사항----------------------------------
/**========================================================================
 0. 클래스는 필수생성자 ( required init( ) )를 필수로 생성해야함. - ( 구조체의 경우 상속이 없기 때문에 필수생성자 필요없음)
 1. final class Aclass{ }  로 상속을 막는다면 required init() 이 필요없음.
 2. 클래스에서 편의생성자( required convenience init() )로 작성가능.
 ==========================================================================
 */

//class 예제
protocol Aprotocol {
    init(no : Int)
}

//0. 클래스는 필수생성자를 생성해야 한다.
class Proclass : Aprotocol{
    required init(no: Int) {
        
    }
}

class BProclass : Proclass{
    required init(no: Int) {
        super.init(no: <#T##Int#>)  //class 를 상속받았기 때문에 super class의 생성자 호출
    }
}
//2. 클래스에서 [convenience required init] 으로 생성자 구현도 가능하다.
class Conclass : Aprotocol{
    convenience required init(no: Int) {
        self.init()   //편의생성자로 구현했기 때문에  self.init을 붙여야 한다.
    }
}
// 1. final class일 경우 required 가 필요없다.
final class Finalclass : Aprotocol{
    init(no: Int) {
//
    }
}
//0. 구조체는 필수생성자가 필요없다.
struct Strclass : Aprotocol{
    init(no: Int) {
//
    }
}


//( 생성자 중 ) 실패가능 생성자의 경우------------------------------------------------------------------------
/**=================================================================================
   * 실패불가능 생성자의 경우
    - init?()   -> init(), init?(), init!() 로 구현가능          //ex. nil + int -> int 가능. (넓은범위 -> 좁은범위)
    - init()     -> init?()로 구현불가능.                          //ex.  int > nil + int 불가능 (좁은범위 -> 넓은범위)
 =================================================================================
 */
//int?() -> int() 가능 ------------------------------------
protocol Apro{
    init?(name : String)
}

struct Strpro01 : Apro{
//    init(name: String){ }     //가능
      init?(name: String){ }    //가능
}


//int() -> int?() 불가능 ------------------------------------
protocol Bpro{
    init(id : String)
}

struct Strpro02 : Bpro{
//    init?(id: String){ }      //  (int) -> (nil + int)불가능.
    init(id: String) { }
}







//서브스크립트 메소드의 요구사항 ------------------------------------------------------------------------
//get, set 키워드를 통해서 읽기/쓰기 여부를 결정한다.
protocol List{
    subscript(i : Int)-> Int { get }
}

struct Strlist : List{
    subscript(i: Int) -> Int {
        get{
            return 7
        }
    }
}

var sl = Strlist()
sl.self

print("1")

//*********************************************************************************************************
//보통 프로토콜을 채택해서 사용할 때는 확장( Extension ) 을 사용한다.***************************************************
protocol Mypro{
    func myfunc()
}

class Yourpro{
}

extension Yourpro : Mypro{
    func myfunc(){
        print("yourpro")
    }
}
//*********************************************************************************************************
//*********************************************************************************************************





//타입으로써의 프로토콜--------------------------------------------------------------------------
//프로토콜 : swift 에서 "타입"이다.
//변수를 프로토콜 타입으로 선언할 수 있다.
//프로토콜 타입으로 선언할 경우, 프로토콜에 있는 함수만 호출할 수 있다.

protocol Remote {
    func on()
    func off()
}

class AC : Remote{
    func on() { print("벼리가 에어컨 키기")}
    func off() { print("벼리가 에어컨 끄기")}
    func wash() { print("벼리가 에어컨 청소하기")}
}

class TVV : Remote{
    func on() { print("벼리가 tv 키기")}
    func off() { print("벼리가 tv 끄기")}
    func sleep() {print("벼리가 tv 킨채로 자기. ") }
}

var acc : Remote = AC()
acc.on()
//acc.wash()    //프로토콜 타입이기 때문에 프로토콜에 있는 함수만 호출 가능하다.

var tvv : TVV = TVV()
tvv.sleep()

//프로토콜을 타입으로 취급 했을때의 장점?---------------------------------------------------------------------
//0. 프로토콜에 있는 메소드를 호출해서 사용 가능하다.
//1. 함수의 타입으로도 프로토콜을 사용할 수 있다.

//0. - 프로토콜 타입을 사용해서 타입을 한 배열 안에 담을 수 있다.
var remoteList : [Remote] = [acc, tvv] //프로토콜 형식으로 담겨있다.
for myremotelist in remoteList {
    myremotelist.on()           //Remote 에 있는 메소드를 호출해서 사용 가능하다.
}

//1.
func turnOnMachine(machine : Remote){   //함수의 타입으로써의 사용
    machine.on()
}
turnOnMachine(machine: acc)
turnOnMachine(machine: tvv)


//프로토콜의 상속 (간단하다) - 실제로 개발할 때 프로토콜의 상속을 사용하는 경우는 거의 없다.--------------------------------------
//0.프로토콜은 상속이 가능하다.
//1.프로토콜은 다중상속이 가능하다.



//프로토콜의 합성-----------------------------------------------------------------------------------------------
//프로토콜 두개를 병합해서 [&]로 연결해서 [하나의 타입]으로 인식이 가능하다

protocol Name{
    var name : String { get }
}

protocol Age{
    var age : Int { get }
}

//프로토콜의 다중 상속
struct Person01 : Name, Age {
    var name : String
    var age : Int
}

//프로토콜 두개를 병합해서 사용( & 로 연결 )
func Bday( bdaycomment : Name & Age){
    print("happy b-day \(bdaycomment.name) , \(bdaycomment.age) th B-DAY")
}

var bdayp : Name & Age = Person01(name: "벼리", age: 3)
Bday(bdaycomment: bdayp)


//프로토콜의 선택적 요구사항의 구현----------------------------------------------------------------------
//Attribute 란? '@'를 사용하여, 컴파일러에게 추가적인 정보를 알려주는 역할을 함. (ex. @available(IOS 14.0)  , @escaping ..)

/*구현을 해도 되고, 안해도 되는 멤버를 구현하는 방법=============================
 0. @objc 를 protocol 앞에 붙인다.
 1. @objc optional 을 변수, 또는 함수 앞에 붙인다.
 ( 단, @objc 를 사용하면 구조체, 열거형에서는 채택이 불가능하다. )
 ====================================================================
 */
@objc protocol OptPro{
    @objc optional var isOn : Bool { get }
    var isOff : Bool { get }
    
    @objc optional func doNetflix()
    func turnOn()
    func turnOff()
    
}

//채택받은 class에서 @obj optional 로 작성한 변수, 함수들은 구현을 안해줘도 된다.
class OptProClass : OptPro{
    var isOff: Bool{
        get{
            return true
        }
    }
    func turnOn() {  }
    func turnOff() {  }
}

//✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
//프로토콜의 확장--------------------------------------------------------------------
//프로토콜의 확장을 왜 사용할까?  코드의 중복을 피하기 위해
//프로토콜을 채택한 타입들이 구현 내용이 동일할 때 반복적인 코드를 쓰는 게 귀찮아서, extension protocol{ } 을 통해 메소드 디폴트 구현을 제공한다.

//✨확장 프로토콜의 메소드보다, 기본 구현된 메소드가 우선적으로 호출된다.

protocol Remocon{
    func on()
    func off()
}



//프로토콜을 채택한 곳에서 반복적으로 구현하는 것이 귀찮다.
class Mytv01 : Remocon{
    func on(){ print("Mytv01 : Remocon 켜기") }
    func off(){ print("Mytv01 : Remocon 끄기") }
    func pressAnotherBtn(){ print(" mytv의  다른 버튼 누르기") }
}

class Myac01 : Remocon{
    func on(){ print(" Myac01 : Remocon 켜기") }
    func off(){ print(" Myac01 : Remocon 끄기") }
}

struct Myhome01 : Remocon{
    func on(){ print("Myhome01 : Remocon 켜기") }
    func off(){ print("Myhome01 : Remocon 끄기") }
}





//귀찮음을 해소하기 위해서 프로토콜 확장을 사용 ----> 기본 구현을 제공.-------------------------------------------------------
extension Remocon{  //프로토콜을 확장함.
    func on(){ print("extension Remocon 켜기") }    //원래 class 의 메소드 우선 호출 후 없으면 프로토콜의 메소드 호출
    func off(){ print("extension Remocon 끄기") }
    
    func pressAnotherBtn(){           //타입에 따라 다르게 호출 (* 가본 메소드가 우선이 아님)
        print("extension Remocon 다른 버튼 누르기")
    }
}





print("\n   var mytv01 : Remocon = Mytv01()  //프로토콜 타입으로 동작하게 함.  ----------------------------------------")
var mytv01 : Remocon = Mytv01()
//mytv01.on()
//mytv01.off()
//mytv01.pressAnotherBtn()   //print("extension Remocon 다른 버튼 누르기")   - 우선순위가 아닌 타입에 따른 저장이기 때문에

print("\n  var mytv111 = Mytv01() // 프로토콜 타입을 지정하지 않음. -> 원래의 타입으로 동작하게 함 ----------------------------------------")
var mytv111 = Mytv01()
//mytv111.pressAnotherBtn()    //print(" mytv의  다른 버튼 누르기") }

print("\n var mytv222 : Remocon = Mytv01() ----------------------------------------")
var mytv222 : Remocon = Mytv01()
//mytv222.pressAnotherBtn()    //extension Remocon 다른 버튼 누르기






//-----------------------------------------------------------------------------------------
//프로토콜 확장을 통한 다형성 제공
//💠💠💠 class의 경우
class Ipad: Remocon{
    func on() { print("ipad turn on") }
//  func off() {        }
    func pressAnotherBtn(){ print("아이패드의 또다른 동작")}
}

print("\n\nipad 가 ipad 타입일 때 호출 시 ")
let ipad : Ipad = Ipad()
ipad.on()               //class - virtual table
ipad.off()              //class - virtual table
ipad.pressAnotherBtn()  //class - virtual table
/**======================================================
 class virrual table
 - func on()   :  ipad 의 함수 실횅
 - func off() : Remocon 의 함수 실행 -> ipad 에 구현되어 있지 않기 때문에
 - pressAnotherBtn() : Ipad의 함수 실행
 ======================================================*/




print("\nipad 가 프로토콜 타입일 때 호출 시 ")
let ipad2 : Remocon = Ipad()
ipad.on()               //protocol - witness table
ipad.off()              //protocol - witness table
ipad.pressAnotherBtn()  //protocol - direct dispatch( 직접 메소드 주소를 삽입 )
/**======================================================
   protocol witness  table
 - func on() :  ipad 의 함수 실횅
 - func off() :  Remocon 의 함수 실행 -> ipad 에 구현되어 있지 않기 때문에
 - pressAnotherBtn() : //Remocon 프로토콜의 메모리 주소(예를들어 300이라고하자) 300을 심고, 코드가 실행이 될 때 300번지를 찾아가서(확장 Remocon의 pressAnotherBtn()) 를 실행 = direct dispatch
 ======================================================*/



//💠💠💠 구조체의 경우
struct Iphone : Remocon{
    func on() { print("ipone on ")}
    func pressAnotherBtn(){ print(" iphone 다른 동작")}
}
/*===============================================
 //구조체는 원래 메소드 테이블이 없음. 코드 자체에 메모리 주소를 심어서, 메모리 주소를 찾아가도록 함.
 ===============================================*/

print("\niphone : Iphone --------------------------")
var iphone : Iphone = Iphone()
iphone.on()                 //구조체 - direct
iphone.off()                //구조체 - direct
iphone.pressAnotherBtn()    //구조체 - direct

print("\niphone : Remocon --------------------------")
var iphone2 : Remocon = Iphone()
iphone2.on()                //protocol - witness table
iphone2.off()               //protocol - witness table
iphone2.pressAnotherBtn()   //direct dispatch


// ++++++++ 프로토콜의 형식 제한
// 프로토콜이 프로토콜을 채택해서, 특정 프로토콜을 채택한 경우에만 해당 프로토콜을 사용할 수 있도록 제한을 둘 수도 있다.
// 형태 : [ where Self : 특정프로토콜 ]

protocol Bluetooth{
    func blueOn()
    func blueOff()
}

extension Bluetooth where Self: Remocon{  //Remocon 프로토콜을 채택한 경우에만, 적용을 하겠다.[Bluetooth : Remote] 일 경우메만 적용하겠다.
    func blueOn(){ print("bluetooth on ")}
    func blueOff(){ print("bluetooth off ")}
}

class SmartPhone : Remocon, Bluetooth{
}

print("\n프로토콜의 형식 제한 ------------")
var smt = SmartPhone()
smt.on()
smt.off()
smt.blueOn()
smt.blueOff()
































