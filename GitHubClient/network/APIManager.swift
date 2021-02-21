//
//  APIManager.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

class APIManager: APIServiceRequest {
  func getAccessToken(clientID: String, clientSecret: String, code: String, redirectURL: String, completion: @escaping(AccessTokenResponse?, Error?) -> Void) {
    let url = "https://github.com/login/oauth/access_token"
    
    var parameters = [String : String]()
    parameters[Parameters.clientID.rawValue] = clientID
    parameters[Parameters.clientSecret.rawValue] = clientSecret
    parameters[Parameters.code.rawValue] = code
    parameters[Parameters.redirectURL.rawValue] = redirectURL
    
    var headers = [String : String]()
    headers["Accept"] = "application/json"
    
    self.get(url: url, parameters: parameters, headers: headers) { (data, _, error) in
      if let data = data {
        do {
          let model = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
          completion(model, error)
        } catch {
          completion(nil, error)
        }
      } else {
        completion(nil, error)
      }
    }
  }
  func users(completion: @escaping(Result<GenericResponse<[User]>,NetworkError>)->Void) {
    let apiURL = Endpoints.user.apiV3
    let body: [String: String]? = nil
    let responseBuilder: ResponseBuilder<GenericResponse<[User]>> = ResponseBuilder(url: apiURL.absoluteString)
    execute(method: .post, cookie: true, url: apiURL, parameter: body, headers: [:]) { (d, r, e) in
      responseBuilder.processRequestResponse(data: d, response: r, error: e) { response in
        completion(response)
      }
    }
  }
}
