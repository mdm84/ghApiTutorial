//
//  APIManager.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

class APIManager: APIServiceRequest {
  func users(completion: @escaping(Result<[UserOverview],NetworkError>)->Void) {
    let apiURL = Endpoints.users.apiV3
    let body: [String: String]? = nil
    let responseBuilder: ResponseBuilder<[UserOverview]> = ResponseBuilder(url: apiURL.absoluteString)
    execute(url: apiURL, parameter: body, headers: [:]) { (d, r, e) in
      responseBuilder.processRequestResponse(data: d, response: r, error: e) { response in
        completion(response)
      }
    }
  }
  func userDetail(by username: String, completion: @escaping(Result<User,NetworkError>)->Void) {
    let apiURL = Endpoints.userDetail(username).apiV3
    let body: [String: String]? = nil
    let responseBuilder: ResponseBuilder<User> = ResponseBuilder(url: apiURL.absoluteString)
    execute(url: apiURL, parameter: body, headers: [:]) { (d, r, e) in
      responseBuilder.processRequestResponse(data: d, response: r, error: e) { response in
        completion(response)
      }
    }
  }
  func repos(by username: String, completion: @escaping(Result<[Repo], NetworkError>)->Void) {
    let apiURL = Endpoints.repos(username).apiV3
    let body: [String: String]? = nil
    let responseBuilder: ResponseBuilder<[Repo]> = ResponseBuilder(url: apiURL.absoluteString)
    execute(url: apiURL, parameter: body, headers: [:]) { (d, r, e) in
      responseBuilder.processRequestResponse(data: d, response: r, error: e) { response in
        completion(response)
      }
    }
  }
}
