//
//  APIRouter.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    enum Constants {
        static var baseUrl = "https://breakingbadapi.com/api/"
    }
    
    case getCharacters(limit: Int, offset: Int)
    
    var url : URL {
        switch self {
        case .getCharacters:
            return URL(string: "\(Constants.baseUrl)characters")!
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var parameters : [String:Any] {
        switch self {
        case .getCharacters(let limit, let offset):
            return ["limit": limit, "offset": offset]
            
        //        default:
        //            return [:]
        }
    }
    
    var headers : HTTPHeaders{
        switch self {
        default:
            return ["Accept" : "application/vnd.github.v3+json"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        
        switch method {
        case .get, .delete:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}

