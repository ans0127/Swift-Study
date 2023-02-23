import UIKit

//숫자 리터럴을 표기하는 방법==============================================================
var num : Int = 25 //10진법

num = 0b00011001  //0b : 2진법
num = 0o31  //0o : 8진법
num = 0x19 // 16진법

//컴퓨터는 언더바를 무시해버리기때문에 읽기쉽게 언더바를 붙일수도 있음
num = 100_000_000

//고급 연산자  advanced operators
//게임어플 등 이외에는 자주 쓰이는 문법은 아님.



/*==============================================================
 단락평가
 : swift 의 논리평가식은 '단락평가'를 사용한다.
 단락평가란? 논리 평가식에서 결과를 도출할 때 최소한으로만 논리식을 평가하는 것.

사이드이팩트 :  함수의 실행에 의해서 외부의 변수의 값이 바뀌는 것
 ==============================================================*/

var num1 = 0

func checking() -> Bool{
    print(#function)
    num1 += 1
    return true
}

if checking() || checking(){   //&& 일 경우?
    
}
num1   //1 이 나옴,      true || true  일 경우 무조건 true 이기 때문에 || true 는 실행하지 않기 때문 ==> 이것이 "단락평가"


/*==============================================================
사이드이팩트 :  함수의 실행에 의해서 외부의 변수의 값이 바뀌는 것
사이드이팩트의 단점: 사이드 이팩트가 발생하여 함수의 실행 횟수의 차이로 의도치 않은 결과가 나올 수 있음.
 
 ====> 따라서, 논리적인 오류가 없도로 표현식을 미리 실행하도록 코드를 수정할 수 있다.
 ==============================================================*/
var doorCheck = 0
var passwordCheck = 0

func doorCodeChecking() -> Bool{
    doorCheck += 1
    print(#function)
    return true
}

func passwardCodeChecking() -> Bool{
    passwordCheck += 1
    print(#function)
    return true
}

let doorResult1 = doorCodeChecking()
let passwordResult1 = passwardCodeChecking()
let doorResult2 = doorCodeChecking()
let passwordResult2 = passwardCodeChecking()

if doorResult1 || passwordResult1 && doorResult2 || passwordResult2 {
    
}
print("door : \(doorCheck) , password : \(passwordCheck)")   //2.2


/*==============================================================
비트연산자 : 자주 쓸 일은 없음 (c언어같은 게임언어에서 많이 사용)
 ~, &, |, ^, <<, >>
 ==============================================================*/



/*==============================================================
연산자 메소드의 직접 구현
1. 애플이 만들어 놓은 연산자 : + - * / ==
 
 ==============================================================*/
//연산자 메소드의 직접 구현 ( 앱 구현시 필요할 수 있음)
struct Vector2D{
    var x = 0.0
    var y = 0.0
}

//1. 더하기 연산자 구현 : "+"  static 뒤에 아무것도 안쓰면 중위연산자라고 자동으로 생각함
extension Vector2D{
    //타입 메소드로 구현 : static method =/= class method : static method는 상속 불가능
    static func + (left : Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x , y:left.y + right.y )
    }
}

let vector = Vector2D(x : 3.0, y :1.0)
let anotherVector = Vector2D(x: 2.0, y : 4.0)

let combinedVector = vector + anotherVector             // 여기서의 "+" 연산자를 구현 해보자


//⭐️전치연산자, 후치연산자로 구현할 경우, prefix, sufix를 넣어줘야 한다.
//2. 빼기 연산자 구현 "-"
extension Vector2D{
    static prefix func - (vec : Vector2D) -> Vector2D{
        return Vector2D(x: -vec.x, y: -vec.y)    //x, y 에 ' - ' 를 붙여서 리턴함.
    }
}

let positive = Vector2D(x:3.0, y:4.0)
let negative = -positive
let alsopositive = -negative


//복합할당 연산자의 구현
extension Vector2D{
    static func += (left: inout Vector2D, right: Vector2D){
        left = left + right  // + 연산자를 구현해놓았기 때문에 사용가능
    }
}

/*==============================================================
2. (==, != )  연산자 메소드 구현
 equatable : ==, !=
 comparable : < , > . >= . <=
 
 ⭐️연산자 메소드의 구현이 왜 필요할까?
  : 어떤 규칙을 가지고 두 인스턴스를 비교해야 할 지 모르기때문에 , 연산자 메소드를 구현해서 비교 가능하게 해준다.
 ==============================================================*/
let vector1 = Vector2D(x: 1.0, y:2.0)
let vector2 = Vector2D(x: 2.0, y:4.0)

/*==============================================================
 equatable 프로토콜 해서 메소드를 구현
⭐️프로토콜을 채택만 하면 사용가능!
            =>  equatable 프로토콜을 채택하기만 하면 컴파일러가 내용을 자동으로 구현해준다.
 ==============================================================*/
extension Vector2D : Equatable{
}

vector1 == vector2
vector1 != vector2

if vector1 == vector2 {
    print("두개의 백터값은 동일함")
}


/*==============================================================
⭐️열거형의 경우, "연관값"이 없으면 동일성 비교가 가능하다.
⭐️ "연관값"이 있으면 비교 불가능
 ==============================================================*/
enum Weekday{
    case mon
    case tues
}
Weekday.mon == Weekday.tues

enum Weekday2{
    case mon2
    case tues2(String)
}
//Weekday2.tues2("hello") == Weekday2.tues2("hi")      //비교불가능

enum Weekday3 : Equatable{
    case mon3
    case tues3(String)
}
Weekday3.tues3("hello") == Weekday3.tues3("hi")

/*==============================================================
⭐️comparable 은 "< "연산자만 구현 해주면 나머지 연산자는 자동으로 구현 해준다.
 < , <= , >, <=
 ==============================================================*/



/*==============================================================
 ✨사용자 정의 연산자의 구현 : app 개발 시 google 찾아가면서 개발하면 됨
 ex) i++ 라는 기호는 swift에는 없음
==============================================================*/
//✨apple이 swift 상에 미리 구현해 놓지 않은 연산자를 사용하고 싶을 때 개발자가 직접 구현해서 사용한다!
var i = 0
i = i + 1
i++

// 1. 사용시 반드시 선언 필요  ex. postfix operator ++
postfix operator ++

// 2. 실질적으로 구현 필요
extension Int{
    static postfix func ++ (num : inout Int){   
        num = num + 1
    }
}

/*==============================================================
 중위연산자의 경우 : 우선순위 그룹 선언 필요 ( + 먼저 할 것인지 * 먼저 할 것인지...)
 1. 우선순위 그룹 선언
 2. 연산자 선언 후 , 우선순위 그룹 지정
 3.연산자의 실제 정의
 ==============================================================*/
