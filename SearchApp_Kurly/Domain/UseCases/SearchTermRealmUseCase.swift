//
//  SearchTermRealmUseCase.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//


import UIKit
import RealmSwift
import RxRelay
import RxSwift
import RxCocoa

class SearchTermRealmUseCase {
    
    private var realmDB: Realm!
    
    func fetchRealm() -> [RecentSearchTermModel] {
        realmDB = try! Realm()
        let recentSearchTermRealm = realmDB.objects(RecentSearchTermModel.self).sorted(byKeyPath: "insertDate", ascending: false)
        return Array(recentSearchTermRealm)
    }
    
    func addRecentSearchTerm(termString: String)  {
        let term = RecentSearchTermModel()
        term.searchTerm = termString
        term.termUUID = UUID()
        term.insertDate = Date()
        
        try! self.realmDB.write({
            self.realmDB.add(term)
            
            if let oldSearchTerm = realmDB.objects(RecentSearchTermModel.self).sorted(byKeyPath: "insertDate", ascending: true).first, realmDB.objects(RecentSearchTermModel.self).count > 10 {
                print("Completed delete \(oldSearchTerm)")
                realmDB.delete(oldSearchTerm)
            }
        })
    }
    func deleteAllData() {
        try! realmDB?.write({
            realmDB.deleteAll()
        })
    }
    
    func deleteSingleSearchTerm(singleTerm: RecentSearchTermModel) {
        try! realmDB.write({
            realmDB.delete(singleTerm)
        })
    }
    
    
    
}
