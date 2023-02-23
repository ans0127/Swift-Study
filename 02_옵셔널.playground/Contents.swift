import UIKit

//옵셔널
//형태 : 타입에 물음표를 붙인 타입 (String? Int?)
//옵셔널은 값이 없음을 나타내는 nil 을 포함하는 타입이다. Int? = Int + nil
//nil : 값이 없을수 있다. 라는 것을 명시하는 임시적인 타입
//옵셔널 타입끼리는 연산이 불가능하다 (비어있는 임시공간'nil'이 존재하기 때문에)

var no : Int?
var name : String? = "alex"
//var id : String = nil 에러남
//name = "alex"
print(name)    // Optional("alex") 출력 시 옵셔널타입이라는 것을 알려준다.


//--옵셔널을 벗겨서 값만 출력하는 방법
//이름 끝에 "!"를 붙여준다.
print(name!)


//--Int 형을 Int? 형에 넣을 경우, Int? 형이 출력된다.
//왜냐하면 Int? = Int + nil 로, Int 보다 범위가 크기 때문에!
var num : Int  = 10
var optionNum : Int? = 20

optionNum = num
print(optionNum)  //Optional(10)




//=====================================================================
//optional 타입의 추출 방법 (4가지)------------>3번 방법을 주로 사용한다.
//1.optional 안에 값이 확실히 있을 때 강제로 벗겨낸다 - !를 붙임.
var optionId : String? = "ans0127"
print("첫번째방법 : \(optionId!)")

//2.nil 이 아니라는 것을 확인 후 강제로 벗기기
if(optionId != nil){
    print("두번째방법 : \(optionId!)")
}
//3.옵셔널바인딩 (if let 바인딩) : 바인딩을 이용해서 벗기는 방법 (값을 우아하게 벗기는 방법!)
if let s = optionId{        // s라는 상수에 값이 담긴다면 (nil이 아니기 때문에 값이 담길 수 있다면)
    print("세번째방법 : \(s)")
}
//!3-1guard let 바인딩 (자주사용**) : guard let else
func guardLet(optionId: String?){
    guard let G = optionId else {return}
    print("3-1 guard let binding 방법: \(G)")
}
guardLet(optionId : optionId)

//4. nil-coalescing 연산자 사용 : 기본값을 제시할 수 있을 때 사용하는 방법***
// 옵셔널 타입에 ?? 를 붙여서 기본값을 제공해 줌.

var beforeId :String? = nil
var afterId = beforeId ?? "baseId0127" //beforeId 의 기본값을 "baseId0127" 라고 제공한다.
//afterId는 beforeId에 기본값을 제공해주었기 때문에 무조건 String 타입이 나옴.

print("beforeId 에 nil을 넣을 경우 : \(beforeId)") // baseId0127 예상
afterId = "beforeAns0127"
print("beforeId 에 값이 있을 경우 : \(afterId)")



// 컬렉션 collection (Array Dictionay Set)
//1.Array * 순서있음. 순서대로 저장 값이 중복될 수 있음 순서가 있으니까.
let arr01 : Array<Int> = []
let arr02 : [Int] = []
var arr03 = [Int]()
arr03 = [3,4,5]
print(arr03)

//Array의 기능
/*
.count
.isEmpty
 .contains()
 .randomElement()  //랜덤으로 추출
 .swapAt(0,1)
 
 .first : 첫번째 값 리턴
 .last
 
 .startIndex
 .endIndex : 하지만 마지막 인덱스를 구하고 싶으면 endIndex -1 을 해줘야 함!!!!!
 */

//2.Dictionay : k:v 쌍으로 되어있고 순서 없음.
//3.Set : 순서 없음.

/*
 Array : insert/ replace/ append/ remove
 */

//------- 참고! Swift naming guide
// 동사원형 : 컬렉션 자체를 직접 변경한다.
// -ed,-ing : 컬렉션 자체를 변경하지는 않고, 리턴형으로 다른 컬렉션을 반환한다.
var myArray : [Int] = []
myArray = [51,52,53,54,55]

print("my Array start ")
myArray.reverse()    // 직접 변경한다.
var myArray2: [Int] = myArray.reversed() //직접 변경하지 않고, 리턴형으로 다른 컬렉션을 반환
print(myArray2)
print("my Array finish ")



//enumerate 열거하다
//enumerated() : 배열안의 요소들을 튜플의 named된 형태로 한개씩 전달
var idArray : [String] = []
idArray = [ "a", "b", "c", "d", "e", "f", "g" ]

var enumArray = idArray.enumerated()
for tuple in enumArray {
//    print(tuple)
    
}
//print("enumArray + reversed ------------")

for tuple in enumArray.reversed() {
    //print(tuple)
}
print("================= dictionary =================")

//Dictionary : 딕셔너리는 헤셔블 하다.
//hashable(hashValue할 수 있다.): hash 함수의 input 값으로 사용할 수 있다.
//dictionary에서는 value 값을 찾을 때 , hash 함수를 통해 나온 output 값을 key 값으로 했을 때 hash table에서 key값을 가지고 더 빨리 찾을 수 있기 때문에 hashable 한 hashvalue를 사용한다.

//빈 딕셔너리 생성
var emptyDic1 : Dictionary<Int, String> = [:]
var emptyDic2 = Dictionary<Int, String>()
var emptyDic3 = [Int: String]()

//딕셔너리는 subscript[] 를 사용한 문법을 주로 사용한다.

var myDic1 = [Int: String]()
myDic1 = [1: "aaa", 2: "bbb", 3: "ccc"]

myDic1[1]
print(myDic1[1])  //optional 형태이다. 가진 키값([1])이 없을 수도 있기 때문에

//if let binding을 통해서 값을 풀어서 사용한다.
if let letDic = myDic1[1]{
    print(letDic)
}

myDic1.keys
myDic1.values


//dictionary 는 update/ remove 만 있음.
// insert (삽입 ) append (가장 마지막에 추가) 는 순서가 있기 때문에, 순서가 없는 dictionary에서는 update만 사용한다.
//삭제
//subscript 사용.

myDic1[1] = "ddd"
myDic1

myDic1.updateValue("eee", forKey: 1)
myDic1


//삭제
//subscript 사용.
//remove method 사용
myDic1[1] = nil

myDic1.removeValue(forKey: 2)  //삭제하고 삭제된 값을 return 함



//딕셔너리를 중첩해서 사용할 수도 있다.
var dic01 = [Int: [String]]()
dic01[1] = ["a", "b", "c"]
dic01[2] = ["d", "e", "f"]


var dic02 = [Int: [Int : String]]()
dic02[1] = [1:"name", 2: "id", 3 :"Addr"]
dic02[2] = [1:"name2", 2: "id2", 3 :"Addr2"]

print(dic02)

print("11")


//딕셔너리를 반복문과 같이 쓰기
for( key, value ) in dic01 {
    print("key is \(key) and value is \(value)")
}


//set ( 앱 만들면서 자주 사용하지는 않음 )
//중복과 순서가 없음
var sset : Set = [1,2,3,1,2,3,4,]
print(sset)
