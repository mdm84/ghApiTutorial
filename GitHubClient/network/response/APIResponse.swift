//
//  APIResponse.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

struct GenericResponse<T:Codable>: Codable {
  let message: String?
  let errors: [GHErrors]?
}

struct GHErrors: Codable {
  let resources: String
  let field: String
  let code: String
}
