//
//  HomeViewModel.swift
//  Robusta
//
//  Created by A on 02/04/2023.
//

import UIKit
import RxCocoa
import RxSwift

protocol HomeViewModelnputProtocol {
    func viewDidLoad()
    func didSelectRepo(inedxPath: IndexPath)
}

protocol HomeViewModeOutputProtocol {
    var navigateToNextView:PublishSubject<UserElement> {get set}
}

class HomeViewModel: BaseViewModel, HomeViewModelnputProtocol, HomeViewModeOutputProtocol {
    
    private var githubRepo = PublishSubject<[UserElement]>.init()
    var githubRepoObservable: Observable<[UserElement]> {
        return githubRepo
    }
    var navigateToNextView: PublishSubject<UserElement> = .init()
    let homeUseCase: HomeUseCase
    let disposeBag = DisposeBag()
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    
    func viewDidLoad() {
        fetchPopularRepo()
    }
    
    func didSelectRepo(inedxPath: IndexPath) {
        
    }
    
    func fetchPopularRepo() {
        self.isLoading.onNext(true)
        self.homeUseCase.fetchGithubRepo()
            .subscribe { [weak self] repoData in
                guard let self = self else {return}
                self.isLoading.onNext(false)
                self.githubRepo.onNext(repoData)
            } onError: { _ in
                self.isLoading.onNext(false)
            } onCompleted: {
                self.isLoading.onNext(false)
            } .disposed(by: self.disposeBag)
    }
    
}
