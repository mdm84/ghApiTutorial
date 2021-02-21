//
//  GithubUserDetail.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import UIKit
import SafariServices

class GithubUserDetail: UIViewController {
  @IBOutlet private weak var avatar: UIImageView!
  @IBOutlet private weak var username: UILabel!
  @IBOutlet private weak var email: UILabel!
  @IBOutlet private weak var location: UILabel!
  @IBOutlet private weak var joindate: UILabel!
  @IBOutlet private weak var followers: UILabel!
  @IBOutlet private weak var following: UILabel!
  @IBOutlet private weak var bio: UILabel!
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.isHidden = true
      tableView.register(UINib(nibName: "ReposCell", bundle: nil), forCellReuseIdentifier: ReposCell.identifier)
      tableView.keyboardDismissMode = .onDrag
      tableView.tableFooterView = UIView()
    }
  }
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
      searchBar.isHidden = true
    }
  }
  static let identifier: String = "githubUserDetail"
  private var viewModel: UsersViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  override func viewDidDisappear(_ animated: Bool) {
    viewModel.unselectUser()
  }
  
  func set(viewModel: UsersViewModel) {
    self.viewModel = viewModel
  }
  
  private func updateUI() {
    guard let user = viewModel.getSelectedUserInfo() else {
      return
    }
    username.text = user.login
    email.text = user.email
    location.text = user.location
    joindate.text = user.createdAt
    followers.text = "\(user.followers ?? 0) Followers"
    following.text = "Following \(user.following ?? 0)"
    bio.text = user.bio
    if let url = URL(string:  user.avatarUrl ?? "") {
      self.avatar.loadImage(at: url, with: true)
    } else {
      avatar.image = ImageLoader.shared.placeholder
    }
    updateRepoSection()
  }
  private func updateRepoSection() {
    viewModel.getRepos { error in
      if error == nil {
        self.searchBar.isHidden = false
        self.tableView.isHidden = false
        self.tableView.reloadData()
      }
    }
  }
}

extension GithubUserDetail: UITableViewDelegate & UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.reposCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReposCell.identifier, for: indexPath) as! ReposCell
    cell.repo = viewModel.getRepo(by: indexPath.row)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let controller = viewModel.toGithubRepoPage(index: indexPath.row, delegate: self) else { return }
    self.present(controller, animated: true, completion: nil)
  }
}

extension GithubUserDetail: UISearchBarDelegate {
  private func update() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.evalRepoSearch(searchBar.text ?? "") {
      self.update()
    }
    searchBar.searchTextField.resignFirstResponder()
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.evalRepoSearch("") {
      self.update()
    }
    searchBar.searchTextField.resignFirstResponder()
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.evalRepoSearch(searchBar.text ?? "") {
      self.update()
    }
  }
}

extension GithubUserDetail: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
