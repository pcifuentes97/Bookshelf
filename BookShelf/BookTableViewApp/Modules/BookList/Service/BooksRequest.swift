//
//  BooksRequest.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 9/10/21.
//

import Foundation

enum BooksRequest {
    case volume(query: String, maxResult: String, startIndex: String)
}

extension BooksRequest: RequestProtocol {
    var path: String {
        "books/v1/volumes"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: RequestHeaders? {
        nil
    }

    var bodyParameters: RequestParameters? {
        nil
    }

    var queryParameters: RequestParameters? {
        switch self {
        case let .volume(query: query, maxResult: maxResult, startIndex: startIndex):
            return ["q": "\(query)", "maxResults": "\(maxResult)", "startIndex": "\(startIndex)"]
        }
    }
}
