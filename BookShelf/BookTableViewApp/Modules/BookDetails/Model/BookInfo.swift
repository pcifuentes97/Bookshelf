//
//  BookInfo.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 9/5/21.
//

import Foundation

struct BookInfo {
    var image: String?
    var title: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
    
    init(image: String, title: String, authors: [String], publisher: String, publishedDate: String, description: String) {
        self.image = image
        self.title = title
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.description = description
    }
}
