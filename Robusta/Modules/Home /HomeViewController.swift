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

    @IBOutlet weak var githubTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeCells()
        viewModel.viewDidLoad()
    }
    
    override func bind(viewModel: HomeViewModel) {
        viewModel.githubRepoObservable.bind(to: githubTableView.rx.items(cellIdentifier: String(describing: GithubTableViewCell.self), cellType: GithubTableViewCell.self)) {( index , model ,cell) in
            cell.configGithub(githubRepo: model)
        }.disposed(by: self.disposeBag)
    }
    
    func intializeCells() {
        githubTableView.registerCellNib(cellClass: GithubTableViewCell.self)
    }
}
