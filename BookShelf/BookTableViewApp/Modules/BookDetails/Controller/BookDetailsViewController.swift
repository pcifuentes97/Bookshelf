//
//  BookDetailsViewController.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 9/5/21.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet private weak var bookDetailsView: BookDetailsView!
    
    @IBAction private func shareButton(_ sender: Any) {
        guard let photo = bookDetails?.image else { return }
        let item = [photo]
        let activityController = UIActivityViewController(activityItems: item, applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    var bookDetails: BookInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book Details"

        if let imageUrl = bookDetails?.image {
            bookDetailsView.getImage(from: imageUrl)
        }
        bookDetailsView.configure(title: bookDetails?.title ?? "",
                                  authors: bookDetails?.authors ?? [],
                                  publisher: bookDetails?.publisher ?? "",
                                  publishedDate: bookDetails?.publishedDate ?? "",
                                  description: bookDetails?.description ?? "")
    }
}

extension BookDetailsViewController: BookDetailsViewDelegate {
    var controller: BookDetailsViewController {
        self
    }
}
