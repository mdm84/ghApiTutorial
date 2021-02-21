//
//  APIRequestService.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

class APIServiceRequest: APIRequestProtocol {
  private let urlSession: URLSession
  private let preferences: UserDefaults
  private let auth: Authentication

  init(ud: UserDefaults = GHApplication.shared.appUserDefaults, us: URLSession = GHApplication.shared.urlSession, auth: Authentication) {
    self.preferences = ud
    self.urlSession = us
    self.auth = auth
  }
  
  func execute<T: Encodable>(method: APIMethod = .get, cookie: Bool = true ,url: URL, parameter: T?, headers: [String: String] = [:], completion: @escaping(Data?, URLResponse?, Error?)->Void) {
    fetchHeaders { headers in
      let mutableRequest = NSMutableURLRequest(url: url)
      mutableRequest.httpMethod = method.value.uppercased()
      for (key, value) in headers {
        mutableRequest.addValue(value, forHTTPHeaderField: key)
      }
      mutableRequest.httpShouldHandleCookies = cookie
      if let request = self.createURLRequest(mutableRequest, parameter: parameter) {
        self.urlSession.dataTask(with: request) { (data, response, error) in
          completion(data, response, error)
        }.resume()
      }
    }
  }
  private func fetchHeaders(completion: @escaping([String: String]) -> Void) {
    var headers: [String: String] = [:]
    headers[APIHeader.content.value] = APIContentType.json.value
    headers[APIHeader.accept.value] = APIContentType.jsonGH.value
    for (k,v) in auth.headers {
      headers[k] = v
    }
    completion(headers)
  }
  private func createURLRequest<T: Encodable>(_ mutableRequest: NSMutableURLRequest, parameter: T? = nil) -> URLRequest? {
    var urlRequest = mutableRequest as URLRequest
    if let p = parameter {
      do {
        let json = try JSONEncoder().encode(p)
        urlRequest.httpBody = json
      } catch {
        return nil
      }
    }
    return urlRequest
  }
}
