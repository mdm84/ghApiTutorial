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
    }
  }
  var apiV3: URL {
    let path = self.path
    let baseURL = self.baseURL
    let url = URL(string: path, relativeTo: baseURL)
    return url!
  }
}
