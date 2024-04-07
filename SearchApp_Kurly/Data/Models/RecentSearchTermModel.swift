//
//  RecentSearchTermModel.swift
//  Kurly_UI_1
//
//  Created by Moonyoung Kim on 3/31/24.
//

import Foundation
import RealmSwift

class RecentSearchTermModel: Object {
    @objc dynamic var searchTerm: String?
    @objc dynamic var insertDate: Date?
    @objc dynamic var termUUID: UUID?
}
