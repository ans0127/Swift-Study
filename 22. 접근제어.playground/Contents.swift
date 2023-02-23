import UIKit

var greeting = "Hello, playground"
/*=================================================================
 ✨✨✨✨✨접근제어✨✨✨✨✨
 접근제어는 왜 필요할까?
 코드의 내부 구현 로직을 숨기기 위해서 (은닉화)
 =================================================================*/

//( 예시 ) pirvate - 가 접근제어역할을 한다.
class SomeClass{
    var name = "name"
    
    func nameChange(name: String)  {
        if name == "byuri"{
            return
        }
        self.name = name
    }
}

let object = SomeClass()

object.nameChange(name: "dongwooks")
object.name

/*=================================================================
 ✨swift 에서의 5가지 접근제어 수준✨
 (개방)
 1. open : 다른 모듈에서도 접근 가능/ 상속 및 재정의 가능    ( 클래스에서 가장 넓은 범위 )
 2. public : 다른 모듈에서도 접근 가능/ 상속 및 재정의 불가  ( 구조체에서 가장 넓은 범위 )
 3. internal : 같은 모듈 내에서만 접근 가능( default ) - 패키지
 4. filepirvate : 같은 파일 내에서만 접근 가능 - 파일
 5. private : 같은 scope 내에서만 접근 가능 -  { 중괄호 내에서만 }
 (숨김)
 =================================================================*/


//private를 사용하여 감추고 싶은 변수를 생성할 때에는 변수 이름 앞에 " _(언더바)" 를 붙여준다.
class SomeClass1{
    private var _name = "dongdongwook"
    
    var name : String{
        return _name
    }
}


//⭐️private(set) : 읽을때는 internal( default ),  set 할 때만 private 이다.
//⭐️private(set) = internal private(set)
class SomeClass2{
    private(set) var name = "bbyuri"
}

let ab = SomeClass2()
ab.name
//ab.name = "dd"   //불가능





/*=================================================================
 ✨ 커스텀 타입의 접근제어✨
 : 타입의 내부 멤버는 타입 자체의 접근 수준을 넘을 수 없다.
 =================================================================*/
public class CustomClass{
    open var someOpenProperty = "1"   //open이라고 작성해도 public을 넘을 수 없음.
    public var somePublicProperty = "2"
    var someInternalProperty = "3"
    fileprivate var someFilePrivateProperty = "4"
    private var somePrivateProperty = "5"
}

let customproperty = CustomClass()
customproperty.someOpenProperty
customproperty.somePublicProperty
customproperty.someInternalProperty
customproperty.someFilePrivateProperty
//customproperty.somePrivaeProperty    //불가능





/*=================================================================
 ✨ 상속과 확장의 접근 제어 ✨
타입 : 상속받은 서브클래스(타입)는 상위클래스보다 더 높은 접근수준을 가질 수는 없다.
멤버 : 상위 멤버에 접근 가능하면, "접근 수준을 올려서도" 재정의가 가능하다.
 =================================================================*/
//✨상속의 접근 제어
public class A {  // 타입 : (넓은범위)
    fileprivate func someMethod(){}   //파일 내 ( internal 보다 좁은 범위)
}

internal class B : A {  // 타입 : (좁은범위)
    override internal func someMethod() {    //모듈 내에서 접근이 가능하기 때문에 호출 가능하다.
        super.someMethod()
    }
}

//✨확장의 접근 제어
//1. 본체와 동일한 접근 수준을 유지한다.
//2. 본체의 멤버에는 기본적으로 접근이 가능하다.
public class SomeClassExt{
    private var somePrivateProperty = "somePrivate"
}

extension SomeClassExt{
    func somePrivateControlFunction(){
        somePrivateProperty = "접근가능"   //확장했기 때문에 private 이지만 접근이 가능하다.
    }
}
