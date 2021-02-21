//
//  Endpoints.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

enum Endpoints {
  case user
  case users
  case userDetail(String)
  case repos(String)

  var prodString: String {
    return "https://api.github.com"
  }
  var baseURL: URL {
    let urlString: String = prodString
    return URL(string: urlString)!
  }
  var path: String {
    switch self {
    case .user: return "/user"
    case .users: return "/users"
    case .userDetail(let username): return "/users/\(username)"
    case .repos(let username): return "/users/" + username + "/repos"
    }
  }
  var apiV3: URL {
    let path = self.path
    let baseURL = self.baseURL
    let url = URL(string: path, relativeTo: baseURL)
    return url!
  }
}
