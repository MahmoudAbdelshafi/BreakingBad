//
//  CharacterListRepo.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import Foundation

protocol CharacterListRepo {
    func getPaginatedCharacters(limit: Int, offset: Int, completionHandeler: @escaping (Result<[Character], ErrorHandler>)->Void)
}

class CharacterListRepoImpl: CharacterListRepo {
    func getPaginatedCharacters(limit: Int, offset: Int, completionHandeler: @escaping (Result<[Character], ErrorHandler>) -> Void) {
        ApiRequest.apiCall(responseModel: [Character].self, request: .getCharacters(limit: limit, offset: offset)) { response in
            switch response {
            case .success(let characters):
                completionHandeler(.success(characters))
            case .failure(let error):
                completionHandeler(.failure(error))
            }
        }
    }
}
