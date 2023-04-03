//
//  HomeDetailViewModel.swift
//  Robusta
//
//  Created by A on 03/04/2023.
//

import Foundation
import RxRelay
import RxCocoa
import RxSwift

protocol HomeDetailInputProtocol {
    func viewDidLoad()
    var githubRepoObservable: PublishSubject<UserElement> { get set }
}

class HomeDetailViewModel: BaseViewModel, HomeDetailInputProtocol {
    
    var githubRepoObservable: PublishSubject<UserElement> = .init()
    let githubRepo: UserElement
    
        init(githubRepo: UserElement) {
        self.githubRepo = githubRepo
    }
    
    func viewDidLoad() {
        githubRepoObservable.onNext(self.githubRepo)
        print(githubRepo , "githubRepos")
    }
    
}
