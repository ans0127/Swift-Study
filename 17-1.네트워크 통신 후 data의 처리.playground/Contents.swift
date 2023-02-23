import UIKit

/*==========================================================================
 요청(Reqest) -> 서버에서 데이터 받음(Json) -> 분석(Parse) -> 변환(개발자가 사용하려는 class/struct)

 //json형태의  data를 swift 코드로 변환해주는 사이트
 //app.quicktype.io
 ==========================================================================*/

//✨서버에서 주는 데이터의 형태--------------------------------------------------------------------------------------------
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let movieCD, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String
}

//✨내가 사용하고 싶은 형태로 바꿈. struct/ class 생성--------------------------------------
struct Movie{
    static var movieId : Int = 0
    let movieNm : String
    let openDt : String
    let rank : String
    let audiCnt : String
    
    init(movieNm : String, openDt : String, rank : String, audiCnt : String) {
        self.movieNm = movieNm
        self.openDt = openDt
        self.rank = rank
        self.audiCnt = audiCnt
        Movie.movieId += 1
    }
}

//✨서버와 통신-------------------------------------------------------------------------------------------------------------
//서버와 통신에 필요한 것들을 MovieDataManager구조체 안에 담음.
struct MovieDataManager {
    //URL
    let movieURL = " http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    let myKey = "c9cd2800c28f68451d31ef9b706b152c"
    let date = 20220101
    //fetch : 가져오다.
    func fetchMovie(data: String, completion: @escaping ([Movie]? ) -> Void)  {
        let urlString : String = "\(movieURL)&key=\(myKey)&targetDt=\(date)"
        performRequest(with: urlString) { movies in
            completion(movies)
        }
    }
    
    func performRequest(with urlString : String, completion : @escaping ([Movie]? ) -> Void  ) {
        //1. URL 구조체 만들기
        guard let url = URL( string: urlString ) else { return }
        
        //2.URLSession 생성
        let session = URLSession(configuration : .default)
        
        //3.세션에 작업 부여 dataTask 시작
        let task = session.dataTask(with : url) { (data, response, error ) in
            if error != nil {
                print(error!)
                completion(nil) //completion 이라는 콜백함수에 nil을 던져줌
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            //데이터 분석하기
            if let movies = self.parseJSON(safeData){
                completion(movies)    //배열 형태로 completion 함수에 던져줌
            }else{
                completion(nil)
            }
        }
        //4.task실행
        task.resume()
    }
    
    //받아온 data를 개발자가 쓰기 좋게 분석하는 방법 ( parse : 분석, decode : 데이터를 코드로 변형 )
    //data를 movie 배열로 바꿔주는 함수
    func parseJSON(_ movieData : Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MovieData.self , from: movieData)
            let dailyLists = decodedData.boxOfficeResult.dailyBoxOfficeList
            
            //고차함수를 이용해 movie  배열 생성
            let myMovieLists = dailyLists.map{
                //openDt : String, rank : Int, audiCnt : Int) {
                Movie(movieNm: $0.movieNm, openDt: $0.openDt, rank: $0.rank, audiCnt: $0.audiCnt)
            }
            return myMovieLists
        }catch{
            print("파싱 실패")
            return nil
        }
    }
}
    
    
    
//뷰컨트롤러에서 일어나는 일 ========================================================

//빈배열
var downloadeMovies = [Movie]()

//데이터를 다운로드 및 분석/변환
let movieManager = MovieDataManager()

//실제 다운로드 코드
movieManager.fetchMovie(data: "20230201") { ( movies ) in
    if let movies = movies{
        downloadeMovies = movies
        dump(downloadeMovies)
        
        print("전체 영화 갯수 : \(Movie.movieId)")
    }else{
        print("nil : 영화데이터 없음. 다운로드에 실패 ")
    }
}
