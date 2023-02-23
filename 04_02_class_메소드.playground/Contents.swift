import UIKit

// 인스턴스 메소드---------------------------------------------------------------------------------------------
// 클래스의 인스턴스 메소드
// 구조체의 인스턴스 메소드 : 구조체에서는 인스턴스 메소드 내에서 속성을 수정할 수 없다. -> 수정하기 위해서는 mutating 키워드를 붙여줘야 한다.

class DogClss{
    var name : String
    func sit(){
        print("class에서 \(name) 앉아! ")
    }
    init(name : String){
        self.name = name
    }
    func changeNm(newNm name: String){  //mutating 없어도 바꿀 수 있음.
        self.name = name
    }
}


struct DogStr{
    var name : String
    var weight : Int
    
    func sit(){
        print("struct에서 \(name) 앉아!!! ")
    }
    mutating func changeName(newNm name : String){   //name 속성을 수정하기 위해서는 mutating을 붙여줘야 한다.
        self.name = name
    }
}
//!! 생각해보면
//class에서는 데이터를 힙에 저장하고,
//struct에서는 데이터를 stack 에 저장하기 때문에 바꿀 수 없는 것이 당연하다!

var dog11 = DogStr(name: "벼리", weight: 6)
dog11.changeName(newNm: "벼리2")
dog11.sit()

var dog12 = DogClss(name: "벼리클래스1")
dog12.changeNm(newNm: "벼리클래스2")
dog12.sit()


//타입 메소드---------------------------------------------------------------------------------------------
//타입메소드 : 붕어빵 틀 자체에 속해있는 메소드
//static 또는 class 가 붙은 타입 메소드는 타입 저장 속성에 접근이 가능하다.
class typeDog{
    static var species = "Dog"
    
    //type메소드 (class 나 static을 붙인 메소드)
    class func whatSpecies(){
        print("개의 종은 \(typeDog.species) 입니다. ")
    }
}

typeDog.whatSpecies()


//타입메소드는 class가 붙은 타입메소드일 경우 상속이 가능하다.
class motherClass{
    class func motherMethod(){     //class 타입메소드이기때문에 상속 가능함.
        print("타입과 관련된 공통된 기능 구현")
    }
}

motherClass.motherMethod()

class childClass : motherClass{
    override class func motherMethod() {      //motherClass의 메소드를 childClass가 상속받음.
        print("타입과 관련된 공통된 기능 구현( 업그레이드) ")
    }
}

childClass.motherMethod()


//서브스크립트 ------------------------------------------------------------------------------------------------
//서브스크립트란? 대괄호를 사용하여 접근 가능한 문법을 말한다. ex. array[0] / dictionary["A"]
//인스턴스 메소드로서 서브스크립트 구현 : 1. 이름은 subscript, 메소드 형태이다.
//                              2. 계산속성과 비슷한 형태이다( getter, setter가 있음)
class SomeData{
    var datas = ["ios", "swift", "mon", "tues"]
        
    subscript(i: Int) -> String{   //func 없이. subscript라고 이름을가짐. 파라미터를가짐(i : 타입)
        get{
            return datas[i]
        }
        set(param){                //set 블록 없이 read-only로만도 구현 가능하다.
             datas[i] = param
        }
    }
}

var d = SomeData().datas
d[0]
d[0] = "new"

//타입 서브스크립트 - 클래스, 구조체, 열거형
//타입 서브스크립트 이용시 열거형의 예시

enum Week: Int {                                                // 열거형 week 을 원시값 int 로 생성한다.
    case weekday = 1, mon, tues, wednes, thurs, fri, sat, sun  // 열거형의 case data를 나열한다.
    
    static subscript(n : Int )->Week{                       // 타입 서브스크립트를 선언한다. 리턴타입은 week으로 한다.
        return Week(rawValue: n)!                           //rawValue에 따른 열거형 타입을 리턴한다. ( optional 삭제 필수)
    }
}

let whichday = Week[4]
print(whichday)   //wednes



//접근제어------------------------------------------------------------------------------------
//private 키워드를 통해서 접근 제어를 할 수 있다.
class SomeClass{
    private var name = "이름"
    
    func changeName(name : String){
        self.name = name
        print(self.name)
    }
}

var c = SomeClass()
//c.name = "벼리" private 이기 때문에 바로 접근이 불가능하다.
c.changeName(name: "벼리")

















