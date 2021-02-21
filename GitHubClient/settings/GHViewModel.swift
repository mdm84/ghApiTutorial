//
//  GHViewModel.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

class GHViewModel {
  let apiManager: APIManager
  let preferences: UserDefaults
  
  init(apiManager: APIManager = GHApplication.shared.apiManagerV3, preferences: UserDefaults = GHApplication.shared.appUserDefaults) {
    self.apiManager = apiManager
    self.preferences = preferences
  }
}
