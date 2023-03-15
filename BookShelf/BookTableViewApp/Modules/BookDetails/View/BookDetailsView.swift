//
//  BookDetailsView.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 9/5/21.
//

import UIKit

protocol BookDetailsViewDelegate: AnyObject {
    var controller: BookDetailsViewController { get }
}

class BookDetailsView: UIView {
    
    weak var delegate: BookDetailsViewDelegate?
    
    @IBOutlet private weak var bookImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorsLabel: UILabel!
    @IBOutlet private weak var publiserLabel: UILabel!
    @IBOutlet private weak var publishedDatelabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var innerView: UIView!
    
    func configure(title: String, authors: [String], publisher: String, publishedDate: String, description: String) {
            titleLabel.text = title
            authorsLabel.text = authors.joined(separator: ", ")
            publiserLabel.text = publisher
            publishedDatelabel.text = publishedDate
            descriptionLabel.text = description
    }
    
    func getImage(from imageUrl: String) {
        bookImage.downloadImage(with: imageUrl.cleanUpURL())
    }
}
