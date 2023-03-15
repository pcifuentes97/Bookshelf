//
//  SearchResultsView.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 8/24/21.
//

import UIKit

protocol SearchResultsViewDelegate: AnyObject {
    var controller: BookListViewController { get }

    func searched(text: String)
    func switchChecker(isOn: Bool)
}

class SearchResultsView: UIView {
    weak var delegate: SearchResultsViewDelegate?
    var timer: Timer?
    var edit = false

    @IBOutlet private weak var isOnlineLabel: UILabel!

    // MARK: Private Methods
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
        }
    }

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = delegate?.controller
            self.tableView.delegate = delegate?.controller
            self.tableView.tableFooterView = UIView()
        }
    }

    @IBOutlet private weak var switcher: UISwitch!

    @IBAction private func editButton() {
        tableView.isEditing = !edit
        edit.toggle()
    }
    
    @IBAction private func isSwitchOn(_ sender: UISwitch) {
        if sender.isOn {
            delegate?.switchChecker(isOn: switcher.isOn)
            isOnlineLabel.text = "Online"
//            print(switcher.isOn)
        } else {
            delegate?.switchChecker(isOn: switcher.isOn)
            isOnlineLabel.text = "Offline"
        }
    }

    // MARK: Public Methods
    func reloadData() {
        self.tableView.reloadData()
    }
    
    @objc
    func doSearch() {
        guard let searchText = searchBar.text else { return }
        delegate?.searched(text: searchText)
    }
}

extension SearchResultsView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = nil
        let textString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !textString.isEmpty else { return }
        if switcher.isOn {
            timer = Timer.scheduledTimer(timeInterval: 3,
                                         target: self,
                                         selector: #selector(self.doSearch),
                                         userInfo: nil,
                                         repeats: false)
        } else {
            delegate?.searched(text: searchText)
        }
    }
}
