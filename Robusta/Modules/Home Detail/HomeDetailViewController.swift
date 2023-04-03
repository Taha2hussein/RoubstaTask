//
//  HomeDetailViewController.swift
//  Robusta
//
//  Created by A on 02/04/2023.
//

import UIKit

class HomeDetailViewController: BaseWireframe<HomeDetailViewModel> {
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoImage: LazyImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func bindStates() {
        viewModel.githubRepoObservable.subscribe {[weak self] repo in
            guard let repo = repo.element , let self = self else {return}
            self.repoName.text = repo.fullName
            if let githubAvatar = URL(string:  (repo.owner?.avatarURL)!) {
                self.repoImage.loadImage(fromURL: githubAvatar, placeHolderImage: "LaunchImage")
            }
        }.disposed(by: self.disposeBag)
    }
}
