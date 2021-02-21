//
//  Response.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

class Response<T> {
  let statusCode: Int
  let header: [String: String]
  let body: T
  init(statusCode: Int, header: [String: String], body: T) {
    self.statusCode = statusCode
    self.header = header
    self.body = body
  }
  convenience init(response: HTTPURLResponse, body: T) {
    let raw = response.allHeaderFields
    var header = [String: String]()
    for case let (key, value) as (String, String) in raw {
      header[key] = value
    }
    self.init(statusCode: response.statusCode, header: header, body: body)
  }
  
}

class ResponseBuilder<J: Decodable> {
  let urlString: String
  
  init(url: String) {
    urlString = url
  }
  func processRequestResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping(_ result: Result<J, NetworkError>) -> Void) {
    DispatchQueue.main.async {
      if error != nil {
        completion(.failure(.connection))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(.connection))
        return
      }
      guard Array(200..<300).contains(httpResponse.statusCode) else {
        completion(.failure(.statusCode(httpResponse.statusCode)))
        return
      }
      guard data != nil else {
        completion(.failure(.dataEmpty))
        return
      }
      switch J.self {
      case is String.Type:
        let body = data.flatMap{ String(data: $0, encoding: .utf8) } ?? ""
        let resp = Response(response: httpResponse, body: body as! J)
        completion(.success(resp.body))
      case is Data.Type:
        let resp = Response(response: httpResponse, body: data as! J)
        completion(.success(resp.body))
      default:
        guard let data = data, !data.isEmpty else{
          completion(.failure(.dataEmpty))
          return
        }
        
        let decodableResult = Helper.decode(J.self, from: data)
        switch decodableResult {
        case .success(let object):
          let resp = Response(response: httpResponse, body: object)
          completion(.success(resp.body))
        case .failure:
          completion(.failure(.decoding))
        }
      }
    }
  }
}
