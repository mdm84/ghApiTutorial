//
//  AccessTokenResponse.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

struct AccessTokenResponse: Codable {
  let accessToken: String
  let tokenType: String
  let scope: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case scope
  }
}
