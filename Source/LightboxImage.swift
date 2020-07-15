import UIKit
import Imaginary

public enum LightboxImageType {
    case normal
    case gif
}

open class LightboxImage {

  open fileprivate(set) var image: UIImage?
  open fileprivate(set) var imageURL: URL?
  open fileprivate(set) var videoURL: URL?
  open fileprivate(set) var imageType: LightboxImageType?
  open fileprivate(set) var imageClosure: (() -> UIImage)?
  open var text: String

  // MARK: - Initialization

  internal init(text: String = "") {
    self.text = text
  }

  public init(image: UIImage, text: String = "", videoURL: URL? = nil, imageType: LightboxImageType? = nil) {
    self.image = image
    self.text = text
    self.videoURL = videoURL
    self.imageType = imageType
  }

  public init(imageURL: URL, text: String = "", videoURL: URL? = nil, imageType: LightboxImageType? = nil) {
    self.imageURL = imageURL
    self.text = text
    self.videoURL = videoURL
    self.imageType = imageType
  }

  public init(imageClosure: @escaping () -> UIImage, text: String = "", videoURL: URL? = nil, imageType: LightboxImageType? = nil) {
    self.imageClosure = imageClosure
    self.text = text
    self.videoURL = videoURL
    self.imageType = imageType
  }

  open func addImageTo(_ imageView: UIImageView, completion: ((UIImage?) -> Void)? = nil) {
    if let image = image {
      imageView.image = image
      completion?(image)
    } else if let imageURL = imageURL {
      LightboxConfig.loadImage(imageView, imageURL, completion)
    } else if let imageClosure = imageClosure {
      let img = imageClosure()
      imageView.image = img
      completion?(img)
    } else {
      imageView.image = nil
      completion?(nil)
    }
  }
    
    public func imageSrcUrl() -> String {
        return imageURL?.absoluteString ?? ""
    }
    
    public func isVideo() -> Bool {
        return videoURL != nil
    }
}
