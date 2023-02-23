import UIKit

/*=======================================
 중첩타입 : 타입 내부에 타입을 선언하는 방식
 왜 중첩타입을 사용할까?
    - 특정 타입 내에서만 사용하기 위해서
    - 타입 간 연관성을 나타내기 위해서 , 따라서 내부 구조를 디테일하게 설계할 수 있다.
  ✨[ 변수 : 타입 = 인스턴스 ] 형태가 된다는 것을 기억하자!!!!!
  ✨ 타입.타입.타입 시 대문자가 나오면 중첩 타입이라는 것을 인지하자! (ex. Formatter.Style.Full... )
=========================================*/

class Aclass{
    struct Bstruct{
        
        enum Cenum{
            case aCase
            case bCase
            
            struct Dstruct{
                
            }
        }
        
        var name : Cenum
    }
}

//타입선언 = 인스턴스 선언
let aClass : Aclass = Aclass()

let bStruct : Aclass.Bstruct = Aclass.Bstruct(name: .bCase)
let aaStruct : Aclass.Bstruct = Aclass.Bstruct(name: Aclass.Bstruct.Cenum.aCase)
let abStruct : Aclass.Bstruct = Aclass.Bstruct(name: Aclass.Bstruct.Cenum.bCase)

let cEnum : Aclass.Bstruct.Cenum = Aclass.Bstruct.Cenum.aCase

let dStruct : Aclass.Bstruct.Cenum.Dstruct = Aclass.Bstruct.Cenum.Dstruct()


//apple 공식문서 예제 ------------------------------------------------------
struct BlackjackCard{
    //Suit 열거형
    enum Suit : Character{ //character 원시값(rawValue) 타입 사용
        case spades = "♠"
        case hearts = "❤"
        case diamonds = "◆"
        case clubs = "♧"
    }
    
    //숫자 열거형
    enum Rank : Int{ //Int 원시값(rawValue) 타입 사용
        case two = 2 , three, four, five, six, seven, eight, nine, ten
        //원시값 있지만 원시값 말고 다른 타입도 사용하고 싶어.
        case jack
        case queen
        case king
        case ace
        
        //Values 타입 정의 : 왜? Rank 열거형의 값을 이용해서 새로운 타입을 반환하기 위해서
        struct Values{
            let first : Int
            let second : Int?
        }
        
        //계산 속성
        //속성이름 : values
        //속성타입 : Values
        var values : Values{
            get{                //get 계산속성은 접근했을 때 무언가를 가지고 값을 return 해준다.
                switch self{    // self = Rank  : enum 타입 내부에 선언되어 있기 때문에 여기서 self 는 Rank이다.
                case .ace:  //Rank = Rank.ace
                    return Values(first : 1, second : 11) //Ace 카드는 1 또는 11로 사용됨
                case .jack, .queen, .king:
                    return Values(first : 10, second : nil) //jack,queen,king 은 10으로 사용됨
                default :
                    return Values(first : self.rawValue, second : nil) //self.rawValue = 2,3,4,5...
                }
            }
        }
    }
    
    //블랙잭 카드의 속성과 메소드
    //모든 카드는 숫자(2,3,4,...,jack, king, queen, ace)와 Suit(♠,❤,◆,♧)를 가진다.
    let rank : Rank
    let suit : Suit
    
    //블랙잭 카드 계산속성
    var description: String{
        var output = "\(suit.rawValue) 세트,"
        output += "숫자 \(rank.values.first)"
        
        if let second = rank.values.second{
            output += "또는 \(second)"
        }
        return output
    }
}
    
    
    
    // A - spades
    let spadeCard = BlackjackCard(rank: .ace, suit: .spades)
    print("card : \(spadeCard.description)")


let cardHearts = BlackjackCard(rank: .five, suit: .hearts)
print("card2 : \(cardHearts.description)")



