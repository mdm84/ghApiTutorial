//
//  ViewController.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    GHApplication.shared.apiManagerV3.users { (response) in
      print(response)
    }
  }


}

