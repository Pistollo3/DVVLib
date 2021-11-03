//
//  VFGImageView.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 2/24/21.
//

import UIKit

@IBDesignable
public class VFGImageView: UIImageView {
    @IBInspectable var imageName: String = "" {
        didSet {
            image = VFGImage(named: imageName)
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        if UIView.appearance().semanticContentAttribute == .forceRightToLeft {
            transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    @available(*, deprecated,
    message: "please use `VFGImage(named:)` instead of VFGImageView.image(name:)")
    public static func image(name: String) -> UIImage? {
        VFGImage(named: name)
    }

	/// Set image from a URL.
	///
	/// - Parameters:
	///   - url: URL of image.
	///   - placeHolder: optional placeholder image
	///   - completionHandler: optional completion handler to run when download finishes (default is nil).
	public func download(
		from url: URL,
		placeholder: UIImage? = nil,
		completionHandler: ((UIImage?) -> Void)? = nil
	) {
		URLSession.shared.dataTask(with: url) { data, response, _ in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data,
				let image = UIImage(data: data)
			else {
				DispatchQueue.main.async { [weak self] in
					self?.image = placeholder
					completionHandler?(nil)
				}
				return
			}
			DispatchQueue.main.async { [weak self] in
				self?.image = image
				completionHandler?(image)
			}
		}
		.resume()
	}
}
