import UIKit

/*=======================================================================
 옵셔널 체이닝(Optional chaining)
 - 옵셔널 타입에 접근연산자를 사용하는 방식
 - 1) 옵셔널 체이닝의 결과는 항상 옵셔널이다.
 - 2)옵셔널 체이닝의 값 중 하나라도 nil 일 경우, nil을 return한다.
 =======================================================================*/

//옵셔널 타입에 대해 접근연산자를 사용하는 방법
class Dog {
    var name : String?
    var weight : Int
    
    init(name: String, weight : Int) {
        self.name = name
        self.weight = weight
    }
    
    func sit( ) {
        print("\(self.name) 가 앉았습니다.")
    }
    
    func laydown( ) ->  Int{
        print("\(self.name) 가 누웠습니다.")
        return 777
    }
}

class Human {
    var dog : Dog?
}

//옵셔널 타입에 접근연산자를 사용할 때는 "?"를 붙여서 옵셔널 타입인 것을 표시한다.
var choco = Dog(name: "초코", weight: 6)
choco.name
choco.sit()                         //Optional("초코") 가 앉았습니다.
choco.name = "벼리"
choco.sit()                         //Optional("벼리") 가 앉았습니다.


var human = Human()
human.dog = choco
human.dog?.name  //자동으로  dog에 "?"를 붙여준다. - dog는 optional 타입이기 때문에


//옵셔널 체이닝을 실제 사용할 경우 " UnWrapping"해서 사용해야 한다.---------------------------
//1. 옵셔널 타입에 값이 있다는 것이 확실할 경우
print(human.dog!.name)
print(human.dog!.name)


//2. if let 바인딩
if let name = human.dog?.name{
    print(name)
}

/*=========================================================================
 3. Nil-Coalescing 연산자
  - 어떤 타입이 optional 인 경우 "??" 를 사용해서 기본값을 지정
  - 따라서 무조건 default값이 있기 때문에 옵셔널을 제거해준다.
 =========================================================================*/
var defaultName = human.dog?.name ?? "벼리엉아"  //벼리엉아를 기본값으로 지정해줘서 nil을 없애준다.
print(defaultName)




/*=========================================================================
옵셔널 체이닝에서 함수의 실행
 - 값이 있으면 함수실행
 - nil이면 nil리턴
 =========================================================================*/
print("==========옵셔널 체이닝에서 함수의 실행=============")
var byuri : Dog? = Dog(name: "벼리양", weight: 6)
byuri?.sit()
byuri?.laydown()
print(byuri?.laydown())  //  laydown의 리턴값이 Int지만, optinal integer를 리턴 ( byuri 가 optional이기 때문에 전제값을 따라간다.)


byuri = nil
byuri?.sit()   //실헹안되고 nil을 return함


