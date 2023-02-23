import UIKit


//is 연산자 (type check operator)
//type 을 check 해서 맞으면 true, 아니면 false를 리턴한다.
//is : [변수1 is 변수2] : 변수1의 타입이 변수2 인지 확인 후 true/false 리턴

//*****헷갈릴 때는 class가 어떤 멤버들을 갖고 있는지 확인하자!
class Person{
    var name = "김벼리"
    
    func walk(){
        print("벼리가 걷는다.")
    }
}

class Student : Person{
    var id = "ans0127"
    
    override func walk() {
        print("김벼리 학생이 걷는다. ")
    }
    
    func study(){
        print("김벼리 학생이 공부한다.")
    }
}

class College : Student{
    var email = "ans0127@naver.com"
    
    override func walk() {  //student 의 override 된 함수를 override
        print("김벼리 대학생이 걷는다. ")
    }
    override func study() {
        print("김벼리 대학생이 공부한다.")
    }
     func party(){
        print("김벼리 대학생이 파티한다.")
    }
}


var p1 = Person()
var p2 = Student()
var p3 = College()

p1 is Person  //true
p1 is Student  //false
p2 is Person


//is연산자의 활용법?

var pp1 = Person()
var pp2 = Student()
var pp3 = College()

var people = [p1, p2, p3, pp1, pp2, pp3 ]

//ex. people 리스트 안의 인스턴스들 중, student 인스턴스의 갯수를 알고 싶을 때?
var stdCount : Int = 0
for stdGroup in people {            //people 안의 인스턴스들을 하나씩 stdGroup안에 넣음.
    if stdGroup is College {        // stdGroup 안에 있는게 Student 가 맞으면
        stdCount += 1
    }
}

//print(stdCount)




//as연산자-------------------------------------------------------------------------------------
/*=====================================
 * 업캐스팅 (as) : 항상 성공한다.
 *
 * 다운캐스팅 (as?) : 옵셔널 타입의 값 리턴
 * 다운캐스팅 (as!) : 값 리턴
 *=====================================
 */
//person 타입의 ppp를 college() 인스턴스로 생성하자.
//- 실제로 메모리공간은 3개(name, id, email) 이 존재하지만, 저장할 때만 1개(name)만 보이도록 함.
let ppp : Person = College()      //현재 ppp의 메모리 공간 = 3개
ppp.name
//ppp.email


//다운캐스팅 (as?) : 옵셔널 타입으로 리턴 -------------------------------------------
/*1 */ppp as? College //ppp 인스턴스를 college 타입으로 인스턴스로 변환한다.
/*2 */let p01 = ppp as? College
        //p01 의 타입은 'College?' 이다. ...if let 바인딩을 통해 옵셔널을 벗겨준다.
        //ppp의 메모리 공간은 현재 3개이기 때문에 다운캐스팅에 성공한다.
        if let p001 = p01{
            p001.name
            p001.id
        }

        if let p01 = ppp as? College{
            p01.name
            p01.id
            p01.email
        }


//강제 다운캐스팅 (as!) - 옵셔널을 바로 강제로 벗겨준다./ 실패할 경우 runtime error 발생한다.
let p02 = ppp as! College

//다운캐스팅 실패의 예시
//메모리 공간은 1개(Person인스턴스) 인데 3개(College)를 담으려고 해서 실패함.
let pf : Person = Person()

let pff = pf as? College   //nil 호출됨.

print("1")


//업캐스팅의 경우 항상 성공한다.
//ex. 3개의 메모리 공간을 가지고 있는 것을 1개의 메모리공간만 가지고 있는 것으로 변환하는 것이기 때문에 항상성공
//3개의 바구니가 있는데 이것을 3개중 1개만 사용하는 것으로 변경한다고 생각하면 이해하기 쉽다.


// 상속관계에서의 타입과 메소드
let b1 = Person()
b1.walk()   //벼리가 걷는다. Person()의 함수 사용 . 당연함

let b2 : Person = Student()
b2.walk()    //김벼리 학생이 걷는다. Student()의 함수만 사용.

let b3 : Person = College()
b3.walk()   //김벼리 대학생이 걷는다. College()의 함수만 사용.


//Any 타입 & AnyObject 타입 ------------------------------------------------------------------------
//1. Any 타입 : 일반적인 경우 잘 사용하지 않음.-----------------------------------------------------------

//Any 타입을 사용하면 , Any타입의 값이 어떤 메모리구조를 갖는지 알수 없어서 항상 타입캐스팅 해서 사용해야 한다.
var byuri : Any = "byuri"
(byuri as! String).count
byuri = 10

//Any 타입의 장점 ! 모든 타입을 담을 수 있는 배열 생성 가능하다.
var arr : [Any] = [4.0 , 10 , "벼리", Person(), Student()]

(arr[2] as! String).count

//2.AnyObject : 클래스의 인스턴스(객체) 만 담을 수 있는 타입. (구조체의 인스턴스 안됨!!!)----------------------------
let objArr : [AnyObject] = [Person(), Student(), College()]

//objArr[2].email    //어떤 타입에 대한 어떤 메모리 구조를 갖고 있는지 알 수 없기 때문에 에러가 난다.
(objArr[2] as! College).email







