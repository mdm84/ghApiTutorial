//
//  UsersViewModel.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import UIKit
import SafariServices

final class UsersViewModel: GHViewModel {
  private var users: [User] = []
  private var filteredUser: [User] = []
  private var repos: [Repo] = []
  private var filteredRepos: [Repo] = []
  private var selectedUser: User?
  private var searchUserActive: Bool = false
  private var searchReposActive: Bool = false
  
  var rows: Int {
    searchUserActive ? filteredUser.count : users.count
  }
  var reposCount: Int {
    searchReposActive ? filteredRepos.count : repos.count
  }
  var emptyRepo: Bool {
    repos.count == 0
  }
  
  func getUser(by index: Int) -> User {
    searchUserActive ? filteredUser[index] : users[index]
  }
  func getRepo(by index: Int) -> Repo {
    searchReposActive ? filteredRepos[index] : repos[index]
  }
  func getSelectedUserInfo() -> User? {
    return selectedUser
  }
  func unselectUser() {
    selectedUser = nil
  }
  func getUsersList(completion: @escaping(NetworkError?)->Void) {
    getGeneralUserList { response in
      switch response {
      case .failure(let error): completion(error)
      case .success(let userListResponse):
        let logins: [String] = userListResponse.map{ $0.login ?? "" }
        var error: NetworkError?
        let group = DispatchGroup()
        for login in logins {
          group.enter()
          self.getUser(by: login) { response in
            if case let .success(userResponse) = response {
              self.users.append(userResponse)
              self.filteredUser.append(userResponse)
            } else {
              error = .connection
            }
            group.leave()
          }
        }
        group.notify(queue: .main) {
          completion(error)
        }
      }
    }
  }
  func getRepos(completion: @escaping(NetworkError?)->Void) {
    guard let user = selectedUser, let login = user.login else { return }
    apiManager.repos(by: login) { response in
      switch response {
      case .failure(let error): completion(error)
      case .success(let reposResponse):
        self.filteredRepos = reposResponse
        self.repos = reposResponse
        completion(nil)
      }
    }
  }
  func evalUserSearch(_ value: String = "", completion: @escaping()->Void) {
    filteredUser = value.count == 0
      ? users
      : users.filter { u in
        return (u.login?.lowercased().contains(value.lowercased()))!
      }
    searchUserActive = value.count > 0
    completion()
  }
  func evalRepoSearch(_ value: String = "", completion: @escaping()->Void) {
    filteredRepos = value.count == 0
      ? repos
      : repos.filter { u in
        return u.name.lowercased().contains(value.lowercased())
      }
    searchReposActive = value.count > 0
    completion()
  }
  func toUserDetail(index: Int) -> GithubUserDetail {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let detail = storyboard.instantiateViewController(identifier: GithubUserDetail.identifier) as! GithubUserDetail
    selectedUser = getUser(by: index)
    detail.set(viewModel: self)
    return detail
  }
  func toGithubRepoPage(index: Int, delegate: SFSafariViewControllerDelegate)-> SFSafariViewController? {
    let repo = getRepo(by: index)
    guard let url = URL(string: repo.url ?? "") else { return nil}
    let safariVC = SFSafariViewController(url: url)
    safariVC.delegate = delegate
    safariVC.preferredBarTintColor = .blue
    safariVC.preferredControlTintColor = .white
    return safariVC
  }
  
  private func getGeneralUserList(completion: @escaping(Result<[UserOverview],NetworkError>)->Void) {
    apiManager.users { response in
      completion(response)
    }
  }
  private func getUser(by username: String, completion: @escaping(Result<User, NetworkError>)->Void) {
    apiManager.userDetail(by: username) { response in
      completion(response)
    }
  }
  
}
