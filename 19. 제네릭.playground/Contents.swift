import UIKit

var greeting = "Hello, playground"
print(greeting)
/*✨generic=============================================================
1. generic 이란 : 모든 타입을 커버가능한 타입
 2. generic 문법이 필요한 이유?
            - generic이 없다면 같은 기능을 하더라도 타입이 다르면 다 각각 함수를 정의해 주어야 했다.
            - 코드의 유연성이 늘어난다.
 <T> : ( 타입파라미터 지정 ) 플레이스홀더와같은 역할.
 [T] :  ( 타입파라미터 사용 ) 타입을 작성하는 위치에 작성.
   * T :대문자로시작하는 모든문자열로 대체가능
 ======================================================================*/
func printArray<T>(array: [T]){
    for num in array{
        print("element")
    }
}


//✨✨✨generic 타입을 사용해서 구조체/열거형/클래스의 타입을 지정하는 방법
//✨1. 구조체로 generic 정의하기
struct Member{
    var members : [String] = []
}

struct GenericMember<T>{
    var members : [T] = []
}

var mem1 = GenericMember(members: ["a", "b", "c"])
var mem2 = GenericMember(members: [1,2,3])

//✨2. 클래스로 generic 정의하기
class GridPoint<A>{
    var x : A
    var y : A
    
    init(x: A, y: A){
        self.x = x
        self.y = y
    }
}

let aPoint = GridPoint( x : 10, y : 20)
let bPoint = GridPoint( x : 10.5, y : 20.5)

//✨3.열거형에서의 generic 정의
//열거형에서 연관값을 가질 때만, generic으로 정의가능.
enum Pet<T>{
    case dog
    case cat
    case fish(T)  // 이렇게 연관값을 가질 때만 사용 가능
}

let pet1 = Pet.fish("금붕어")

//✨generic 구조체의 확장
struct Coordinates<T>{
    var x : T
    var y : T
}

extension Coordinates{   //extension Coordinates<T>{
    //사용만 가능
    func getPlace() -> (T, T){
        return (x, y)
    }
}

let place = Coordinates(x: 3, y: 5)
print(place.getPlace())

//where절 추가도 가능하다.
extension Coordinates where T == Int{
    //where절에서 T == Int 로 작성했기 때문에 이 확장은 타입이 Int 일 때만 출력된다.
    func getIntArray() -> [T]{
        return [x, y]
    }
}
print(place.getIntArray())

//let placeDouble = Coordinates(x: 3.4, y: 4.5)
//placeDouble.getIntArray()







/*✨제네릭에서 타입 제약✨===========================================================
 제네릭에서 프로토콜, 클래스를 채택해서 타입에 제약을 걸 수 있다.
 <T : Equatable> = Equatable 프로토콜을 채택한 타입만 가능하다.
 <T : SomeClass> = 특정 클래스를 채택한 타입만 가능하다.
 ===============================================================================*/
//💠프로토콜 제약의 예💠
func findIndex<T:Equatable>(item: T, array:[T]) -> Int?{
    for(index, value) in array.enumerated(){
        if item == value{ // 여기서 == <- 이 비교하는 메소드는 Equatable프로토콜을 채택 해야지만 사용가능하다.
            return index
        }
    }
    return nil
}

findIndex(item: 6, array: [5, 6, 7])

let aNum = 8
let aArray = [5,6,7,8,9]

if let index = findIndex(item: aNum, array: aArray){
    print(" aNum 값이 들어있는 aArray의 인덱스 : \(index)")
}

//💠클래스 제약의 예💠
class Person{}
class Student: Person{}

let person = Person()
let student = Student()

func personClassOnly<T: Person>(array: [T]){
    //함수 내용 정의
}

personClassOnly(array: [person, person])
personClassOnly(array: [student, student])
personClassOnly(array: [Person(), Student()])




/*✨프로토콜에서의 제네릭 사용✨===========================================================
 프로토콜에서 제네릭을 사용하는 방법
                    - " associatedtype T "를 작성해준다.
 프로토콜을 채택을 하는 곳에서는 제네릭타입을 구체적인 타입으로 명시해 주어야 한다.
                    - "typealias T = Int" 이런식으로 명시해준다.
  ===============================================================================*/
//프로토콜에서 제네릭 선언
protocol RemoteControl{
    associatedtype T
    func changeChannel(to : T)
    func alert() -> T?
}

struct TV: RemoteControl{
    typealias T = Int
    func changeChannel(to: Int) {
        print("채널바꿈: \(to)")
    }
    func alert() -> Int? {
        return 1
    }
}

class Aircon: RemoteControl{
    func changeChannel(to: String) {
        print("Aircon 온도바꿈: \(to)")
    }
    func alert() -> String? {
        return "37도"
    }
}

var ac = Aircon();
ac.changeChannel(to:"4")
