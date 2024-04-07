//
//  RepositoryResponseDTO.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/6/24.
//

import Foundation

// MARK: - RepositoryResponseDTO
struct RepositoryResponseDTO: Codable {
    let totalCount: Int
    let repositoryItemResponseDTO: [RepositoryItemResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repositoryItemResponseDTO = "items"
    }
}

// MARK: - RepositoryItemResponseDTO
struct RepositoryItemResponseDTO: Codable {
    let name: String
    let repositoryOwnerResponseDTO: RepositoryOwnerResponseDTO

    enum CodingKeys: String, CodingKey {
        case name
        case repositoryOwnerResponseDTO = "owner"
    }
}

// MARK: - RepositoryOwnerResponseDTO
struct RepositoryOwnerResponseDTO: Codable {
    let description: String
    let thumbnail: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case description = "login"
        case thumbnail = "avatar_url"
        case url = "html_url"
    }
}

// MARK: - NetworkError
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}
