//
//  BookListViewController+TableView.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 8/24/21.
//

import UIKit

extension BookListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookListTableViewCell.identifier,
                                                       for: indexPath) as? BookListTableViewCell else {
            fatalError("Identifier Error")
        }
        let bookInfo = self.bookDataSource[indexPath.row]

        cell.configure(title:
                        bookInfo.volumeInfo?.title ?? "",
                       authors: bookInfo.volumeInfo?.authors?.joined(separator: ", ") ?? "",
                       imageUrl: bookInfo.volumeInfo?.imageLinks?.thumbnail,
                       date: bookInfo.volumeInfo?.publishedDate ?? "")
        return cell
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let bookDetailsViewController = storyBoard.instantiateViewController(
                identifier: "BookDetailsViewController") as? BookDetailsViewController else { return }

        let bookDetails = BookInfo(image: bookDataSource[indexPath.row].volumeInfo?.imageLinks?.thumbnail ?? "",
                                   title: bookDataSource[indexPath.row].volumeInfo?.title ?? "",
                                   authors: bookDataSource[indexPath.row].volumeInfo?.authors ?? [],
                                   publisher: bookDataSource[indexPath.row].volumeInfo?.publisher ?? "",
                                   publishedDate: bookDataSource[indexPath.row].volumeInfo?.publishedDate ?? "",
                                   description: bookDataSource[indexPath.row].volumeInfo?.description ?? "")

        bookDetailsViewController.bookDetails = bookDetails
        self.navigationController?.pushViewController(bookDetailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.bookDataSource.remove(at: indexPath.row)
            self.allBooks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        case .insert:
            break

        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.bookDataSource[sourceIndexPath.row]
            bookDataSource.remove(at: sourceIndexPath.row)
        bookDataSource.insert(movedObject, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == self.bookDataSource.count - 1 {
            pageIndex += 40
            getMoreBooks(with: queryString, pageIndex: pageIndex)
        }
    }
}
