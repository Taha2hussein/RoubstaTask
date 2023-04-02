//
//  HomeUseCase.swift
//  Robusta
//
//  Created by A on 02/04/2023.
//

import Foundation
import RxSwift

class HomeUseCase: HomeRepositryProtocol {

    let homeRepo: HomeRepositry
    let disposeBag = DisposeBag()
    init(homeRepo: HomeRepositry) {
        self.homeRepo = homeRepo
    }
}

extension HomeUseCase {
    func fetchGithubRepo() -> Observable<[UserElement]> {
        let observable = self.homeRepo.fetchGithubRepo()
        observable.subscribe { githubRepos in
            //
        }.disposed(by: self.disposeBag)
       return observable
    }
}
