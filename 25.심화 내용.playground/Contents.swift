import UIKit

var greeting = "Hello, playground"
/*=====================================================================
 Equatable :  ==,  !=   (동일성비교 프로토콜)
 Comparable : < , >, >=, <= (크기비교 프로토콜1)
 Hashable : 모든 저장 속성을 hashable(값이 유일성을 갖게 됨) 하도록 만드는 메소드 (hash(into:))
 =====================================================================*/





/*=====================================================================
 ✨Equatable
  : 동일성을 비교할 때는 Equatable 를 채택해야 한다.
 ⭐️구조체를 비교할 때 적어도 한번은 "Equatable" 프로토콜을 채택을 해야 한다. ⭐️
 =====================================================================*/
struct Dog{
    var name : String
    var age : Int
}

extension Dog : Equatable{
    
}

let dog1 : Dog = Dog(name: "초코", age: 10)
let dog2 : Dog = Dog(name: "보리", age: 3)

dog1 == dog2
dog1 != dog2







/*=====================================================================
 ✨Comparable
 ⭐️구조체, 클래스에서 Comparable을 채택한 경우라도 "< (less than)"연산자를 구현해야 한다. ⭐️
⭐️ comparable 은 equatable을 상속을 한다.
                            ===>  따라서 , comparable 을 채택할 경우 equatable의 요구사항도 구현도 해줘야 한다.
 =====================================================================*/



/*===========================================================================
 ✨Hashable 프로토콜 : 유일값을 갖도록 해서 , dictionary의 키값 또는 set의 요소가 될 수 있도록 한다.
 요구사항 : func hash(into hasher: inout hasher) 메소드의 구현
 
 ⭐️열거형, 구조체, 클래스에서 Hashable 프로토콜을 채택해서 어떻게 사용할 것이냐?
                ===> func hash(into:) 메소드를 구현해서 사용한다.
 
 hashable 프로토콜은  equatable 프로토콜을 상속받고 있기 때문에 "equatable"프로토콜의 요구사항도 구현해 주어야 한다.
                ===>  " == " 메소드에 대해서 구현해주어야 한다.
 ============================================================================*/



/*===========================================================================
 ✨caseIterable 프로토콜
 열거형이  caseIterable 을 채택하면 자동으로 .allCases 를 구현해준다.
                ==>  .allCases : 열거형의 모든 케이스를 담아서 ⭐️배열로 리턴
⭐️연관값이 있는 경우에는 caseIterable을 따르지 않는다.
                --> 당연함. 여러개의 int를 가진 요소 중 하나가 string이라면 하나의 배열 안에 담는 것이 불가능하다.
 ============================================================================*/
enum CompassDirection : CaseIterable{
    case north, south, ease, west
}

//열거형의 요소의 갯수를 세기 편하다.
print( "동서남북 방향은 \(CompassDirection.allCases.count)")

//배열(.allCases)을 고차함수를 사용해서 string으로 바꿀 수 있다.
let caseList = CompassDirection.allCases
                                                      .map({ "\($0)" })  //["north", "south", "ease", "west"]  하나하나의 요소를 문자열로 변환.
                                                      .joined(separator: ",")   //"north", "south", "ease", "west"
print(caseList)

var randomCompass = CompassDirection.allCases.randomElement()!
print(randomCompass)


/*===========================================================================
 ✨Never 타입과 검증함수 : 실무에서 사용을 하면서 아는 편이 더 쉽다. 이런 것이 있구나 하고 넘어가기
 never 티입 : cpu의 제어권을 돌려주지 않을거야.
 ============================================================================*/
func crash() -> Never{
        //fatalError : never 타입을 가지고 있는 함수
    fatalError("앱 해킹 발견")
}
print("1")
//crash()
print("2")





/*===========================================================================
 ✨디버깅 함수
 1. assert(), assertionFailure() //검증함수       ( 디버그모드 : 출시 전 앱에서만 동작 )
 2. precondition(), preconditionFailure()  //조금 더 심각한 상황에서의 검증함수 ( 앱 출시 후에 동작 )
                    예) 유저가 이전 버전의 앱을 사용하고 있을 경우
 3.fatalError ( 앱을 종료시키는 함수 : 일반적인 상황에서 잘 사용하지 않음)
 
 ⭐️asser 와 precondition 함수의 사용법은 완전히 같음
 ============================================================================*/






/*===========================================================================
 < Objective-C 의 기술 >
 ✨KeyPaht(..) : "문자열"을 가지고 속성에 접근하려는 기술
 ✨selector(..) : 메소드 주소를 통해서 메소드를 가리키기 위한 기술
 ============================================================================*/

//✨KeyPaht(..) : 속성에 접근하기 위해 경로를 미리 생성해서 변수에 넣은 다음 그 변수에 접근하는 방식
class Person{
    var name : String
    init(name : String){
        self.name = name
    }
}

class SmallSchool{
    var classMember : Person
    init(classMember : Person){
        self.classMember = classMember
    }
}


class School{
    var name: String
    var affiliate : SmallSchool
    
    init(name: String, affiliate : SmallSchool){
        self.name = name
        self.affiliate = affiliate
    }
}

let person1 = Person(name: " 김벼리")
let smallSchool1 = SmallSchool(classMember: person1)
let school1 = School(name: "김동욱", affiliate: smallSchool1)

//직접적으로 속성에 접근하는 방식
let byuriName = school1.affiliate.classMember.name

//keyPath 경로를 통해 접근하는 방식
let pathName1 = \School.affiliate.classMember.name
school1[keyPath: pathName1]


//✨selector(..) : 메소드를 선택한다.(함수를 가리키는 메모리주소가 들어가 있음)
//#selector(타입.메소드)


/*============================================================================
 ✨메타타입이란? 타입에 대한 타입
 
 메타타입을 선언하는 방법
 < 커스텀타입의 경우 >
 - 클래스이름.Type
 - 구조체이름.Type
 - 열거형이름.Type
 
 < 프로토콜의 경우 >
 - 프로토콜이름.Protocol
 ============================================================================*/




/*===========================================================================
 ✨Available 키워드
 1. @available : 컴파일러에 사용 가능성을 알려줌.
                         : ex) @available(iOS 10.0) :  ios 10.0 버전 이상에서만 코드가 있다고 컴파일러에 알려줌
 2. #available : 조건문에서 사용가능성을 알려줌 (런타임 시 알려줌)
                        : ex) if  #available(iOS 10.0, * {
                                    ...
                                }else{
                                    ...
                                }
 ============================================================================*/
