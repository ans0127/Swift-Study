import UIKit

//💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠
//선행지식 : MRC 와 ARC
//💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠
/*=========================================================================
 MRC
 - 개발자가 메모리를 수동으로 관리하는 방식 (retain, release 코드를 사용하여 )
 - 개발자가 모든 코드를 직접 삽입해야 했기에 실수할 가능성이 있고, 메모리 관리에 대한 부담감이 있었다. ⭐️
 deinit : 소멸자 : 실제로 메모리에서 삭제가 되는지를 확인하기 위함
 retain : rc + 1
 release : rc - 1
 =========================================================================*/
class Dog{
    var name : String
    var weight : Double
    
    init(name : String, weight : Double) {
        self.name = name
        self.weight = weight
    }
    deinit{
//        print("\(name) 메모리 해제 ")
    }
}

var byuri : Dog? = Dog(name: "벼리", weight: 6.0)  // retain(byuri) rc + 1
var byuri2 : Dog? = Dog(name: "벼리2", weight: 7.0 )  // retain(byuri2) rc + 1

byuri = nil  // rc : 0 release byuri
byuri2 = nil // rc : 0 release byuri2

/*=========================================================================
ARC
 1. 나를 가르키는 인스턴스가 하나 이상이면 메모리에 올라간다.
 2. RC 란? 인스턴스를 가르키는 소유자 수를 카운팅하는 것.
 =========================================================================*/
var dog1: Dog?
var dog2: Dog?
var dog3: Dog?


dog1 = Dog(name: "첫째벼리", weight: 10.0)   //rc + 1
dog2 = dog1                                                   //rc + 2
dog3 = dog1                                                   //rc + 3

dog3?.name = "셋째벼리"
dog2?.name
dog1?.name   //같은 인스턴스를 가리키고 있기 때문에 모두 name 이 다 "셋째벼리"이다.

dog3 = nil                                                  //rc -1 = ( 3 -1 = 2)
dog2 = nil                                                  //rc -1 = ( 2 -1 = 1)
dog1 = nil                                                  //rc -1 = ( 1 -1 = 0)   메모리해제  "셋째벼리 메모리 해제 "


/* 💠💠💠💠💠💠💠💠💠💠💠================================================
 메모리누수 현상 : heap 영역에 필요없어진 메모리가 삭제되지 않고 그대로 남아있어 메모리가 쌓이는 현상
                        - 메모리가 쌓이면 삭제되지 않아 많은 공간을 차지하여 App이 꺼질 수 있다.
 해결방법 : weak을 Unowned 보다 더 자주 사용한다.
 💠💠💠💠💠💠💠💠💠💠💠💠===============================================*/

/*해제방법 1. =====================================================
 1.약한참조 (weak  Reference) : 내가 가르키는 상대방에  rc를 올리지 않는다.
            : 변수 앞에  weak 키워드를 붙여준다.
            : 참조하고 있던 인스턴스가 사라지면(nil 이 되면), 가리키던 것도 nil 이 된다.
 ✨✨✨weak 을 사용할 경우, weak var optional로 해야 한다. (weak은 nil을 할당할 수 있어야 하기 때문에)
 =============================================================*/

class Dog1{
    var name : String
    weak var owner: Person?         //weak 키워드 = 약한 참조
    
    init (name : String){
        self.name = name
    }
    deinit{
        print("  Dog1  \(name) 메모리 해제 ")
    }
}


class Person{
    var name : String
    weak var pet : Dog1?          //weak 키워드 = 약한 참조

    init(name : String){
        self.name = name
    }
    deinit{
        print(" Person  \(name) 메모리 해제 ")
    }
}

var bori: Dog1? = Dog1(name: "벼리")
var dongwook : Person? = Person(name: "김동욱")

//강한 참조 사이클이 일어나지 않음.
bori?.owner = dongwook
dongwook?.pet = bori

bori = nil
dongwook = nil

dongwook?.pet   //nil = 약한 참조의 경우 가리키고 있던 인스턴스가 nil이 되면 가리키는 것도 nil이 된다.
//bori?.owner = nil
//dongwook?.pet = nil


/*해제방법 2. =====================================================
 2.비소유 참조 ( Unowned Reference )
 -unowned 키워드를 붙여 강한 참조를 해제시켜준다.
 (** 위의 예제에서 weak 키워드 대신 unowned 키워드를 붙여주면 된다.)
 =============================================================*/

//💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠값타입의 캡쳐와 캡처리스트 💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠
/*=====================================================
 클로저와 메모리 ( 캡처현상과 캡처리스트 )
 클로저에서는 어떻게 메모리 누수를 해결할 수 있을까?? - 캡처리스트를 사용
                                                                             - 캡처리스트란? - 약한참조, 비소유참조를 선언할 수 있도록 해주는 것들
 =====================================================*/
//캡처현상이란? ⭐️
//함수에서 외부변수를 사용하는 경우 "✨외부 변수의 메모리주소✨"를 저장(캡쳐)해놓는 것을 말한다.
//함수를 변수에 저장하는 순간 ( 클로저나 함수에서 ) 자동적으로 발생한다.
func calcul() -> ((Int) -> Int){
    var sum = 0  // 이 외부변수를 캡쳐
    func square(num : Int) -> Int{
        sum += (num * num)
        return num
    }
    return square
}

var squareFunc = calcul()
squareFunc(10)
squareFunc(20)
squareFunc(30)

/**============================================================
 캡처리스트
 - 캡처리스트 변수 내부에는 "캡처할 변수"를 넣는다.
 - 함수에서 외부변수를 사용하는 경우 "✨외부 변수의 값✨"를 저장(캡쳐)해놓는 것을 말한다.
 - 외부요인에 의해 값이 변경되는 것을 방지한다.
 ==============================================================*/
var num = 1
let valueCaptureClosure = {
    print("밸류값 캡쳐 :  \(num)")
}
num = 7
valueCaptureClosure()    //밸류값 캡쳐 :  7

num = 1
valueCaptureClosure()  //밸류값 캡쳐 :  1



let valueCaptureClosureList = { [num] in
        print("밸류값 캡쳐 (캡쳐리스트) : \( num)")    //밸류값 캡쳐 (캡쳐리스트) : 1
}

num = 7    // main스택의 num 에 7을 넣어도 , 힙의 데이터는 그대로 1이다. ( 메모리주소가 아니라 값만 바뀌는 것이기 때문에 )
valueCaptureClosureList()   //1이 출력됨.



//💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠참조타입의 캡쳐와 캡처리스트 💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠💠
class SomeClass{
    var num = 0
}

var x = SomeClass()
var y = SomeClass()

print("참조 초기값 (시작값) :", x.num, y.num)    // 0 0

let refTypeCapture = { [x] in               // x만 캡쳐함
    print("참조 출력값 (캡처리스트) : ", x.num, y.num)
}

x.num = 1
y.num = 1
print("참조 초기값 ( 숫자변경 후 ) :", x.num, y.num)   // 1 1
refTypeCapture()    // 1 1
print("참조 초기값 ( 클로저 실행후 ) : " , x.num, y.num)  // 1 1


//강한 참조 사이클 해결방안
//1. weak , unowned 를 사용
 
var z = SomeClass()

let refCapture1 = { [weak z] in
    print(" weak -- 참조 출력값 (캡쳐리스트) : ", z?.num)
}
refCapture1()

let refCapture2 = { [unowned z] in
    print(" unowned -- 참조 출력값 (캡쳐리스트) : ", z.num)
}
refCapture2()

//캡처리스트 안에서 바인딩 하는 것도 가능하다.
var b = SomeClass()

let captureBinding = { [ newB = b] in
    print("바인딩의 경우 : ", newB.num)
}



//객체 내에서의 클로저 사용
//보통 프로젝트에서는 객체(class) 안에서 클로저를 사용하는 방식을 사용한다.
//1. 클로저 내에서 객체의 속성이나 메소드에 접근할 때는 self 키워드를 반드시 사용한다.
class Dog3{
    var name = "벼리"
    func doSomething(){  //1번째 스택에서 일어나는 일
        DispatchQueue.global().async {    //2번째스택에서 일어나는 일
            print("내 이름은 \(self.name) 입니다. ")
        }
    }
}

//강한 참조 : rc 를 +1 하는 것,.
//강한 참조 사이클 : 서로를 가리키면서 +1 하는 것


//weak 을 사용하는 경우 guard let 을 사용하여 early exit 을 주로 사용한다.
//- 보통 weakSelf라고 많이 사용한다.
//클로저를 객체 내에서 사용할 때는 대부분 weak 과 함께 사용한다.
class Person1{
    let name = "김벼리"
    
    func myName(){
        print("my name is \(name)")
    }
    
    func myName1(){
        DispatchQueue.global().async {
            print("my name is \(self.name)")                //객체 안에서 클로저를 사용할 경우 self.name 형식으로 작성
        }
    }
    
    func myName2(){
        DispatchQueue.global().async { [weak self] in        //캡처리스트 사용 & 약한참조 사용
            print("my name is \(self?.name) (CaptureList + weak) ")           //weak 은 nil 을 포함하기 때문에 optional을 포함
        }
    }
    
    func myName3(){
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }      //guard문을 통해서 early exit을 시켜준다. => 객체가 없으면 일 종료시킴
            print("my name is  \(weakSelf) ( weak을 guard let문을 사용하여 옵셔널을 벗긴다.) ")
        }
    }
    
}

let p1 = Person1()
//p1.myName()
//p1.myName1()
//p1.myName2()
//p1.myName3()



print("✨캡처리스트 실제 예시✨")

//강한 참조일 경우
class ViewController : UIViewController{
    var name : String = " 김벼리 뷰컨"
    
    func doSomething(){  //-- (스택1) [3]           // -- (스택1) 힙 영역에 클로저를 생성   // 생성한 클로저 함수가 class ViewController : name을 가리키고 있음  rc+1
        DispatchQueue.global().async {
            sleep(3)    //-- (스택2) 클로저를 실행 { 3초이상 걸리는 작업 }
            print("글로벌큐에서 출력하기 : \(self.name)")   //--(스택2) 출력
        }
    }
    
    deinit{
        print("\(name) 메모리 해제 ")
    }
}

func localScopeFunction(){   // 얘도 class ViewController : 를 가리키고 있음  rc+2              // --(스택1) [1]    //sleep(3) 실행동안 localScopeFunction은 멈춤
    let vc = ViewController()
    vc.doSomething()   // --(스택1) [2]
}

//💠
//localScopeFunction()
//3초후
//글로벌큐에서 출력하기 : 김벼리뷰컨
// 김벼리 뷰컨 메모리 해제
/**============================================================================
 1.  localScopeFunction 이 스택1에 올라감. ->   class ViewController : 를 가리키고 있음  rc+1
 2.  doSomething() 이 스택1에 올라감 -> 클로저 함수를 생성함 -> 클로저 함수가 class ViewController : name을 가리키고 있음  rc+2
 (rc +2 인 상태에서)
 3. 스택2 에 클로저함수 "실행"  -> sleep(3) 이 실행됨.
 4.  localScopeFunction 이 종료됨 rc-1    ----- sleep(3) 진행중
 5. print("글로벌큐에서 출력하기 : \(self.name)") 실행됨    ----- sleep(3) 진행중
 6.스택2에서 클로저 함수 실행 종료됨  -> 실행종료됨에 따라 힙에 생성한 클로저함수도 사라짐  rc -2
 7. rc 0 이 되면서 vc 도 사라지게 되어 소멸자를 호출함   ---> print("\(name) 메모리 해제 ")
 ============================================================================*/




//강한 참조일 경우
class ViewController1 : UIViewController{
    var name : String = " 약한김벼리 뷰컨"
    func doSomething(){
        DispatchQueue.global().async { [weak self] in
            sleep(3)
            print("글로벌큐에서 출력하기 : \(self?.name)")
        }
    }
    
    deinit{
        print("\(name) 메모리 해제 ")
    }
}

func localScopeFunction1(){
    let vc = ViewController1()
    vc.doSomething()
}

//💠
localScopeFunction1()
//약한김벼리 뷰컨 메모리 해제
//글로벌큐에서 출력하기 : nil
/**============================================================================
 1.  localScopeFunction 이 스택1에 올라감. ->   class ViewController : 를 가리키고 있음  rc+1
 2.  doSomething() 이 스택1에 올라감 -> 클로저 함수를 생성함 -> 클로저 함수가 class ViewController : name을 가리키고 있음  <(weak 이기 때문에 rc + 없음)
 3. 스택2 에 클로저함수 "실행"  -> sleep(3) 이 실행됨.
 4.  localScopeFunction 이 종료됨 rc-1    ----- sleep(3) 진행중  <--  rc 0 이 되면서 vc 가 사라짐
 5. 약한김벼리 뷰컨 메모리 해제  출력
 6.3초 후 print() 출력 : 글로벌큐에서 출력하기 : nil  <-- vc가 사라졌기 때문에 nil이 출력됨
 ============================================================================*/


