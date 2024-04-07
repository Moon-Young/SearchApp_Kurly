//
//  Repository.swift
//  Kurly_UI_1
//
//  Created by Moonyoung Kim on 4/6/24.
//

import Foundation


struct Repository {
    var totalCount: Int
    var detailRepository: [DetailRepository]
}

struct DetailRepository {
    var name: String
    var description: String
    var thumbnail: String
    var url: String
}
