//
//  Helper.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation

class Helper {
  private static var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    return decoder
  }()
  
  class func decode<T>(_ type: T.Type, from data: Data) -> Result<T, Error> where T: Decodable {
    let j = Result { try self.decoder.decode(type, from: data)}
    return j
  }
}
