//
//  HomeViewController.swift
//  Robusta
//
//  Created by A on 02/04/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class HomeViewController: BaseWireframe<HomeViewModel> {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var githubTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeCells()
        viewModel.viewDidLoad()
        selectGithubRpose()
        subscribeToNavigateToDetails()
        initialSetup()
        subscribeOnFilterText()
    }
    
    func intializeCells() {
        githubTableView.registerCellNib(cellClass: GithubTableViewCell.self)
    }
    
    override func bind(viewModel: HomeViewModel) {
        viewModel.githubRepoObservable.bind(to: githubTableView.rx.items(cellIdentifier: String(describing: GithubTableViewCell.self), cellType: GithubTableViewCell.self)) {( index , model ,cell) in
            cell.configGithub(githubRepo: model)
        }.disposed(by: self.disposeBag)
    }
    
    func subscribeToNavigateToDetails() {
        viewModel.navigateToNextView.subscribe {[weak self] repo in
            guard let repo = repo.element ,let self = self else { return }
            self.coordinator.Main.navigate(from: self, to: .itemDetails(repo: repo), with: .push)
        }.disposed(by: disposeBag)
    }
    
    func selectGithubRpose() {
        githubTableView.rx
            .itemSelected.subscribe {[weak self] repo in
                if let repo = repo.element , let self = self {
                    self.viewModel.didSelectRepo(inedxPath: repo)
                }
            } .disposed(by: self.disposeBag)
    }

    func subscribeOnFilterText() {
        viewModel.filterText.subscribe(onNext: { [weak self] text in
            guard let self = self else {return}
            self.viewModel.filterRepos(withString: text)
        }).disposed(by: disposeBag)
    }
    
    private func initialSetup() {
        searchTextField.rx.text
            .subscribe(onNext: { [weak self] text in
                guard let self = self else {return}
                self.viewModel.filterText.accept(text?.lowercased() ?? "")
            })
            .disposed(by: disposeBag)
    }
}
