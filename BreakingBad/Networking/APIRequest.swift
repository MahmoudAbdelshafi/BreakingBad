//
//  APIRequest.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import Foundation
import Alamofire

class ApiRequest{
    static func apiCall<T : Decodable>(responseModel: T.Type, request : ApiRouter,  completionHandeler: @escaping (Result<T,ErrorHandler>) -> Void) {
        AF.request(request).responseData { (response : AFDataResponse<Data>) in
            guard let statusCode = (response.response?.statusCode)
            else{
                completionHandeler(.failure(.general))
                return
            }
            switch response.result{
            case .success(let result):
                guard !result.isEmpty else {
                    completionHandeler(.failure(.general))
                    return
                }
                do {
                    let obj = try JSONDecoder().decode(T.self, from: result)
                    completionHandeler(.success(obj))
                    
                } catch {
                    completionHandeler(.failure(.general))
                }
            case .failure:
                completionHandeler(.failure(.checkStatus(code: statusCode)))
            }
        }
    }
}
