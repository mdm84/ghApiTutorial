//
//  UsersListCell.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import UIKit

class UsersListCell: UITableViewCell {
  static let identifier = "userListCell"
  @IBOutlet private weak var avatar: UIImageView!
  @IBOutlet private weak var username: UILabel!
  @IBOutlet private weak var repos: UILabel!
  var user: User? {
    willSet {
      guard let u = newValue else { return }
      configure(data: u)
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  private func configure(data: User) {
    username.text = data.login
    repos.text = "repos: \(data.publicRepos ?? 0)"
    if let url = URL(string:  data.avatarUrl ?? "") {
      self.avatar.loadImage(at: url, with: true)
    } else {
      avatar.image = ImageLoader.shared.placeholder
    }
  }
  override func prepareForReuse() {
    avatar.image = UIImage()
  }
}
