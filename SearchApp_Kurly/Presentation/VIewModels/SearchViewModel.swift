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

final class SearchViewModel {
    
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
    
    // MARK: API Data
    let githubSearchUseCase = GitHubSearchUseCase()
    
    var page = 1
    var keyword = ""
    
    lazy var repositoryTotalCount = BehaviorRelay<Int>(value: 0)
    lazy var repositoryResultObservable = BehaviorRelay<[RepositoryItemResponseDTO]>(value: [])
    lazy var isNearToBottom = BehaviorRelay<Bool>(value: false)
     
     func searchAPI(keyword: String) {
         self.page = 1
         self.keyword = keyword
         _ = GitHubSearchAPIRepository.shared.fetchRepositoryRx(keyword: keyword)
             .map {
                 self.repositoryTotalCount.accept($0.totalCount)
                 return $0.repositoryItemResponseDTO
             }
             .take(1)
             .subscribe {
                 self.repositoryResultObservable.accept($0)
             }.disposed(by: disposeBag)
     }
     
     func searchMoreAPI() {
         self.page += 1
         _ = GitHubSearchAPIRepository.shared.fetchRepositoryRx(keyword: keyword, page: self.page)
             .map { repo in
                 var repoArray: [RepositoryItemResponseDTO] = self.repositoryResultObservable.value
                 for each in repo.repositoryItemResponseDTO {
                     repoArray.append(each)
                 }
                 return repoArray
             }
             .take(1)
             .subscribe {
                 self.repositoryResultObservable.accept($0)
             }.disposed(by: disposeBag)
     }
    
    
    
}
