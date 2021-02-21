//
//  APIRequestProtocol.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

protocol APIRequestProtocol {
//  var baseUrlCurrent: String { get }
  func execute<T: Encodable>(method: APIMethod, cookie: Bool, url: URL, parameter: T?, headers: [String: String], completion: @escaping(Data?, URLResponse?, Error?)->Void)
}
