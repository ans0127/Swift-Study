import UIKit

//클래스와 구조체
//클래스와 구조체는 기본적으로 같다.
//인스턴스: 메모리에 찍어낸 하나의 실제의 데이터



class Dog{
    var name = "강아지"
    var weight = 100
    
    func sit(){
        print("\(name)앉아! ")
    }
}
 
    var bori = Dog()
    bori.name = "보리"
    bori.weight = 250
    bori.sit()

    var choco = Dog()
    choco.name = "초코"
    choco.weight = 300





struct Bird{
    var name = "새이름"
    var weight = 10
}
    
var bird01 = Bird()
bird01.name = "참새"

var bird02 = Bird()
bird02.name = "비둘기"



//구조체와 클래스의 차이점?
//값을 저장하는 형식에 차이가 있다.!!

//구조체 : 인스턴스 데이터를 모두 스텍에 저장한다.
//클래스: 인스턴스 데이터는 힙에 저장이 되고 , 힙을 가르키는 변수는 스텍에 저장이 된다. 그리고 변수가 갖고 있는 메모리주소값이 힙의 데이터를 가르킨다.

class Person{
    var name = "사람"
}

var p = Person()
p.name = "혜지"

var p2 = p //클래스  p의 메모리주소를 복사해서 p2에 담았다. -> 메모리 주소를 복사하는 거니까 동일한 데이터를 가리킴
p2.name = "동욱"
print(p.name)
print(p2.name)



//구조체. 값 자체가 복사가 되기 때문에 두개의 데이터가 따로 존재함.
struct Animal {
    var name = "동물"
}

var a = Animal()
a.name = "벼리"

var a2 = Animal()

a2 = a
a2.name = "고양이"
print(a.name)
print(a2.name)

//let 상수와 구조체/클래스
//구조체의 경우 let으로 선언하면 구조체 자체의 데이터를 바꿀 수 없음.
//클래스의 경우 let으로 선언해도 주소값으로 가르키고 있는 힙 영역의 데이터를 바꿀 수 있음.

class PersonClass{
    var name = "사람"
    var age = 0
}


struct AnimalStruct{
    var name = "김벼리"
    var age = 0
}

let pclass = PersonClass()
let astruct = AnimalStruct()

pclass.name = "문혜지"
pclass.name = "김동욱이😎" //let 인데도 변할 수 있음!!

print(pclass.name)

//astruct.name = "김벼리"  let 으로 선언되어 있기 때문에 속성을 변경시킬 수 없음.
//astruct.name = "고양이?"

print(astruct.name)

//Dog()  :  붕어빵을 찍어내는 행위구나!! ---






//초기화
//초기화 방법 : init()
class Dog01{
    var name = "김벼리"
    var weight = 8
    
//    init( n : String, w : Int){  //초기화함수
//        self.name = n
//        self.weight = w
//    }
    init( name : String, weight : Int){  //초기화함수.
        self.name = name               // self.name 은 class안에 선언된 var name을 의미.
                                        // 우측 name 은 init() 안의 파라미터 name을 의미.
        self.weight = weight
       }
    
    func sit(){
        print("\(self.name) 앉아!!")
    }
    
    func layDown(){
        print("\(self.name) 누워!!")
    }
}


var byuri = Dog01(name: "김벼리멍멍", weight: 9)  //파라미터 김벼리멍멍을 받아서 Dog01 안에 선언된 변수 name안에 넣음
    byuri.name
    byuri.weight
    byuri.sit()


//var bbyuri = Dog01()  모든 속성을 초기화 해야 하는데 속성을 정의해 주지 않아서 에러남.



















