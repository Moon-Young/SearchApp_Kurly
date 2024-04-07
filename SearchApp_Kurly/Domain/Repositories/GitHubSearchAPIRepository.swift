//
//  Repository.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/6/24.
//

import Foundation
import RxSwift

class GitHubSearchAPIRepository {
    
    static let shared = GitHubSearchAPIRepository()
    private init() {}
    
    private func getQuery(keyword: String?) -> String {
        guard let keyword = keyword else { return "?q="}
        return "?q=\(keyword)"
    }
    
    private func getPage(page: Int?) -> String {
        guard let page = page else { return "&page="}
        return "&page=\(page)"
    }
    
    func fetchRepository(keyword: String, page: Int? = 1, onCompleted: @escaping (Result<RepositoryResponseDTO, NetworkError>) -> Void ) {
        var apiURL: URL?
        
        apiURL = URL(string: baseAPI + getQuery(keyword: keyword) + getPage(page: page))
        guard let apiURL = apiURL else { return }
        URLSession.shared.dataTask(with: apiURL) { data, res, err in
            if err != nil {
                onCompleted(.failure(.networkingError))
                return
            }
            guard let data = data else {
                onCompleted(.failure(.dataError))
                return
            }
            do {
                let repoData = try JSONDecoder().decode(RepositoryResponseDTO.self, from: data)
                onCompleted(.success(repoData))
            } catch {
                onCompleted(.failure(.parseError))
            }
        }.resume()
    }
    
    func fetchRepositoryRx(keyword: String, page: Int? = 1) -> Observable<RepositoryResponseDTO> {
        return Observable.create { emmiter in
            self.fetchRepository(keyword: keyword, page: page) { result in
                switch result {
                case .success(let data):
                    emmiter.onNext(data)
                    emmiter.onCompleted()
                case .failure(let err):
                    emmiter.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
}
