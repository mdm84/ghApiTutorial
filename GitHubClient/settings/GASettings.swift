//
//  GASettings.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

//MARK: Networking
enum APIMethod: String {
  case post
  case get
  
  var value: String {
    return self.rawValue.uppercased()
  }
}
enum APIContentType: String {
  case json = "application/json"
  case jsonGH = "application/vnd.github.v3+json"
  case text = "text/html"
  
  var value: String { rawValue }
}
enum APIHeader: String {
  case content = "Content-Type"
  case accept = "Accept"
  case xapikey = "X-Api-Key"
  
  var value: String { rawValue }
}
enum Parameters: String {
  case clientID = "client_id"
  case clientSecret = "client_secret"
  case code
  case redirectURL = "redirect_uri"
}
