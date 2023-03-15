//
//  BookListViewController.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 8/24/21.
//

import UIKit

class BookListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var searchResultView: SearchResultsView! {
        didSet {
            searchResultView.delegate = self
        }
    }
    @IBOutlet private weak var errorView: UIView!
    
    var allBooks: [Books] = []
    var bookDataSource: [Books] = []
    var switchChecker = true
    var pageIndex = 1
    var queryString = ""
//    var bookListViewModel: BookListViewModel?

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books List"
        self.getBooks(with: "iOS")
    }

    // MARK: Private Functions
    private func getBooks(with key: String) {
        showErrorMessage(isError: true)
        let request = BooksRequest.volume(query: key, maxResult: "40", startIndex: "0")

        NetworkManager.manager.fetch(endPoint: request) { [weak self] (result: Result<BookDetails, AppError>) in
            switch result {
            case .success(let bookInfo):
                self?.allBooks = bookInfo.items ?? []
                self?.bookDataSource = self?.allBooks ?? []
                self?.searchResultView.reloadData()
                self?.showErrorMessage(isError: true)
                // let obj = try? JSONEncoder().encode(bookInfo)
            case .failure(_):
                self?.showErrorMessage(isError: false)
            }
        }
    }
    
    func getMoreBooks(with key: String, pageIndex: Int) {
        showErrorMessage(isError: true)
        let request = BooksRequest.volume(query: key, maxResult: "40", startIndex: String(pageIndex))
        
        NetworkManager.manager.fetch(endPoint: request) { [weak self] (result: Result<BookDetails, AppError>) in
            switch result {
            case .success(let bookInfo):
//                self?.allBooks = bookInfo.items ?? []
//                self?.bookDataSource = self?.allBooks ?? []
                
                guard let books = self?.allBooks, let newBooks = bookInfo.items else { return }
                let combinedBooks = books + newBooks
                self?.allBooks = combinedBooks
                self?.bookDataSource = self?.allBooks ?? []
                self? .searchResultView.reloadData()
                self?.showErrorMessage(isError: true)
                // let obj = try? JSONEncoder().encode(bookInfo)
            case .failure(_):
//                self?.showErrorMessage(isError: false)
                break
            }
        }
    }

    private func searchLocal(text: String) {
        self.bookDataSource = self.allBooks
        guard !text.isEmpty else {
            self.bookDataSource = self.allBooks
            self.searchResultView.reloadData()
            return
        }
        self.bookDataSource = self.bookDataSource.filter { book in
            return (book.volumeInfo?.title?.contains(text) ?? false) ||
                (book.volumeInfo?.authors?.contains(text) ?? false)
        }
        self.showErrorMessage(isError: bookDataSource.isEmpty)
        self.searchResultView.reloadData()
    }
    
    func showErrorMessage(isError: Bool) {
        errorView.isHidden = isError
    }
}

extension BookListViewController: SearchResultsViewDelegate {
    var controller: BookListViewController {
        self
    }

    func searched(text: String) {
        queryString = text
        guard !queryString.isEmpty else {
            self.bookDataSource = self.allBooks
            return
        }
        if switchChecker {
            getBooks(with: queryString)
        } else {
            guard !queryString.isEmpty else {
                searchLocal(text: "")
                return
            }
            searchLocal(text: queryString)
        }
    }
    func switchChecker(isOn: Bool) {
        switchChecker = isOn
    }
}
