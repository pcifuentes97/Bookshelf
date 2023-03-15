//
//  BookListTableViewCell.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 8/24/21.
//

import UIKit

class BookListTableViewCell: UITableViewCell {

    @IBOutlet private weak var bookImageView: UIImageView! {
        didSet {
            bookImageView.layer.cornerRadius = bookImageView.frame.height / 2
            bookImageView.layer.borderWidth = 1
            bookImageView.layer.borderColor = UIColor.black.cgColor
        }
    }

    @IBOutlet private weak var bookTitle: UILabel!
    @IBOutlet private weak var bookAuthor: UILabel!
    @IBOutlet private weak var publishedDate: UILabel!

    // MARK: Public Methods
    func configure(title: String, authors: String, imageUrl: String?, date: String) {
        bookTitle.text = title
        bookAuthor.text = authors
        publishedDate.text = date
        if let imageUrl = imageUrl {
            bookImageView.downloadImage(with: imageUrl.cleanUpURL())
        }
    }
}

extension BookListTableViewCell: ReusableView {}
