import UIKit

//날짜와 시간 다루기 - 문법관련 x,  framework관련 o , 암기 x
//UTC : 협정 세계시 (국제적인 표준 시간)

/*============================================================
 ✨ Date 구조체 ✨
 : 절대적 '초' 기준으로 만들어짐
 개발자들이 날짜를 다루기 편하라고 애플이 미리 만들어놓은 구조체 타입
 ============================================================*/
//Date 구조체
let now = Date()  // ✨Date 구조체를 생성하면 현재 시점을 찍어낼 수 있다.

now.timeIntervalSinceReferenceDate  //2001.1.1  00:00:00 UTC 시간 기준으로 현재시점까지의 초

let oneSecond = TimeInterval(1.0)    //1초

/*============================================================
 1. 3600초 = 1시간
 2. 3600 * 24 = 86400초 (하루)
 ============================================================*/
let yesterday = now - 86400 //(60s * 60m * 24h)


/*============================================================
 1. Calendar 구조체 : 달력을 다룸 (양력, 음력)
 2. DateFormatter 클래스 : 문자열로 변형해줌
 3. Timezone : 현재 시간의 지역을 설정
 ============================================================*/

for localName in TimeZone.knownTimeZoneIdentifiers{
    print(localName)
}

TimeZone.current


/*============================================================
 ✨✨✨✨✨✨✨✨✨  Calendar  ✨✨✨✨✨✨✨✨✨✨✨✨
 ============================================================*/
//그레고리(태양력) 보통 .current로 해서 많이 사용한다.
var calendar = Calendar.current

//지역설정 : 나라마다 날짜, 시간을 표시하는 형식과 언어가 다르다 ex. 미국 : 월-일-년
calendar.locale
calendar.timeZone

calendar.locale = Locale(identifier: "ko_KR")
//calendar.timeZone = TimeZone(identifier: "Asia/Seoul")


//✨✨component 메소드의 사용
//Date의 년,월,시,분,초 확인하는 방법
// 년 월 일
let year : Int = calendar.component(.year, from: now)
let month : Int = calendar.component(.month, from: now)
let day : Int = calendar.component(.day, from: now)

//시 분 초
let timeHour : Int = calendar.component(.hour, from: now)
let timeMinute : Int = calendar.component(.minute, from: now)
let timeSecond : Int = calendar.component(.second, from: now)

//요일
let weekday : Int = calendar.component(.weekday, from: now)
//일 -1
//월 -2
//화 -3
// ...
//토 -7

print("\(year) - \(month) - \(day)")


//✨✨dateComponent 메소드의 사용
// : 배열의 형태로 여러개의 Date 데이터를 얻고 싶을 때 사용
let myCal = Calendar.current

var myDateComponent = myCal.dateComponents([.year, .month, .day], from: now)



//1. 달력을 기준으로 나이 계산하기
class Dog{
    var name : String
    var yearOfBirth : Int
    
    init(name : String, year : Int){
        self.name = name
        self.yearOfBirth = year
    }
    //나이를 계산하는 계산 속성
    var age: Int{
        get{
            let year = Calendar.current.component(.year, from: Date())
            return year - yearOfBirth
        }
    }
}

let choco = Dog(name: "초코", year: 2015)
choco.age

//2. 열거형으로 요일을 만들고, 오늘의 요일을 계산하기
enum Weekday : Int{
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    //✨타입 계산속성
    static var today: Weekday{
        let weekday = Calendar.current.component(.weekday, from: Date())
        return Weekday(rawValue: weekday)!
    }
}
//오늘이 무슨 요일인지 알려줌
let today1 = weekday
let today = Weekday.today

Weekday.today

//3. 두 날짜 사이의 일수 계산하기
let startDate = Date()
let endDate = startDate.addingTimeInterval(3600*24*60) //60일 후

let calendar2 = Calendar.current
let someDays = calendar2.dateComponents([.day], from: startDate, to : endDate).day!  //60

//몇일차이가 나는지 확인

print("\(someDays)")




/*============================================================
 ✨✨✨✨✨✨✨✨✨  DateFormatter  ✨✨✨✨✨✨✨✨✨✨✨✨
 : 날짜/시간을 문자열(String)으로 변환하는 방법을 알려주는 class (.string) 사용
 : 1.지역설정 + 2.시간대설정 + 3. 날짜형식 + 4. 시간형식
 ============================================================*/

let formatter = DateFormatter()

//1.지역설정
formatter.locale = Locale(identifier: "ko_KR")
//2. 시간대 설정
formatter.timeZone = TimeZone.current


//3. 날짜와 시간 설정================================================
//3-1. 애플이 미리 만들어놓은 기존 형식으로 생성---------------------------------------
//(1) 날짜 표시
formatter.dateStyle = .full
formatter.dateStyle = .long
formatter.dateStyle = .medium
formatter.dateStyle = .none
formatter.dateStyle = .short

//(2) 시간 표시
formatter.timeStyle = .full
formatter.timeStyle = .long
formatter.timeStyle = .medium
formatter.timeStyle = .none
formatter.timeStyle = .short

//실제 변환하기  ( 날짜 + 시간 ) -> 원하는 형식
let someString1 = formatter.string(from: Date())
print(someString1)

//3-2. 개발자의 커스텀 대로 생성---------------------------------------
formatter.dateFormat = "yyyy/mm/dd"

let someString2 = formatter.string(from: Date())
print(someString2)


//✨문자열에서 date형식으로 변환  (.date 사용)
let newFormatter = DateFormatter()
newFormatter.dateFormat = "yyyy/mm/dd"

let someDate = newFormatter.date(from: "2021/07/12")
print(someDate)



/*============================================================
 ✨✨✨DateFormatter를 사용한 프로젝트에서의 활용예시
 ============================================================*/

struct InstaPost{
    let title : String = "제목"
    let description : String = "내용"
    
    private let date: Date = Date() // 게시물 생성을 현재 날짜로
        
    //계산속성 : 날짜를 문자열 형태로 바꿔서 리턴하는 get 속성
    var dateString : String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")   //지역설정
        
        formatter.dateStyle = .medium    // 스타일설정
        
        return formatter.string(from: date)  //date를 string 형식으로 변환
    }
}

let post1 = InstaPost()
print(post1.dateString)


/*============================================================
 ✨✨✨DateComponents 를 사용한 프로젝트에서의 활용예시
 ============================================================*/

var calendar1 = Calendar.current
calendar1.locale = Locale(identifier: "ko_KR")

var components = DateComponents()
components.calendar = calendar1


components.year = 2023
components.month = 1
components.day = 13

components.hour = 12
components.minute = 30
components.second = 30

let specifiedDate : Date = Calendar.current.date(from: components)!
print(specifiedDate)
