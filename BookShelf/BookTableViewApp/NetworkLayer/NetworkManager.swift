//
//  NetworkManager.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 8/25/21.
//

import Foundation

protocol NetworkProvider {
    func fetch<T: Codable>(endPoint: RequestProtocol, completion: @escaping (Result<T, AppError>) -> Void)
}

enum AppError: Error {
    case badUrl
    case serverError
    case badResponse
    case noData
    case parsingFailed
}

class NetworkManager {
    static let manager = NetworkManager()

    private init() {}

    func fetch<T: Codable>(endPoint: RequestProtocol, completion: @escaping (Result<T, AppError>) -> Void) {
        guard let url = endPoint.asUrlRequest() else {
            completion(.failure(.badUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let completionOnMain: (Result) -> Void = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard error == nil else {
                completionOnMain(.failure(.serverError))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionOnMain(.failure(.badResponse))
                return
            }

            switch response.statusCode {
            case 200...299:
                guard let unwrappedData = data else {
                    completionOnMain(.failure(.noData))
                    return
                }
                do {
                    let object = try JSONDecoder().decode(T.self, from: unwrappedData)
                    completionOnMain(.success(object))
                } catch {
                    print(error)
                    completionOnMain(.failure(.parsingFailed))
                    return
                }

            default:
                completionOnMain(.failure(.serverError))
            }
        }
        .resume()
    }
}
