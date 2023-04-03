//
//  HomeViewModel.swift
//  Robusta
//
//  Created by A on 02/04/2023.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay
protocol HomeViewModelnputProtocol {
    func viewDidLoad()
    func didSelectRepo(inedxPath: IndexPath)
}

protocol HomeViewModeOutputProtocol {
    var navigateToNextView:PublishSubject<UserElement> {get set}
}

class HomeViewModel: BaseViewModel, HomeViewModelnputProtocol, HomeViewModeOutputProtocol {
    let filterText:BehaviorRelay<String> = BehaviorRelay<String>(value:"")
    var filteredItems = PublishSubject<[UserElement]>.init()
    var githubRepoObservable: Observable<[UserElement]> {
            return filteredItems

    }
    var githubReposToFilter: [UserElement] = []
    var githubRepos: [UserElement] = []
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
        self.navigateToNextView.onNext(githubRepos[inedxPath.row])
    }
    
    func fetchPopularRepo() {
        self.isLoading.onNext(true)
        self.homeUseCase.fetchGithubRepo()
            .subscribe { [weak self] repoData in
                guard let self = self else {return}
                self.isLoading.onNext(false)
                self.githubRepos = repoData
                self.githubReposToFilter = repoData
                self.filteredItems.onNext(repoData)
            } onError: { _ in
                self.isLoading.onNext(false)
            } onCompleted: {
                self.isLoading.onNext(false)
            } .disposed(by: self.disposeBag)
    }
    
    @discardableResult  func filterRepos(withString filter:String) -> [UserElement] {
        var filteredRepos = self.githubReposToFilter
        if filter.count > 0 {
            filteredRepos = self.githubReposToFilter.filter({
                return $0.name?.lowercased().contains(filter.lowercased()) as! Bool
            })
        }
        self.githubRepos = filteredRepos
        self.filteredItems.onNext(filteredRepos)
        return filteredRepos
    }
}
