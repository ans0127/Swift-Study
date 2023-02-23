import UIKit

//클래스의 상속
//swift는 다중상속이 불가능하다.
//final = 상속 금지시키는 키워드 .

class Person{
    final var id = 0 //재정의가 불가능하다.
}

class Student : Person{
    var email = "email"
}

class Undergraduate : Student{
    var name = "name"
//    override id = 1   //final 키워드가 있어서 재정의가 불가능하다.
}

var u = Undergraduate()
u.id //상속받았기 때문에 data 사용 가능

//------------------------------------------------------------------------
//override : 클래스의 상속
//overload : 다형성

class Dog{
    func bark(){
        print("벼리는 귀여워")
    }
}

class CuteDog : Dog{
    override func bark(){
        super.bark()        //부모클래스.함수 를 호출할거야.
        print("벼리는 엄청 귀여워")
    }
}

var d = CuteDog()
d.bark()




//------------------------------------------------------------------------
class Cat{
    //저장속성
    var name = "벼리"
    //메소드
    func miao(){
        print("벼리가 야옹")
    }
}

class CuteCat : Cat{
    
    //저장속성을 재정의하는것은 불가능.
    //    override var name = "벼리야옹"
    
    //하지만, 부모의 저장속성을 계산속성으로 재정의 하는 것은 가능
    override var name : String {
        get{
            return ("벼리앙앙")
        }
        set{
            super.name = newValue // self.name 은 사용불가능.
        }
    }
        
    //메소드는 재정의 가능.
    override func miao(){
        super.miao()  //벼리가 야옹
        print("벼리가 야옹 두번 ")
    }
}


//subscript도 재정의가 가능하다.
class Rabbit{
 
    var data = ["벼리1", "벼리2", "벼리3", "벼리4" ]
    //subscript
    subscript(i : Int) -> String{
        get{
            return data[i]
        }
        set{
            data[i] = newValue
        }
    }
}

var r = Rabbit()
r.data[3] = "토끼벼리"
r.data



class CuteRabbit : Rabbit{
    //subscript
    override subscript(i: Int) -> String {
        get{
            return super[i]  //super 의 subscript를 호출한다.
        }
        set{
            super[i] = newValue
        }
    }
}

var rr = CuteRabbit()
rr.data
rr.data[1] = "깡총벼리"
rr.data


//초기화---------------------------------------------------------------
//1. 클래스의 초기화
class Color{
    var red : Int
    var green : Int
    
//저장 속성에 기본값을 지정하면 자동으로 init() 이 생성된다.
//    var red : Int = 1
//    var green : Int =2
    
    //기본값을 지정하지 않고  init()으로 초기화를 하지 않으면 에러난다.
    init(){
        red = 1
        green = 2
    }
    //생성자도 overloading이 가능하다.
    init(white : Int){
        red = white
        green = white
    }
    //생성자도 overloading이 가능하다.
    init(black : Int , yellow : Int){
        red = black
        green = yellow
        
    }
}

//2.구조체의 초기화-----------------------
//구조체struct 에서는 "멤버와이즈 이니셜라이저" 를 제공한다.
//"멤버와이즈 이니셜라이저" 란? 기본값을 지정하지 않아도 자동으로 init()이 생성되어 초기화된다.
struct ColorStruct{
    var red : Int
    var green : Int
}

//클래스는 기본값 없이init() 이 없으면 에러남
//class ColorClass{
//    var red : Int
//    var green : Int
//}


//----------   class 의 생성자    --------------------------------------------------
//지정생정자 Designated vs 편의생성자 convenience
//일반적인 생성자를 지정생성자라고 한다.
//편의생성자 : 개발자가 붕어빵 찍어낼 때 더 편하게 찍어내도록해주는 것(원래 편의생성자 사용이 더 올바른 방식이다. )
        // 1) convenience init() 으로 시작해야 한다.
        // 2) 편의생성자는 self.init 을 통해서 지정생성자를 호출해야 한다.
//이 class 작성 방식이 올바른 방식이다.
class Zoo{
    var cat : Int
    var dog : Int
    var rabbit : Int
    
    //편의생성자
    convenience init(){
        self.init(cat : 0, dog: 0, rabbit: 0)
    }
    //편의생성자
    convenience init(bird : Int){
        self.init(cat : bird, dog : bird, rabbit : bird)
    }
    //지정생성자 : 모든 속성을 초기화.
    init(cat : Int, dog : Int, rabbit : Int){
        self.cat = cat
        self.dog = dog
        self.rabbit = rabbit
    }
}

//class 상속에서의 지정생성자와 편의생성자------------------------------------------------
class AClass{
    var a : Int
    var b : Int
    
    //지정생성자
    init( a: Int, b: Int ){ //----------[5]
        self.a = a
        self.b = b
    }
    
    //편의생성자가 지정생성자를 호출
    convenience init(){
        self.init(a: 0, b: 0)
    }
}

class BClass: AClass{
    var c : Int
    
    //subclass 의 지정생성자 : subclass 초기화 되는 시점
    init(a: Int, b: Int, c: Int) { //-----[3]
        self.c = c      //c에 기본값을 넣어줌.
        super.init(a: a, b: b)  //상위 지정생성자 호출 ----[4]
    }
    
    convenience init(c: Int){
        self.init(a: 0, b: 0, c: c) // a,b,c 를 파라미터로 갖는 지정생성자 호출 -----[2]
    }
    
    convenience init(){
        self.init(c: 0) //c만을 파라미터로 갖는 편의생성자 호출 --- [1]
    }
}



//생성자의 상속 & 재정의 ---------------------------------------------------------------------------------------
/**생성자 상속 시 고려해야 할 사항 2가지
 
 1. 상위 클래스에 어떤 지정 생성자가 있는지 확인하기.
  - 상위 지정 생성자   - 1. 하위 클래스에서 지정 생성자로 생성 가능(재정의)
  -                            - 2. 하위클래스에서 편의 생성자로 생성 가능(재정의)
 
 
 2. 하위 클래스에서 생성자 구현하기
   - 지정 생성자 안에 1. 클래스의 모든 저장 속성을 초기화해야 한다.
                2. 상위클래스의 지정 생성자를 호출해야 한다.
   - 편의 생성자 안에 1. 현재 클래스의 지정 생성자를 호출해야한다.
 */

//apple 공식 문서 예제
class Vehicle{
    var numOfWheels = 0
    
    var description: String {   //계산속성 정의
        return "There is/(are) \(numOfWheels) wheel(s)"
    }
//    init(){} //기본값에 의해 선언되어있음.
}

class Bicycle: Vehicle{
    override init() {
//        numOfWheels = 4 // 메모리 찍어내기 전에 값을 할당하려고 해서 에러남
        super.init()  // super 클래스의 생성자를 호출해서 메모리를 찍어 낸 후
        numOfWheels = 4 // 값 할당 가능.
    }
}

class HoverBoard : Vehicle{
    var color : String
    
     init(color: String){
        self.color = color  // HoverBoard 클래스의 저장속성 초기화
        super.init()        //상속받은 상위 클래스의 생성자 호출해서 메모리 찍어냄
    }
    
//    override init() {
//        self.color = "red"
//        super.init()
//    }
    
    override convenience init() {
        self.init(color: "blue")  // 현재 클래스의 지정생성자 호출해줌.
    }
}




//필수생성자 : Required init() ------------------------------------------------------------
//필수생성자 사용 이유: UIView같은 class를 상속받아서 사용할 때 필수생성자를 자동으로 swift가 생성해준다.(필수생성자를 반드시 구현해 주어야 한다.)
class ParentClass{
    var x : Int
    required init(x: Int){
        self.x = x
    }
}

//부모클래스에서 필수생성자를 생성하면 자식클래스에서도 무조건 필수생성자를 구현해야 한다. - 자식클래스에서 override 키워드는 필요 없다.
class ChildClass : ParentClass{
    required init(x: Int) {   //다른 지정생성자를 구현하지 않으면 이 필수생성자를 생략해도 swift가 자동으로 필수생성자를 생성해준다.
        super.init(x: x)
    }
}




//실패가능 생성자 : 인스턴스 생성에 실패할 가능성이 있는 생성자 ------------------------------------------------
//실패가 불가능하도록 만들어서 앱이 꺼지는 것을 방지한다.
//생성자에 ? 를 붙인 형태 ==> init?(name: String)
//ex. 인스턴스를 찍어내는 것에 실패했을 때 nil을 리턴하도록 구현함.

struct Byuri{
    let bark: String
    
    //실패가능 생성자
    init?(bark: String){
        if bark.isEmpty{
            return nil //실패 가능 부분에 return 할 수 있는 것은 nil뿐이다.
        }
        self.bark = bark
    }
}

var bbyy = Byuri( bark: "앙앙") // 인스턴스 생성
var bbyy2 = Byuri( bark: "")  //인스턴스 생성 실패 nil반환


//***실패불가능 생성자는 실패가능 생성자를 호출할 수 없다. ***
//실패가능의 경우 nil을 포함하고 있어서 범위가 더 크기 때문에 실패불가능 생성자가 호출할 수 없다.


//소멸자----------------------------------------------------------------------------
//생성자에 반대되는 개념 . deinit{ } : 인스턴스가 메모리에서 사라질 때 필요한 내용을 구현하는 메소드.
//소멸자를 왜 사용할까? 객체가 사라지는지 확인 할 때 deinit을 사용함.
//클래스에서 하나의 소멸자만 존재할 수 있다.
class Kimbyuri{
    var a = 0
    var b = 0
    
    deinit{
        print("메모리에서 김벼리가 사라졌습니다!") //메모리에서 인스턴스가 사라질 때 호출됨
    }
}

var k : Kimbyuri? = Kimbyuri()  //인스턴스 생성

k = nil   // 인스턴스에 nil 을 할당해서 메모리에서 인스턴스가 사라지도록함. 따라서 deinit호출됨.












