//
//  ReusableView.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 8/24/21.
//

import Foundation

protocol ReusableView {
    static var identifier: String { get }
}

extension ReusableView {
    static var identifier: String {
        String(describing: self)
    }
}

extension Bundle {
     func getJsonObject(from fileName: String, type: String) -> [String: Any] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: type) else { return [:] }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    as? [String: Any] else { return [ : ] }
            return jsonData
        } catch let error {
            print(error)
            return [:]
        }
    }
}

extension String {
    func cleanUpURL() -> String {
        return self.replacingOccurrences(of: "amp;", with: "")
    }
}
