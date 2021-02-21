//
//  GH+String.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation
extension String {
  var fromBase64: String? {
    guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
      return nil
    }
    return String(data: data as Data, encoding: String.Encoding.utf8)
  }
  
  var toBase64: String? {
    guard let data = self.data(using: String.Encoding.utf8) else {
      return nil
    }
    return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
  }
  var localDateFormat: String {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    guard let timeZoneDate = formatter.date(from: self) else { return "-" }
    let current = TimeZone.current
    formatter.timeZone = current
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter.string(from: timeZoneDate)
  }
}
