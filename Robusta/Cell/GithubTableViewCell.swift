//
//  GithubTableViewCell.swift
//  Robusta
//
//  Created by A on 02/04/2023.
//

import UIKit

class GithubTableViewCell: UITableViewCell {

    @IBOutlet weak var githubAvatarImageView: LazyImageView!
    @IBOutlet weak var githubRepoLabel: UILabel!
    @IBOutlet weak var githubDataLabel: UILabel!
    @IBOutlet weak var githubNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configGithub(githubRepo: UserElement) {
        githubNameLabel.text = githubRepo.fullName
        githubRepoLabel.text = githubRepo.owner?.login
        if let githubAvatar = URL(string:  (githubRepo.owner?.avatarURL)!) {
        githubAvatarImageView.loadImage(fromURL:githubAvatar, placeHolderImage: "LaunchImage")
        }
    }
}
