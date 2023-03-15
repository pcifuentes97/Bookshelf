//
//  RequestProtocol.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 9/10/21.
//

import Foundation

typealias RequestHeaders = [String: String]
typealias RequestParameters = [String: Any?]

protocol RequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: RequestHeaders? { get }
    var bodyParameters: RequestParameters? { get }
    var queryParameters: RequestParameters? { get }
}

extension RequestProtocol {
    var baseUrl: String {
        "https://www.googleapis.com/"
    }

    func asUrlRequest() -> URLRequest? {
        guard let url = url(with: baseUrl) else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = jsonBody

        return urlRequest
    }

    private func url(with baseUrl: String) -> URL? {
        guard var components = URLComponents(string: baseUrl) else {
            return nil
        }
        components.path = "\(components.path)\(path)"
        components.queryItems = queryItems

        return components.url
    }

    private var queryItems: [URLQueryItem]? {
        guard method == .get, let params = queryParameters else {
            return nil
        }

        return params.compactMap { (key: String, value: Any?) -> URLQueryItem in
            let valueString = "\(value ?? "")"
            return URLQueryItem(name: key, value: valueString)
        }
    }

    private var jsonBody: Data? {
        guard [.post, .put, .patch].contains(method), let params = bodyParameters else {
            return nil
        }
        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            print(error)
        }

        return jsonData
    }
}
