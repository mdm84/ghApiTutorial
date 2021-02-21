//
//  User.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

struct User: Codable {
  let login: String
  let id: Int
  let nodeId: String
  
  enum CodingKeys: String, CodingKey {
    case login
    case id
    case nodeId = "node_id"
  }
}
