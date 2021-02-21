//
//  ViewController.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import UIKit

class GithubUsersList: UIViewController {
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: "UsersListCell", bundle: nil), forCellReuseIdentifier: UsersListCell.identifier)
      tableView.keyboardDismissMode = .onDrag
      tableView.tableFooterView = UIView()
    }
  }
  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
    }
  }
  private let viewModel = UsersViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Github User Searcher"
    viewModel.getUsersList { error in
      self.tableView.reloadData()
    }
  }
}

extension GithubUsersList: UITableViewDelegate & UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.rows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UsersListCell.identifier, for: indexPath) as! UsersListCell
    cell.user = viewModel.getUser(by: indexPath.row)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller =  viewModel.toUserDetail(index: indexPath.row)
    self.navigationController?.pushViewController(controller, animated: true)
  }
}

extension GithubUsersList: UISearchBarDelegate {
  private func update() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.evalUserSearch(searchBar.text ?? "") {
      self.update()
    }
    searchBar.searchTextField.resignFirstResponder()
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.evalUserSearch("") {
      self.update()
    }
    searchBar.searchTextField.resignFirstResponder()
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.evalUserSearch(searchBar.text ?? "") {
      self.update()
    }
  }
}

