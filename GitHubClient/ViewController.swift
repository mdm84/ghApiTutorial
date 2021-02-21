//
//  ViewController.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import UIKit

class GithubUsersList: UIViewController {
  private let viewModel = UsersViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    viewModel.getUsersList { error in
      print(error)
    }
    
  }


}

