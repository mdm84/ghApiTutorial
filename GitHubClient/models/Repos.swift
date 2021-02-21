//
//  Repos.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

struct Repo: Codable{
  let id: Int
  let nodeId: String
  let name: String
  let fullname: String
  let forkCount: Int
  let starGazersCount: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case nodeId = "node_id"
    case name
    case fullname = "full_name"
    case forkCount = "forks_count"
    case starGazersCount = "stargazers_count"
  }
}
