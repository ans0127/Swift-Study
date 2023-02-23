import UIKit

/*====================================================================================
 문자열과 문자 ( String and Characters )
 : swift 문자열에서는 배열의 단순  index접근이 불가능( python 은  가능)
 
 swift는 2개의 문자열을 자료형으로 사용하고 있다.
 1. String (swift 언어)
 2. NSString (objective-c 언어)
3. NSAttributedString : 글자의 색깔 크기 등으 바꿀 수 있는 조금 더 복잡한 기능을 갖고있는 타입
 ====================================================================================*/
//NSString
var nsString : NSString = "swift"
let string: String = nsString as String



/*====================================================================================
 ✨문자열을 여러줄 입력하고 싶을 때
 1. """ : 쌍따옴표  3개를 연속해서 첫줄 & 마지막줄에 입력
 2. 문자열 내부에서 자동으로 줄바꿈 됨
 3. 특수문자는 그대로 입력됨
 4. 줄바꿈 하고 싶지 않을 때는 백슬래시( \ ) 입력하면 됨
 5.마지막 줄의 """ 는 들여쓰기의 기준이 됨.
 ====================================================================================*/
let singleLineString = " \" There are the same \""

let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, " and go on
till you come to the end; then stop
"""


/*====================================================================================
 ✨ raw String : 샵 기호(#)로 문자열 앞뒤를 감싸면  샵 기호(#) 안의  문자열 그대로를 인식한다.
 ====================================================================================*/
var name = #"alex"#

let printRawString = #"My name is \#(name)"#




/*====================================================================================
 ✨ 문자열 보간법 ( String interpolation)
 : 문자열 내에서   \( 표현식)  으로 표기
 ====================================================================================*/
let name2 = "byuri"
print ("벼리의 이름은 \(name2)")

//문자열 자체에, 타입에 대한 메소드를 구현함.
struct Dog{
    var name : String
    var weight : Int
}

let dog = Dog(name: "벼리",  weight: 6 )

extension String.StringInterpolation{
    //StringInterpolation 을 호출하는 것은 결국 appendInterpolation 를 호출하는 것이다.
    mutating func appendInterpolation(_ value: Dog ){  //Dog 구조체 입력
        appendInterpolation("이름은 \(value.name) 이고, 몸무게는 \(value.weight) 입니다.")
    }
}
print(dog)
print("\(dog)")



/*====================================================================================
 ✨ 숫자를 문자열로 변환해서 출력하기
 - 문자열 생성자를 활용
 - 포멧 : String(format: <#T##String#>, <#T##arguments: CVarArg...##CVarArg#>)   // String(format: 형식을지정, 변환하고 싶은 값을 넣음)
    f : 실수
    d : 정수
 ====================================================================================*/
var pi = 3.141592
var piString : String = ""

piString = "원하는 숫자는 + " +  String(format: "%.1f", pi)
print(piString)

piString = "원하는 숫자는 + " +  String(format: "%.2f", pi)
print(piString)

piString = "원하는 숫자는 + " +  String(format: "%.3f", pi)
print(piString)

piString = String(format: "원하는 숫자는 %.3f", pi )
print(piString)

piString = "원하는 숫자는 + " +  String(format: "%d", 77)
print(piString)

piString = "원하는 숫자는 + " +  String(format: "%2d", 77)
print(piString)


/*===========================================================================
✨ NumberFormatter() : 숫자를 문자열로 바꿔주는 클래스
 ===========================================================================*/
let numberFormatter = NumberFormatter()
numberFormatter.roundingMode = .floor //반올림모드 : 버림
numberFormatter.maximumSignificantDigits = 3 // 출력하고 싶은 글자수

let piValue = 3.141592
var valueFormatted = numberFormatter.string(for: piValue)! //문자열화 시키는 메소드 (numberFormatter.string)
print(valueFormatted)

//⭐️ 세자리마다 콤마넣기
numberFormatter.numberStyle = .decimal
let price = 10000000
let result = numberFormatter.string(for: price)!
print(result)

/*===========================================================================
✨ Substring
 : 문자열을 자르는데, 자른 문자열을 새로운 메모리에 넣은 것이 아니라 기존의 문자열에서 자른 문자열만 사용하는 것
 : 문자열의 "메모리 공간 공유"의 개념의 메소드
 ===========================================================================*/
var greeting = "Hello, world ! "
let index : String.Index = greeting.firstIndex(of: ",") ?? greeting.endIndex // ,(콤마)의 인덱스
let beginning : String.SubSequence = greeting[ ..<index ] //greeting 의 메모리공간을 공유하고 있음


/*===========================================================================
✨ prefix, suffix (접두사, 접미사) 도 Substring 사용
 - 수정 등이 일어나기 전까지 메모리 공유
 - 오래 저장하기 위해서는 새롭게 문자열로 저장하는 것이 좋다.
 ===========================================================================*/
greeting = "Hello, world ! "
var word : String.SubSequence = greeting.prefix(5)

word // String.SubSequence 타입

greeting = "happy Birthday"

print(word)

word = greeting.suffix(3)  // String.SubSequence 타입
word





/*===========================================================================
✨ 문자열 다루기 ( '데이터 바구니' 이기 때문에 배열과 비슷)
 - 배열과 관련된 메소드 ( insert, replace, append, remove)
 
 - .map : 문자열 -> 문자열 배열
 - .joined : 문자열 배열 -> 문자열
 ===========================================================================*/
var someString = "Swift"
//문자열을 문자열 배열로 변환
//✨  .map :  배열 안의 인덱스 하나하나를 뽑아서 클로저를 실행 ✨
//chr 문자를 string 문자열로 변환
var array = someString.map { Character in    //[String]
    String(Character)
}
//⭐️ 실무에서는 이 방법을 주로 사용
var array1 = someString.map { String($0)}      //[String]
array1


// ✨ .joined : 문자열 배열 string -> 문자열로 변환 chr ✨
//["S", "w", "i", "f", "t"] -> swift
var newString = array1.joined()

//ex. 활용예시
//1. 문자열을 뒤죽박죽 섞기 shuffle
//- 1.  배열로 만들기 . 2. shuffled 하기 3. 다시 문자열로 만들기
var shuffledString = "Swift"

var shuffledString1 = shuffledString.map{ String($0)}.shuffled().joined()
shuffledString1


/*===========================================================================
✨ 문자열의 대소문자 변형
      == swift 는 대, 소문자를 구분한다 ==
 - .lowercased() : 전체를 소문자로 변경
 - .uppercased() : 전체를 대문자로 변경
 - .capitalized() : 첫글자를 대문자로 변경
 
 ✨문자열 갯수 세기
- .count : 문자열 갯수를 샘
- isEmpty :
 ===========================================================================*/
// "   "  =/= "" =/= nil

var space1 = "  "

space1.count  //2
space1.isEmpty  //false








/*===========================================================================
✨ String의 인덱스 타입
 - 문자열인덱스는 StringIndex를 사용한다. ( 문자열에서는 숫자형 인덱스가 적용되지 않는다.)
 
 [String.Index 타입]
 - String.startIndex
 - String.endIndex
 - String.index( string.Index, offsetBy : int)
 
 [String.Index 범위]
 - String.range(of : "tag!")  //tag라는 인덱스를 가지고 있으면 그 인덱스의 범위를 알려줘
 - String.range(of : "tag!", optional : [ .caseInsensitive ])
 ===========================================================================*/
let greeting1 = "Guten Tag!"

greeting1.startIndex
print(greeting1.startIndex)
greeting1[greeting1.startIndex]

//정수형태를 변형해서 substring을 이용해서 string의 인덱스를 가지고 문자를 알아내는 방법
var oneIndex = greeting1.index(greeting1.startIndex, offsetBy: 2)
greeting1[oneIndex]

var lastIndex = greeting1.index(greeting1.endIndex, offsetBy: -1)
greeting1[lastIndex]

//after : 다음 인덱스
//before : 이전 인덱스
greeting1.index(after: greeting1.startIndex)
greeting1.index(before: greeting1.endIndex)



//⭐️범위를 벗어나면 에러가 발생하니 주의.
var thisIndex = greeting1.index(greeting1.startIndex, offsetBy: 8)
greeting1[thisIndex]

//범위 제약을 걸어줌
if (greeting1.startIndex <= thisIndex && thisIndex < greeting1.endIndex){
    print(thisIndex)
}

//range에 문자열 인덱스의 범위를 저장
var range = greeting1.range(of: "Tag!")!
greeting1[range]


//caseInsensitive 상태로 문자열을 찾고 싶을 때
var range1 = greeting1.range(of: "tag" , options : [ .caseInsensitive ])!
greeting1[range1]






/*===========================================================================
✨ 문자열의 삽입(insert) , 추가(append), 삭제(delete), 교체 (replace)
 ===========================================================================*/


//✨Insert----------------------------------------------------------------------------------------------
//문자열의 stringIndex 형태로 삽입해야 한다.
var welcome = "Hello"
welcome.insert("1", at: welcome.startIndex)

welcome.insert(contentsOf: "2345", at: welcome.startIndex)

//✨replace----------------------------------------------------------------------------------------------
//교체하고 싶은 문자열의 범위를 추출해서, optional을 벗긴 후, 범위를 교체한다.
welcome = "Hello there!"

if let range3 = welcome.range(of: "there!") { // there! 의 range 가져올거야     *⚠️ .range =/= .ranges 주의!!!
    welcome.replaceSubrange(range3, with: "swift") //range2 를 swift로 바꿀거야
    print(welcome)
}

//replacingOccurrences : 문자열이 존재한다면 교체할거야. (Occurrences : 존재하는)
var replaceWelcome = welcome.replacingOccurrences(of: "there!", with: "swift swift!!")
replaceWelcome

var replaceWelcome2 = welcome.replacingOccurrences(of: "hello", with: "hi", options: [.caseInsensitive], range: nil)
replaceWelcome2





//✨append 추가하기----------------------------------------------------------------------------------------------
welcome.append(" 😎")
welcome




//✨remove-------------------------------------------------------------------------------------------------------
welcome = "Hello swift!"

welcome.remove(at:  welcome.index(after: welcome.startIndex))
welcome

//인덱스의 범위를 파악하고 지우기
var range4 = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex   //인덱스 범위 파악

welcome.removeSubrange(range4)  //지우기
welcome

welcome.removeAll()
welcome.removeAll(keepingCapacity: true) //메모리 용량은 살려두겠다.


// ⭐️ 문자열 삽입, 삭제의 활용
//공백문자 string index 찾아내서 문자열을 append하기
var string11 = "Hello world~!"
if let strIndex = string11.firstIndex(of: " "){    //1. 공백문자의 인덱스 찾기
    string11.insert(contentsOf: " super", at: strIndex)    //2. 공백문자 인덱스에 super 넣기
}

//공백 문자열을 찾아서, super의 문자열의 범위만들어서, 범위 삭제하기
if let firstBlankIndex = string11.firstIndex(of: " "){  //공백 문자열 찾아서
    let firstBlankRange = firstBlankIndex...string11.index(firstBlankIndex, offsetBy: 5) //공백문자열~5번째 = super 문자열 범위 생성
    string11.removeSubrange(firstBlankRange) // super문자열 범위 삭제
}

//바꿀 문자열을 정확히 알고 있을 경우 범위를 직접 리턴해서 , 범위 삭제
if let range5 = string11.range(of: "world"){
    string11.removeSubrange(range5)
}




/*===========================================================================
✨ 문자열 비교하기
 ===========================================================================*/
//비교연산자
"swift" == "Swift"
"swift" != "Swift"

//문자열 크기 비교하기 - 첫번째 문자열 비교(아스키코드값으로) , 같다면 두번째 문자열비교....
"swift" < "Swift"
"swift" > "Swift"


/*==============================================================================
 caseInsensitiveCompare : 대소문자를 무시하고 비교하는 메소드
  :  단순 같은지 틀린지 뿐 아니라
 * caseInsensitiveCompare는 열거형 타입으로 정의되어 있음.
 1. orderedAscending : 오름차순
 2. orderedDescending : 내림차순
 3. orderedSame : 동일차순
 
 ===========================================================================*/
var a = "swift"
var b = "Swift"

var result11 = a.caseInsensitiveCompare(b)

switch result11{
case .orderedAscending:
    print(" 오름차순으로 출력됨")
case .orderedDescending:
    print(" 내림차순으로 출력됨")
case .orderedSame:
    print(" 동일 차순으로 출력됨")
}

result11 == ComparisonResult.orderedSame   //true (같고, 차순이 같음)



/*===================================================================
 ✨string.compare( options : ) : compare 라는 비교 메소드가 있고 메소드 안에 많은 options가 있음

 - .anchored : (의미: 고정하다) 앞부분부터 고정(접두어)
 - .backwards : 문자 뒷자리부터
 =====================================================================**/
var name11 = " Hello world!"
var result12 = name11.compare("hello", options: [.caseInsensitive])

switch result12{
case .orderedDescending:
    print(" 내림차순으로 출력됨")
case .orderedAscending:
    print(" 오름차순으로 출력됨")
case .orderedSame:
    print(" 동일 차순으로 출력됨")
}


//.anchored
if let _ = "hi swift".range(of: "hi", options:[.anchored]){
    print("접두어일치")
}
//.anchored + .backwards
if let _ = "hi swift".range(of: "hi", options:[.anchored, .backwards]){
    print("접미어일치")
}


/*===================================================================
 ✨문자열 일부 포함여부 및 앞/뒤글자 반환
     * 문자열에서 일치여부 확인하기 *
 =====================================================================**/
let strs = "hello world!"

//contains : 전체 문자열에서 포함 여부 확인
strs.contains("hello")

//hasPrefix : 접두어를 가지고 있는지 확인
//hasSuffix : 접미어를 가지고 잇는지 확인
strs.hasPrefix("hello")
strs.hasSuffix("world")

//접두어, 접미어 반환
strs.prefix(2)
strs.suffix(2)

//공통 접두어 반환
strs.commonPrefix(with: "hello, swift")
strs.commonPrefix(with: "HELLO", options: [.caseInsensitive])

//앞 뒤를 drop 시킨 나머지를 반환
strs.dropFirst(2)
strs.dropLast(2)




/*===================================================================
 ✨ 정규식 / 정규표현식
 : '특정한 규칙' 을 가진 문자열의 집합을 표현하는 형식 언어
 : 외울 필요 없음. 보고 알 정도만 알기!!
  [0-9] : 숫자 0~9까지 사용가능
 {3} : 3자리임
 \- :  - 가 입력되었다.
 =====================================================================**/

//올바른 전화번호 형식인지 어떻게 판별할까?
let num = "010-8667-5601"

//정규식은 보통 #을 붙여서 로우스트링 형식으로 사용한다.
var numRegex = #"[0-9]{3}\-[0-9]{4}\-[0-9]{4}"#

if let _ = num.range(of: numRegex, options: [.regularExpression]){  //정규식 옵션을 넣어줘서 정규식이라고 알려줌.
    print("유효한 전화번호임.")   //optional 바인딩이 된다 = nil 이 아님 = 유효한 전화번호이다. 라고 판별
}







/*===================================================================
 ✨ 특정 문자의 검색 및 제거
 1. 앞뒤의 특정 문자를 제거하는 메소드
    : string.trimmingCharacters(in : "특정문자" )
 
 2.문자열 중간에 특정 문자를 제거하는 방법
   "특정문자"를 기준으로 잘라서,  [ 문자열 -> 배열 ]  후 다시 [ 배열 -> 문자열 ]로 변형
    : ⭐️string.components(separatedBy: "특정문자").joined()
 =====================================================================**/
var userEmail = " ans0127@naver.com "

var trimmingString = userEmail.trimmingCharacters(in: [" "])
trimmingString

trimmingString = userEmail.trimmingCharacters(in: .whitespaces)

var myString = "?swi!!!ft!"
var removeString = myString.trimmingCharacters(in: ["?","!"])



//공백 문자 기준으로 다 잘라서 요소화 시킬거야.
var nameSteve = " s t e v e "
var removeName = nameSteve.components(separatedBy: " ").joined()

var numStr = "010-8667-5601"
var numRemoveStr = numStr.components(separatedBy: "-").joined()

var numVarious = "1+2-3*4/5"
var numRemoveVarious = numVarious.components(separatedBy: ["+","-","*","/"]).joined()




//split(separator: )   는 component(separatedBy: )와 비슷하다.
var strr = "hello swift"
var arrr  = strr.split(separator: " ")// 서브스트링으로 리턴함.
arrr.joined()

//split은 substring 배열로 리턴한다.
strr.split(separator: " ")

//split은 클로저를 파라미터로 받기도 한다. (클로저에서 원하는 함수 내용 정의 가능)
strr.split { $0 == " " }


//CharacterSet 을 사용하면 더 쉽게 활용이 가능하다.
trimmingString = userEmail.trimmingCharacters(in: .whitespaces)
/*
 .whiteSpaces   //공백문자
 .uppercaseLetters   //대문자
 .symbols  //특수문자
 . . . 등
 */
name = "hello*world"
if let range = name.rangeOfCharacter(from: .symbols){  // 특수문자 의 range 반화
    print(name[range])
}
