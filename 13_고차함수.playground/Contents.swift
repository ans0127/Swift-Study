import UIKit
/**=======================================================================
 ✨고차함수 : input 이 함수이거나, output이 함수인 함수
                ---> 함수를 받아서(주로 클로저함수) 함수를 리턴한다.
  💠 많이 쓰이는 고차함수 3가지
  - 1) map
  - 2) filter
  - 3) reduce
 =======================================================================*/
//map : mapping  : 배열의 각 값을 새롭게 맵핑해서 새로운 배열을 리턴 (배열에 있는 함수이다.)
//map이 왜 많이 쓰일까? for문보다는 map을 사용하면 쉽게 data를 변형시킬 수 있기 때문에!
let numbers = [1, 2, 3, 4, 5]

var aa  = numbers.map { num in
    return num
}

var aa01 = numbers.map {
    return "\($0)"
}

var bb = numbers.map { num2 in
    return (num2 * 1000)        //새롭게 맵핑하는 방식 제공
}


//filter : 참(true)를 만족하는 값을 걸러서 새로운 배열을 리턴
let names = ["red", "yellow", "blue", "green", "white"]

names.filter { str in
    str.contains("r")
}

var array = [2,3,4,5,6,7]
//일반적으로 클로저를 이용해서 구현을 하고, 일반 함수로도 구현은 할 수 있다.
//클로저
var numArray = array.filter { num in
    return num % 2 == 0
}
//함수
func isEven( num : Int) -> Bool{
    return num % 2 == 0
}
//💠💠💠filter는 배열을 return 하기 때문에 두번 연속해서도 사용이 가능하다.
var doublefilter = array.filter { $0 % 2 == 0}.filter { $0 > 2 }




/**=======================================================================
 reduce : 제거하다.
 각 아이템을 결합해서 단 하나의 값으로 리턴.
 배열의 각 값을 결합해서 "제거"해나가서,줄여서 하나의 값으로 만듦.
 배열.reduce(0){ 클로저 } => 반드시 초기값, 클로저가 필요하다
 =============================================================================*/

var reduceArray = [0,1,2,3,4,5,6,7,8,9,10]
//reduceArray.reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result##(_ partialResult: Result, Int) throws -> Result#>)
//1. 초기값을 0으로 하고
//2. sum에는 초기값, num에는 인덱스의 0 번째 값을 넣고,
//3. return 값을 다시 초기값에 넣고 실행.
var resultSum = reduceArray.reduce(0) { sum, num in
    return sum + num
}

var minus = reduceArray.reduce(100) { $0 - $1 }
print(minus)



//map, filter, reduce의 합성
//배열 중 홀수만 제곱해서, 그 숫자를 다 더한 값은?
var complexArray = [0,1,2,3,4,5,6,7,8,9,10]

//complexArray.filter(  $0 % 3 == 0 ).map( $0 * $0 )
complexArray
    .filter { $0 % 2 != 0 }
    .map { $0 * $0 }
    .reduce(0){ $0 + $1 }



//기타 고차함수
/**===================================================================
 forEach : 배열 안의 각각의 아이템들을 작업 후 "하나하나"를 리턴한다.
          ( map 과는 다름! map은 작업 후 모아서 "배열"로 리턴한다 )
 ===================================================================*/
let foreachNum = [1,2,3,4,5]

foreachNum.forEach { num in
    print(num)
}

foreachNum.forEach { print("숫자 : \($0)") }

/**===================================================================
 compactMap
 - map기능 + 옵셔널제거
 - 옵셔널 자동으로 제거, 옵셔널 아닌 아이템들을 리턴해줌 (옵셔널 바인딩 기능 내장  예. String? -> String )
 ===================================================================*/

var cmArray : [String?] = ["A", nil ,"B", nil, "C"]

var cmRsltArray = cmArray.compactMap { $0 }
print(cmRsltArray)  //["A", "B", "C"]


let cmNumArray = [-2, -1, 0, 1, 2]

var positiveArray = cmNumArray.compactMap { $0 >= 0 ? $0 : nil }
print(positiveArray)    // [nil, nil, 0, 1, 2] -> [0, 1, 2]
// ( = )

var positiveArray2 = cmArray.filter { $0 != nil }.map { $0!}
print(positiveArray2)

/**===================================================================
flatMap
 - map + flat
 - 중첩된 배열을 벗겨 하나의 배열 안에 넣어서 리턴
 - 3중중첩일 경우 flatMap 2번 사용하면 된다
 ===================================================================*/
var nestedArray = [[1,2,3],[4,5,6],[7,8,9]]
print(nestedArray.flatMap{ $0 })

var nestedArray2 = [[[1,2,3],[4,5,6],[7,8,9]]]
var nstArray = nestedArray2.flatMap{$0}.flatMap{$0}



