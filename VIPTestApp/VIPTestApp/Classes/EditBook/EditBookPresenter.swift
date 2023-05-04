//
//  EditBookPresenter.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import Foundation

protocol EditBookPresentationLogic {
    func presentFetchedBook(response: EditBook.FetchBook.Response)
    func presentEditedBook(response: EditBook.EditBook.Response)
}

final class EditBookPresenter: EditBookPresentationLogic {
    weak var viewController: EditBookDisplayLogic?
    
    //MARK: EditBookPresentationLogic
    
    func presentFetchedBook(response: EditBook.FetchBook.Response) {
        let book = response.book
        let viewModel = EditBook.FetchBook.ViewModel(book: book)
        viewController?.displayFetchedBook(viewModel: viewModel)
    }
    
    func presentEditedBook(response: EditBook.EditBook.Response) {
        let book = response.book
        let viewModel = EditBook.EditBook.ViewModel(book: book)
        viewController?.displayEditedBook(viewModel: viewModel)
    }
}
