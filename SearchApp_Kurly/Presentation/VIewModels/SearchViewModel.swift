//
//  SearchViewModel.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class SearchViewModel {
    
    let disposeBag = DisposeBag()
    
     
    // MARK: Realm Data
    let searchTermRealmUseCase = SearchTermRealmUseCase()
    
    var recentSearchTermRealm: BehaviorRelay<[RecentSearchTermModel]> = BehaviorRelay(value: [])
    var recentSearchTermCompare: BehaviorRelay<[RecentSearchTermModel]> = BehaviorRelay(value: [])
    
    func getSearchTermRealmUseCase() {
        let reamData = searchTermRealmUseCase.fetchRealm()
        recentSearchTermRealm
            .accept(reamData)
    }
    
    func addSearchTermRealmUseCase(keyword: String) {
        searchTermRealmUseCase.addRecentSearchTerm(termString: keyword)
        self.getSearchTermRealmUseCase()
    }
    
    func deleteAllSearchTermRealmUseCase() {
        searchTermRealmUseCase.deleteAllData()
        self.getSearchTermRealmUseCase()
    }
    
    func deleteSingleSearchTermRealmUseCase(singleTerm: RecentSearchTermModel) {
        searchTermRealmUseCase.deleteSingleSearchTerm(singleTerm: singleTerm)
        self.getSearchTermRealmUseCase()
    }
    
}
