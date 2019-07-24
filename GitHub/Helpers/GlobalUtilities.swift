//
//  GlobalUtilities.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

public class GlobalUtilities {

    public static func downloadImage(path: String?, placeholder: UIImage?, into imageView: UIImageView, indicator: UIActivityIndicatorView?) -> Void {

        indicator?.isHidden = false
        indicator?.startAnimating()
        let url: URL!
        if let path = path {
            url = URL(string: path)
        } else {
            url = URL(string: "")
        }
        imageView.sd_setImage(with: url, placeholderImage: placeholder, options: [.progressiveDownload, .continueInBackground]) { (newImage, err, type, newUrl) in
            if err != nil {
                DispatchQueue.main.async {
                    imageView.image = placeholder
                    indicator?.stopAnimating()
                    indicator?.isHidden = true
                }
            }
            else {
                DispatchQueue.main.async {
                    imageView.image = newImage
                    indicator?.stopAnimating()
                    indicator?.isHidden = true
                }
            }
        }
    }
}
