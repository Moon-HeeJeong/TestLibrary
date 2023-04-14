//
//  MyAPI.swift
//  MHAPITest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/10.
//

import Foundation
import Alamofire
import MHAPI

/** AppleResponse에서 data로 받을 공통적인 형식 **/
public protocol AppleDataType_P: DataType_P{
    var resultCount: Int? {get set}
    var results: [ResultList]? {get set}

    init(resultCount: Int?, results: [ResultList]?)
}

public class AppleAPI: MH_API_P{
    public var session: Session = Session.default
    
    public var trustManager: ServerTrustManager? = {
        nil
    }()
    
    public var sessionConfig: URLSessionConfiguration? = {
        nil
    }()
}

public class AppleAPIConfig: MH_APIConfig_P{
    public var headers: HTTPHeaders?{
        //[:]
        nil
    }
    
    public var baseURL: String{
        "https://itunes.apple.com/"
    }
}

//response
public struct AppleResponse<T: AppleDataType_P>: Response_P{
    
    public var responseType: Response_E
    public var data: T?
    
    enum CodingKeys: CodingKey {
        case resultCount
        case results
    }
    
    public init(responseType: Response_E, data: T?) {
        self.responseType = responseType
        self.data = data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultCount = try? container.decode(Int.self, forKey: .resultCount)
        let results = try? container.decode([ResultList].self, forKey: .results)
        
        self.data = T(resultCount: resultCount, results: results)
        
        if let _ = self.data{
            self.responseType = .ok(message: "")
        }else{
            self.responseType = .error(code: -1, message: "")
        }
    }
}


//data
public struct SearchData: AppleDataType_P{

    public var resultCount: Int?
    public var results: [ResultList]?

    public init(resultCount: Int?, results: [ResultList]?) {
        self.resultCount = resultCount
        self.results = results
    }
}
public struct ResultList: Model_T{
    let ipadScreenshotUrls: [String]
    var isGameCenterEnabled: Bool?
}

//api info (API마다 작성)
public struct SearchAPIInfo: MH_APIInfo_P{
    
    public typealias Response = AppleResponse<SearchData>
    
    public let keyword: String?
    public var config: MH_APIConfig_P?
    public var short: String{
        if let keyword = keyword{
            return "search?term=\(keyword)&media=software"
        }else{
            return "search?term=''&media=software"
        }
    }
    
    public var method: HTTPMethod{
        .get
    }
    
    public var parameters: Parameters?
    
    init(keyword: String?, config: MH_APIConfig_P? = nil) {
        self.keyword = keyword
        self.config = config
    }
}

