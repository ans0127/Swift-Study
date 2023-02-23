import UIKit

//확장 Extension=============================================================================================
//같은 타입 안에서 메소드를 추가하는 것.
//확장의 장점 : 기존에 만들었던 것보다 기능을 확장해서 사용할 수 있다. (Int, String, Double 등의 타입에도 사용가능)
// ** 소급 모델링: 이미 애플이 만들어 놓은 struct, class (ex, Int, String) 등을 편집할 수 없으니 확장해서 사용하는 것.
class Person{
    
}

extension Person{
    
}


//Int 도 애플이 미리 만들어 놓은 구조체이다.
//Int   : ctl 누르고 보면 jump to definition 으로 갈 수 있다.
extension Int{
    var squared :Int{
        return self*self
    }
}

5.squared





//1. 계산 속성의 확장 ( 타입 & 인스턴스) --------------------------------------------------------------------
extension Double{
    var squared :Double{
        return self*self
    }
}
(3.4).squared



//2. 메소드의 확장  ------------------------------------------------------------------------------------
//애플이 만든 타입메서드의 예시 (랜덤메소드)
Int.random(in: 1...100)

//타입 메소드 의 확장
extension Int{
    static func printOneToFive(){
        for i in 1...5{
            print(i)
        }
    }
}

Int.printOneToFive()

print("---------------")

//인스턴스의 확장 (예제는 string을 사용)
//소급 모델링의 적용
extension String{
    func printHi(times : Int){
        for _ in 0..<times{
            print ("hi  \(self)")
        }
    }
}

"벼리".printHi(times: 4)

//   ((  참고,
//mutating 키워드 : struct & enum 에서 저장속성의 값을 변경하고 싶을 때 사용
extension Int{
    mutating func squareme(){
        self = self*self
    }
}
var num = 10
num.squareme()
//    ))

//4. 생성자의 확장------------------------------------------------------------------
//4-1 클래스 : 클래스는 편의 생성자만 추가할 수 있다.--------------------------------------
//              convenience init() {   }

//UIColor 기본 생성자
var color = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1)   //애플에서 미리 CGFloat을 사용할 때 소수점을 사용하도록 셋팅 해뒀다.


//CGFloat = Float이고, UIKit 에서 사용하는 하나의 타입.
//RGB 는 256개이기때문에 255로 나눠준다.
//4개의 값을 입력하는 대신 1개의 값만 입력해도 UI값을 리턴받을수 있도록 확장 기능을 만들었다.
extension UIColor{
    convenience init(color: CGFloat){                                                   //편의생성자 생성
        self.init(red: color/255, green: color/255, blue: color/255, alpha: 1)          //본제의 지정생성자 호출
    }
}

//숫자 하나만 입력하면 쉽게 객체 생성 가능
UIColor(color: 1)
UIColor(color: 390)



//4-2 구조체 의 확장 --------------------------------------
//구조체는 편의 생성자처럼 생성자를 추가 or  지정생성자를 추가 해서 본체 지정생성자 호출하는 방식으로 사용 가능.
//              init(){  self.init()  }
struct Point{
    var x = 0.0
    var y = 0.0
    
    init(){                 // 편의생성자는 아니지만 생성자 추가
        self.init(x : 0.0, y: 0.0)    //본체의 지정생성자 호출
    }
    
    init(x: Double, y: Double){   //지정생성자
        self.x = x
        self.y = y
    }
}

//5. 서브스크립트의 확장
//확장을 한 후 서브스크립트를 더할 수 있다. - 당연함. 서브스크립트도 메소드이기 때문에 (이정도만 알아도 됨)
extension Int{
    subscript(num : Int) -> Int{
        
        var baseNum = 1
        for _ in 0..<num {
            baseNum *= 10
        }
        return (self / baseNum) % 10
    }
}

123456789[0]   // 123456789 / 1 % 10

//6.새로운 중첩 타입----------------------------------------------------------------------
//중첩타입이란? class 안의 class , class 안의 enum 처럼 타입을 중첩해서 사용하는 것.
class Day{
    enum Weekday{
        case mon
        case tue
        case wed
    }
    var day : Weekday = .mon
}

//중첩타입의 사용 : Day 타입의 Weekday 타입 을 선언하고, mon을 mon1에 넣음.
var mon1 : Day.Weekday = Day.Weekday.mon




//확장해서, 중첩 타입을 정의해서 사용할 수 있다.
//예제2
extension Int{
    
    enum Kind{
        case negative
        case zero
        case positive
    }
    
    var kind : Kind {  //계산속성 사용
        
        switch self{            // self = Int
        case 0 :
            return Kind.zero
        case let i where i > 0 :
            return Kind.positive
        default :
            return Kind.negative
        }
        
    }
}

4.kind
0.kind



