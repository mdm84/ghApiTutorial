//
//  ImageLoader.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation
import UIKit

class ImageLoader {
  static let shared = ImageLoader()
  
  let placeholder = UIImage(systemName: "circle.fill")!
  private var loadedImages = [URL: UIImage]()
  private var runningRequests = [UUID: URLSessionDataTask]()
  
  func loadImage(_ url: URL, completion: @escaping(Result<UIImage, Error>)->Void) -> UUID? {
    //vedo se gia lo ho scaricato
    if let image = loadedImages[url] {
      completion(.success(image))
      return nil
    }
    let uuid = UUID()
  //  let currentRequest = makeRequest(from: url)
    let currentRequest = URLRequest(url: url)
    let task = Foundation.URLSession.shared.dataTask(with: currentRequest) { data, response, error in
      defer {self.runningRequests.removeValue(forKey: uuid) }
      if let data = data, let image = UIImage(data: data) {
        self.loadedImages[url] = image
        completion(.success(image))
        return
      }
      guard let error = error else {
        completion(.success(self.placeholder))
        return
      }
      guard (error as NSError).code == NSURLErrorCancelled else {
        completion(.failure(error))
        return
      }
    }
    task.resume()
    runningRequests[uuid] = task
    return uuid
  }
  
  func cancelLoad(_ uuid: UUID) {
    runningRequests[uuid]?.cancel()
    runningRequests.removeValue(forKey: uuid)
  }
  
  private func makeRequest(from url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    headers["Accept"] = "application/json"
    request.httpShouldHandleCookies = true
    request.allHTTPHeaderFields = headers
    return request
  }
}

