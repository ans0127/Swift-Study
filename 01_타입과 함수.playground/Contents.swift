import UIKit





// 타입주석 : 타입을 주석 형태로 해서 명시함. var number: Int
//타입추론 : 타입 명시하지 않아도 컴파일러가 타입을 추론해 줌
//타입안정성 : 어떤 변수가 한 형태를 처음에 담으면 그 다음부터 그 변수는 명시된 형태의 타입만 담을 수 있다.

/*
 타입 주석(Type Annotation)
 변수를 선언하면서, 타입도 명확하게 지정하는 방식.   why? swift는 타입을 정확히 구분해서 사용하는 언어이기 때문에
 1. 변수와 타입을 선언
 2. 변수에 값 담기
 3.출력하기
 */
var number: Int    //타입주석
number = 1
print(number)
print("number")









/*타입(형) 변환(Type Conversion) 방법*/
//why? swift는 타입을 정확하기 구분한다. 그러면 다른 타입끼리도 계산하기 위해서는? 형변환이 필요하다.
let str = "111"   //str 선언
let num = Int(str)  //str을 int형으로 형변환


let num2 = Int("222") //변형하고싶은타입("문자열") <- 이런 형태로도 변환 가능
let noAvail = Int("안녕")

print(noAvail)  // nil출력됨. string을 int로 강제 형변환 불가
//print(num) //int 출력됨  Optional(111)



//type alias : 타입에 별칭을 붙이는 것.
// < typealias <#type name#> = <#type expression#> >
//typealias intToString = (Int) -> String)





// let :  불변 변수 : 값이 변할 수 없음
// var : 가변 변수 : 값이 변할 수 있음.
var num11 = 10

num11 = 20
var num22 = 20

num == num2


//접근연산자
/* .  : java 랑 똑같음 Integer.parseInt  같이 하위 기능을 의미
 ... : java에는 없는 기능 (~) 와 같음. (1...5 == 12345) */





//cmd + a : 전체선택
//ctl + i : 자동정렬


//패턴매칭 연산자
var num60 = 60


//num 60 이 1 에서 50까지 안에 속하면 true, 아니면 false 출력
1...50 ~= num60
// 1...50 = num60 ~ 1...50

switch num60 {
case 1...50:                 // ..<50  또는 ...50 같은 방식으로도 사용 가능. (정수부터 50까지 라는 의미)
    print("1에서 50사이")
case 51...100:
    print("51에서 100사이")
default:
    break   // 정수의 모든 경우의 수를 담아야 하니까 break  필수로 써야 함.  ... 스위치 문은  case가 모든 조건에 대한 경우의 수를 담고 있어야 한다.
}


/*  swift 에서 스위치는 반드시 조건을 정확히 명시해 주어야 한다.  0보다 크다 같은 애매한 범위조건은 안됨!!! 
switch num60 {
case > 0:
   print("잘못된 조건식")
default:
    break
}
 */

// ** fallthrough : 스위치문에서 조건을 무시하고 무조건 다음 문장도 실행하고 싶을 떄 사용.

print("바인딩 ===================================")

//바인딩이란?   기존에 있던 변수를 새로운 변수에 할당한다.
var a = 7
let b = a

//스위치문에서 바인딩이 필요한 경우?
//스위치문에서 조건절을 통해 조건을 확인해서 값을 출력할 경우, 
var no = 1

switch no {
case let no2 where no2 % 2 == 0 :      // let no2 = no   //let 으로 보통 바인딩을 함 (변수에 값을 바꿀 수 없도록.) var(가변변수)를 사용하는 경우도 있기는 함.
    print("짝수입니다. ")
case let no2 where no2 % 2 != 0:
    print("홀수입니다. ")
default:
    break
}


//튜플
//튜플이란?  2개 이상 연관된 값을 저장하는 타입 예
let me = ("문혜지","개발자","서울")

//튜플 데이터에 접근하는 방법
print(me.0)
print(me.1)
print(me.2)

// ---named tuple  key를 입력한 튜를
let namedMe = ( name: "문혜지", job: "개발자", location: "서울")
print(namedMe.name)

print("========== 튜플 + 스위치 =========")
// 튜플 + 스위치문
let me1 = ("문혜지","개발자")

switch me1{
case ("문혜지","개발자"):
    print( " 내 정보는 : " , me1)
    fallthrough
case("문혜지","여자"):
    print("틀렸습니다. ")
default : break
}


// 튜플의 바인딩
var coordinate = (0,9)

// var coordinate = (5,5)의 경우 어느 케이스에도 속해있지 않기 때문에 default를 탐.
print("coordivnate 1 ----->")
switch coordinate{
    // (0,9)를 (let distance,0) 의 형태가 있으면 여기에 바인딩 할거고,(0, let distance) 형태가 있으면 여기에 바인딩 할거야
    case (let distance, 0), (0, let distance) :
        print(distance)
    default: break
}


print("coordivnate 22 ***자주 사용하는 튜플 스위치 문 ****----->")
switch coordinate{
case(let x, let y):
    print(  "111출력값은 \(x), \(y) 입니다. ")
case let (x, y):
    print(  "2222출력값은 \(x), \(y) 입니다. ")
case let(x, y) where y > x :
    print(  "33333출력값은 \(x), \(y) 입니다. ")
default:break
}




//조건문과 반복문의 cpu 구조 :  if 문 for 문은 1. 변수읽고, 2.함수진입하고, 3 함수 안에서 한줄한줄 읽는다.


//범위연산자 : 범위를 쉽게 표기하는 방법
1 ... 10
1...
...10

1..<10
  ..<10
//..< (이런 표현은 없음 x)


//범위연산자의 숫자를 역순으로 표현할 때 : reversed  사용
let rvsBefore = 1...5

let rvsAfter = (1...5).reversed()

print("rvsAfter =======>\(rvsAfter)")

//패턴매칭 연산자

let range = 15...19

if( range ~= 18){
  //  print("true")
}

//반복문 for/ while문
//for문
for a in 1...10{
   // print(a)
}



for b in 10...15{
    print("나는 개발자")
}

//와일드카드 패턴 : "_(언더바)" ->생략의 의미임
for _ in 1...5{
    print("안녕하세요")  //----> 안녕하세요가 5번 출력됨.
                      //'_' 언더바를 상수로 했을경우 상수가 for문 안에서 사용되지 않기 때문에 '_'와일드카드 패턴을 사용했슴.
}

print("1.for문의 배열에서의 사용-------------------------")

let list = ["A","B","C"]
for i in list{
    print(i)
}


print("2.for문의 문자열에서의 사용-------------------------")
let forString = "String"
for j in forString{
    print(j)
}

//역순으로 숫자를 출력해보기
let forNum = [11,12,13,14,15]
for r in forNum.reversed(){
    print(r)
}

//stride : 성큼성큼 걷다 (마지막 값은 출력하지 않음)
let stride1 = stride(from: 1, to: 10, by: 3)

let strideThr = stride(from: 1, through: 10, by: 3) //마지막 숫자 포함



//반복문======. 1. while 문

// while 조건문{
//   출력문
//   증감식
// }


//반복문======. 2. repeat- while 문   =do-while문
// repeat{
//  출력문. <<------ 조건에 관계없이 무조건 한번은 실행
//  증감식
// }while 조건문

print(" continue & break =====================> ")

//continue & break
//continue : 결과값을 출력시키지 않고 조건식을 바로 호출함.
for i in 1...20{
    if( i % 5 == 0){
        continue  // 5의 배수인 값을 호출하지 않고 바로 다음 조건식으로 넘어감
    }
    print(i)
}

//break : 반복문을 종료시킴 -- 가장 가까이에 있는 반복문을 종료시킴


//리턴값이 있는 함수와 리턴값이 없는 함수
//함수  --- 리턴값이 없는 함수
var realid = "ans920127"

func myfunction(id: String){
    print("my id is \(id)")
}


//myfunction(id: "ans0127")
 
myfunction(id: realid)


//함수 --- 리턴값이 있는 함수
func yesReturn() -> String{
    return "ReturnValue"
}

print(yesReturn())

//함수의 아규먼트
/**
 1. 아규먼트 레이블 : 함수에 아규먼트와 파라미터를 전부 명시해줄 수 있다.
 2. 아규먼트 레이블을 생략할 수 있다. ( 와일드카드 패턴)
 3. 가변 파라미터 '...' input 의 갯수가 정해지지 않았을 경우 사용 가능하다. ex . Int... Double...
 4. 함수의 파라미터에 기본값 셋팅이 가능하다.
 **/
//함수 - 1. 아규먼트 레이블
//swift에서는 함수에 아규먼트와 파라미터를 전부 명시해줄 수 있다.
func firstFunc(yourId id : String, yourName name : String){  //함수 밖에서는 yourId, yourName 을 사용하므로써 구체적으로 명시해줄 수 있다.
    print("ID is \(id) and NAME is \(name)")  //  함수 내부에서는 id와 name 이라는 이름을 사용
}


//아규먼트 레이블을 생략할 때=======
//-1.  아규먼트 레이블을 생략하지 않았을 경우 함수 호출 시 아규먼트를 전부 명시해 주어야 한다.
func noArg( firstId id_1 : String, SecondId id_2 : String){
    print("\(id_1) and \(id_2)")
}

noArg(firstId: "ans0127", SecondId: "ans920127") // 아규먼트와 같이 값 입력 필요


//-1.  아규먼트 레이블을 생략했을 경우 (와일드카드 패턴을 사용)
func noArg02( _ id_1 : String, _ id_2 : String){
    print("\(id_1) and \(id_2)")
}

noArg02("ans01","ans02")  // 이런 방식으로 바로 값만 입력 가능



//가변 파라미터 -- input 의 갯수가 정해지지 않았을 때 사용 가능
func changeable( _ id : Int...) -> Int{
    let idCount = id.count
    print(idCount)
    return idCount
}
changeable(1,2,3,4,5)


//함수의 파라미터에 기본값 설정 가능.
func defParam( id : String, phoneNo : Int = 01086675601){
    print("\(id) + \(phoneNo)")
}

defParam( id: "ans0127")

//리턴문이 아닌 함수에 return 을 사용할 경우 : 함수를 벗어난다는 의미
func noReturn(id : String ){
    print("hi, my id is \(id)")
    return
}

noReturn(id:"and0127")





func testFunc(){
    print("testFunc no param")
}

func testFunc2(id: String){
    print("with one param")
}

func testFunc3(id: String, name: String){
    print("with two param")
}


//함수를 가리키는 법 (실행문 아님)
// 실행문 : defParam (id: "ans0127")
//1. 파라미터가 없을 때
defParam
//2. 파라미터가 있을 때
defParam(id: "ans1234")
//3. 파라미터가 여러개인 경우-> 콤마 없이 아규먼트이름: 을 나열해서 사용
defParam(id:phoneNo:)
//4.함수를 변수에 넣어서 사용가능
var some = testFunc()
var some2 = testFunc2(id:)
some2("testFunc id : ans0127")


//함수의 타입을 표기하는 방법
var function1: (String) ->() = testFunc2(id:)
var function2: (String, String) -> () = testFunc3(id:name:)


//오버로딩 =  다형성 (함수의 이름은 같지만 파라미터가 다르고 다른 기능을 함. )
func ovrLoad(id: Int){
    print("int")
}

func ovrLoad(id: String){
    print("String")
}

func ovrLoad(phone: Int, id: String){
    print("Int + String")
}


//함수의 인아웃 파라미터.
//함수는 기본적으로 밖에서 가져온 값을 바꿀 수 없음
//예로
//var a = 1
//var b = 2
//
//func change(a: Int, b: Int){
//    var temp = a
//    a = b             //a is a'let' constant  -- a는 상수이기 때문에 assign 할 수 없다는 오류가 뜸.
//    b = temp
//}
//
//change(a,b)

// 값을 바꾸고 싶을 경우 inout 파라미터를 사용한다.
//inout 파라미터를 사용할 경우 값을 바꿀 수 있고(주소값을 전달하는 것이 아닌),
//엔퍼센트(&)를 사용하여 인아웃 파라미터를 사용하여 값을 바꿀 것이라는 것을 경고한다.
//inout 파라미터에서는 가변 파라미터 사용이 불가능하다 (Int...  <- 가변 파라미터)
var num99 = 1
var num100 = 2

func changeab(a : inout Int, b: inout Int){
      var temp = a
      a = b
      b = temp
}

changeab(a: &num99, b: &num100)

print(num99)
print(num100)



//guard 문 : swift에만 있는 문법
//if 문과 유사하지만, false 를 먼저 판별해서 감시하는 함수임. = early exit = 불만족 걸러내기
// guard 조건문 else { return } 형태로 사용함.
// 중괄호 안에는 함수를 종료시키는 문구가 꼭 있어야 함. { return }

var myPassword = "1234567"

func passwordCheck(myPassword : String){
    guard myPassword.count > 6 else {
        print("please input over 6 words ") // 6보다 크지 않으면 바로 실행.
        return
    }
    print(" 6자리 이상입니다.")
}

passwordCheck(myPassword : myPassword)


//어트리뷰트의 사용
//@discardableResult
//discardable: 버릴 수 있는
//: 함수에 리턴값이 있을 때 리턴값을 사용하지 않으면 swift 에서 경고창으로 알려준다. 이를 방지하기 위해 어트리뷰트@discardableResult 를 사용한다.
// 또는 와일드카드 패턴으로 _ = 함수() 이런식으로 사용할 수도 있다.




