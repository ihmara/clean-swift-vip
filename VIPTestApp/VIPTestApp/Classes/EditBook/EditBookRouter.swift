//
//  EditBookRouter.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import UIKit

protocol EditBookRoutingLogic {
    func routeToBookList(book: Book?)
}

protocol EditBookDataPassing {
    var dataStore: EditBookDataStore? { get }
}

final class EditBookRouter: EditBookRoutingLogic, EditBookDataPassing {
    weak var viewController: EditBookViewController?
    weak var bookListRouter: BookListDataPassing?
    
    var dataStore: EditBookDataStore?
    
    // MARK: EditBookRoutingLogic
    
    func routeToBookList(book: Book?) {
        if let oldBook = dataStore?.book, let newBook = book {
            bookListRouter?.edit(book: oldBook, with: newBook)
        }
        viewController?.dismiss(animated: true)
    }
}
