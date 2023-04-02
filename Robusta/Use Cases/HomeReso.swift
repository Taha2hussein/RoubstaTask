//
//  HomeReso.swift
//  Robusta
//
//  Created by A on 02/04/2023.
//

import Foundation
import RxSwift
protocol HomeRepositryProtocol {
    func fetchGithubRepo()-> Observable<[UserElement]>
}

class HomeRepositry: HomeRepositryProtocol {
    let networking: NetworkService
    init(network: NetworkService = NetworkService.shared) {
        self.networking = network
    }
}

extension HomeRepositry {
    func fetchGithubRepo() -> Observable<[UserElement]> {
        Observable<[UserElement]>.create {[weak self] (item) -> Disposable in
            self?.networking.request(GithubRepoEndpoint.fetchGithubRepos) { (result: Result<[UserElement]>) in
                switch result {
                case .success(let data):
                    item.onNext(data)
                    item.onCompleted()
                case .failure(let fail):
                    item.onError(fail)
                }
            }
            
            return Disposables.create()
        }
    }
}
