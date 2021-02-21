//
//  Authentication.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

class Authentication {
  var username: String
  var password: String
  var headers: [String: String] {
    let auth = self.username + ":" + self.password
    return ["Authorization": "Basic \(auth.toBase64 ?? "")"]
  }
  
  init(username: String, password: String) {
    self.username = username
    self.password = password
  }
}
