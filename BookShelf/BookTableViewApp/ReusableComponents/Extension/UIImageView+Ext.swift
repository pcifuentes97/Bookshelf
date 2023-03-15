//
//  UIImageView+Ext.swift
//  BookTableViewApp
//
//  Created by Amol Prakash on 27/08/21.
//

import UIKit

extension UIImageView {
    func downloadImage(with urlString: String, placeHolderImage: String? = nil) {
        guard let url = URL(string: urlString) else {
            self.image = UIImage(named: placeHolderImage ?? "")
            return
        }
        DispatchQueue.global().async {
            let completionOnMain: (UIImage?) -> Void = { result in
                DispatchQueue.main.async {
                    self.image = result
                }
            }
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completionOnMain(image)
            } catch {
                completionOnMain(UIImage(named: placeHolderImage ?? ""))
            }
        }
    }
}
