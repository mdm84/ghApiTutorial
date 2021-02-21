//
//  ReposCell.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import UIKit

class ReposCell: UITableViewCell {
  static let identifier = "reposCell"
  @IBOutlet private weak var repoName: UILabel!
  @IBOutlet private weak var repoStar: UILabel!
  @IBOutlet private weak var repoFork: UILabel!
  var repo: Repo? {
    willSet {
      guard let r = newValue else { return }
      configure(repo: r)
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func configure(repo: Repo) {
    repoName.text = repo.name
    repoStar.text = "\(repo.starGazersCount) stars"
    repoFork.text = "\(repo.forkCount) forks"
  }
}
