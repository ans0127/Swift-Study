import UIKit

//self vs Self
/**=====================================================
 self
 1. 인스턴스를 가리킴
 2. 값타입(구조체) 에서 속성 초기화 가능하다 = self를 이용해서 새롭게 붕어빵 찍어내기 가능하다.
 3. 타입메소드에서 사용하면 타입 자체를 가리키게 된다. static func ...
 =====================================================*/

//2.
struct Calcul{
    mutating func reset(){
        self = Calcul()    //새롭게 붕어빵 찍어내기 가능. (새로 생성해서 치환함)
    }
}

//3.
struct Mystr{
    static let club = "ios department"  //타입저장속성 - 코데힙스 중에서 데이터 영역에 속성이 저장된다.
    
    static func printing(){
        print(" department is \(self.club)")    //인스턴스가 아닌 타입 자체를 가리킨다.
    }
}



/**=====================================================
 Self
 1. 해당 타입을 가리키는 용도로 Self 사용 가능하다.
 2. 프로토콜을 내에서 Self를 선언하며, 채택하는 타입을 의미한다.
 =====================================================*/

//1.
extension Int{
    static let zero: Int = 0
    
    //인스턴스의 계산속성
    var zero : Self {           //Self = Int
        return 0
    }
    
    //타입 속성 메소드
    static func toZero() -> Self{   //Self = Int
        return Self.zero
    }
    
    //인스턴스 메소드
    func toZero() -> Self{      //Self = Int
        return self.zero
    }
    
}

Int.zero
Int.toZero()
5.zero
5.toZero()


//2.
extension BinaryInteger{
    func squared() -> Self {    //Self (= BinaryInteger를 채택한 모든 타입)으로 리턴이 가능하다. (ex. Int, UInt)
        return self * self
    }
}

4.squared()
8.squared()
