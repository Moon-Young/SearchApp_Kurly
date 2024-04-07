//
//  RecentSearchTermModel.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/6/24.
//

import Foundation
import RealmSwift

final class RecentSearchTermModel: Object {
    @objc dynamic var searchTerm: String?
    @objc dynamic var insertDate: Date?
    @objc dynamic var termUUID: UUID?
}
