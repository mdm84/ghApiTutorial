//
//  GH+ImageView.swift
//  GitHubClient
//
//  Created by Massimiliano on 21/02/2021.
//

import Foundation
import UIKit

class UIImageLoader {
  static let loader = UIImageLoader()
  
  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()
  
  private init() {}
  
  func load(_ url: URL, for imageView: UIImageView, animation: Bool = false) {
    let token = imageLoader.loadImage(url) { result in
      defer { self.uuidMap.removeValue(forKey: imageView) }
      do {
        let image = try result.get()
        DispatchQueue.main.async {
          if animation {
            UIView.transition(with: imageView, duration: 0.2, options: .transitionCrossDissolve, animations: {
              imageView.image = image
              imageView.contentMode = .scaleAspectFill
            }, completion: nil)
          } else {
            imageView.image = image
          }
          
        }
      } catch {
        imageView.image = self.imageLoader.placeholder
      }
    }
    if let token = token {
      uuidMap[imageView] = token
    }
  }
  
  func cancel(for imageView: UIImageView) {
    if let uuid = uuidMap[imageView] {
      imageLoader.cancelLoad(uuid)
      uuidMap.removeValue(forKey: imageView)
    }
  }
}

extension UIImageView {
  func loadImage(at url: URL, with animation: Bool = false) {
    UIImageLoader.loader.load(url, for: self, animation: animation)
  }
  
  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
