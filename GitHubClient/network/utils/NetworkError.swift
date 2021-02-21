//
//  NetworkError.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

enum NetworkError: Error, Equatable {
  case domain
  case decoding
  case connection
  case url
  case dataEmpty
  case statusCode (Int)
  
  var description: String {
    return String(describing: self)
  }
}
