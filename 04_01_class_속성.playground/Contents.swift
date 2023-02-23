import UIKit

class Book{
    var name : String
    var price : Int
    var company : String
    var author : String
    var pages : Int
    
    init( name : String, price : Int, company : String, author : String,  pages : Int){
        self.name = name
        self.price = price
        self.company = company
        self.author = author
        self.pages = pages
    }
}

var firstBook = Book(name: "벼리이야기", price: 600, company: "벼리co", author: "김동욱", pages: 6000)
firstBook.name



// 클래스와 구조체의 저장속성 :  값이 저장되는 일반적인 속성.
//저장속성 : 클래스 , 구조체 동일하다.

//지연저장속성(lazy var) : 속성에 접근한 순간 초기화됨. ( 메모리 공간이 생기고 값이 저장됨)

class Dog{
    var name = "벼리"
    lazy var weight = 6
        
    init( name: String){
        self.name = name
//        self.weight = weight
    }
}

var byuri = Dog(name: "벼리앙앙") //weight 가 초기화되지 않음.
byuri.weight = 8 // 접근하는 순간 메모리 공간이 생김.
//print(byuri.weight)







//계산속성-----------------------------------------------------------------------------------------------------------
//계산속성이 왜 필요할까? :
//              1. 저장속성을 계산해서 나온느 방식의 메소드 를 속성처럼 만든 것이다. .calculate()메소드 를 사용하지 않고 .변수명 을 사용하여 계산이 가능하다.> 명확성up
//              2. set,get 을 한번에 구현 가능하다.
//              3. 겉모습은 속성이지만 실제로는 메소드이다.
//              4. var 로만 선언 해야 하고, 자료형을 꼭 선언 해주어야 한다.
//계산 속성의 예제
class Person{  // 클래스 생성
    var birth: Int = 0 // 저장속성 태어난 년도 생성
    var height : Int = 170
    var wight : Int = 70
    
    //age라는계산속성 생성
    // 변수에 바로 중괄호 { } 가 나오면 계산속성이구나! 라고 알 줄 알아야 함.
    var age: Int{
        //get, set 은 세트로 움직임.
        //계산속성 = get 메소드, set 메소드를 하나로 묶은 것. get은 반드시 구현해야 하나, set은 생략 가능함.
        get{
            return 2023 - birth
        }
        set(age){   // 파라미터가 필요하기 때문에 (파라미터를 추가해줌)
            self.birth = 2023 - age
        }
    }
    /*
    func getAge() -> Int{  //나이를 얻는 메소드 int를 리턴
        return 2022 - birth   //2021 기준으로 태어난 년도를 빼서 나이를 얻음
    }
    
    func setAge( _ age : Int){    // 태어난 년도를 얻음
        self.birth = 2022 - age // 태어난 년도 = 2021 기준년도 - 나이
    }*/
}

var p1 = Person()
p1.birth = 1991    //                               **** 1. 나는 91년생이라서 91년생으로 셋팅 했어. (32살)
//p1.getAge()

//계산속성
p1.age       //get. 실제로 get블록을 실행시킴  개발자의 입장에서 값을 얻기 위한 활동
p1.age = 31  //set. 값을 셋팅하기 위한 활동               ****2. 빠른년생이라 다시 31로 나이를 셋팅했어.
p1.birth    //                                      ****3. 나이를 31로 셋팅했더니 1992가 나왔어.



class Bmi{
    var height : Double = 190
    var weight : Double = 80
    
    func calculateBmi() -> Double{
        let bmi = weight / (height * height) * 10000
        return Double(bmi)
    }
}



class BmiCP{
    var height : Double = 165
    var weight : Double = 57

    var bmi : Double {
        get{
            let rslt = weight / (height * height) * 10000
            return rslt
        }
    }
}


let pBmi = Bmi()
//pBmi.height = 30
//pBmi.weight = 20
pBmi.calculateBmi()


var pBmiCp = BmiCP()
pBmiCp.bmi






//타입속성-----------------------------------------------------------------------------------------------------------
//타입속성이란?  모든 인스턴스에 공유할 수 있는, 불변의 속성을 말한다. 메모리공간을 계속 가지고 있다.
//1. 저장타입속성==============================================================
//2. 계산타입속성
class Dog11{
    static var species : String = "Dog" //모든 인스턴스에 공유할 수 있는, 불변의 속성 = 타입속성
    
    var name : String
    var weight : Double
    
    init(name : String, weight: Double){
        self.name = name
        self.weight = weight
    }
}

let dog = Dog11(name: "벼리", weight: 8.0)
dog.weight   //인스턴스에서는 species로 접근 불가능하다.
Dog11.species  //타입에서 접근해야만 한다.



//저장타입 속성의 예제
class Circle{
    static var pi : Double = 3.14  //불변하는 속성
    static var count : Int = 0  //인스턴스에 속해있지 않다. 공유되는 자원이다.

    var radius : Double
    
    var diameter : Double{
        get{
            return radius * 2
        }
        set{
            radius = newValue / 2
        }
    }
    
    init(radius: Double){
        self.radius = radius
        Circle.count += 1
    }
}

//생성자
Circle(radius: 2)
var cir = Circle(radius: 4)
Circle.count

Circle(radius: 3)
Circle.count // 이런식으로 저장타입속성(.count)를 통해서 인스턴스의 호출 갯수를 알 수 있다.


Double.pi //double 이라는 타입 자체에 pi 라는 저장속성타입이 있다.


//2.계산타입속성==============================================================
//static(타입) + 계산속성
class Circle01{
    static let pi : Double = 3.14
    static var count : Int = 0
    
    //계산타입속성
    static var multiPi : Double{
        return Circle01.pi * 2
    }
    
    //저장속성
    var radius : Double
    
    init(radius : Double){
        self.radius = radius
        Circle01.count += 1
    }
    
    //메소드 구현 시 타입의 저장속성을 사용하는 것이기 때문에 타입속성 사용 시 -> 타입.타입저장속성 형식으로 사용해야 한다.
    func getArea() -> Double{
        var area = Circle01.pi * radius * radius
        return area
    }
}

var rad1 = Circle01(radius: z.4)
rad1.getArea()



//속성 감시자 property observer  = 저장속성 감시자. 저장속성을 감시하는 것.------------------------------------------------------------------
//속성 감시자가 왜 필요할까?? 변수의 값이 변경되었을 때 바로 변경내용을 바로 업데이트 하고 싶을 때 사용됨.
//willSet : 값이 저장되기 전에 호출됨
//didSet  : 값이 저장된 후에 호출됨 (*** 주로 어플 개발시에는 didSet만 사용된다)
//willSet : 저장속성을 관찰하는 메소드. 저장속성의 메모리 안의 값이 변경이 될 때마다 실행된다.

class Profile{
    
    //일반 저장 속성
    var name : String = "이름"
    
    //저장속성 + 저장속성 감시자
    var statusMessage : String = "기본 상태메세지"{   //statusMessage 속성이 변할 때마다 실행됨
        // 값이 저장되기 직전에 호출됨
        willSet(message){
            print( "(예정!)내 상태메세지가 변경될 예정입니다 : \(statusMessage)  -> \(message)")   //기본상태메세지 -> 졸려
        }
        //값이 저장된 후에 호출됨 (*** 주로 어플 개발시에는 didSet만 사용된다)
        didSet(message){
            //message = 값 바뀌기 전 데이터 & statusMessage = 값 바뀌고 난 뒤의 데이터 존재
            print("(변경후) 내 상태메세지 변경되었습니다 : \(message)  -> \(statusMessage)")
        }
        /*
         didSet{    //애플이 oldValue 라는 파라미터를 미리 넣어둠. (파라미터) 없이 oldValue라는 변수를 사용해도 됨
            print("(변경후) 내 상태메세지 변경되었습니다 : \(oldValue)  -> \(statusMessage)")  //값 바뀌고 난 뒤
         }
         */
        
        
    }
    
    init(message : String){
        self.statusMessage = message
    }
}

var pff = Profile(message : "기본상태") //초기화 할 떄는 will/didSet 호출안됨.
pff.statusMessage = "졸려"

//var pf = Profile()
//pf.statusMessage = "행복해"
//pf.statusMessage = "배고파"
