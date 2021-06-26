//
//  HomeScreenVewModel.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import Foundation
import RxSwift
import RxCocoa

class CharacterListViewModel {
    
    //MARK:- Properties
    
    var headerImages: Observable<[String]>{ return headerImagesResponse.asObservable() }
    var characters: Observable<[Character]>{ return charactersResponse.asObservable() }
    var errorMessage: Observable<String>{ return errorResponse }
    let loading: PublishSubject<Bool> = PublishSubject()
    
    private let characterListRepo: CharacterListRepo
    private var offset = 0  /// offset is the last element in the current characters list
    private var charactersResponse = BehaviorRelay(value: [Character]())
    private let headerImagesResponse = BehaviorRelay(value: ["header1", "header2", "header3"])
    private var errorResponse = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    private var fetching = false
    
    init(characterListRepo: CharacterListRepo) {
        self.characterListRepo = characterListRepo
    }
    
    func getCharacters() {
        if fetching { return }
        fetching = true
        loading.onNext(true)
        characterListRepo.getPaginatedCharacters(limit: 20, offset: offset) { [weak self] (result) in
            guard let self = self else { return }
            self.loading.onNext(false)
            self.fetching = false
            switch result {
            case .success(let characters): self.charactersResponse.accept(self.charactersResponse.value + characters)
                self.offset = characters.last?.charID ?? 0
            case .failure(let error): self.errorResponse.onNext(error.errorMessage)
            }
        }
    }
}
