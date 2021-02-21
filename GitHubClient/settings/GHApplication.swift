//
//  GHApplication.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

final class GHApplication {
  static let shared = GHApplication()
  private let auth = Authentication(username: "maxInterview2021", password: "githubInterview2021")
  private let githubToken = "4a2ba39158173896f4b271bf2e2a1cee29d5cb60"
  lazy var appUserDefaults = UserDefaults.standard
  private var _urlSession: URLSession?
  var urlSession: URLSession {
    if _urlSession == nil {
      let config = URLSessionConfiguration.default
      _urlSession = URLSession(configuration: config)
    }
    return _urlSession!
  }
  private var _apiManagerV3: APIManager?
  var apiManagerV3: APIManager {
    if _apiManagerV3 == nil {
      _apiManagerV3 = APIManager(ud: appUserDefaults, us: urlSession, auth: auth)
    }
    return _apiManagerV3!
  }
}
