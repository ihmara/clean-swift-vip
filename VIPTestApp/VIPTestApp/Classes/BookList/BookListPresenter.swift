//
//  BookListPresenter.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import Foundation

protocol BookListPresentationLogic {
    func presentFetchedBooks(response: BookList.FetchBooks.Response)
    func presentAddedBook(response: BookList.AddBook.Response)
    func presentEditedBook(response: BookList.EditBook.Response)
    func presentDeletedBook(response: BookList.DeleteBook.Response)
}

final class BookListPresenter: BookListPresentationLogic {
    weak var viewController: BookListDisplayLogic?
    
    // MARK: BookListPresentationLogic
    
    func presentFetchedBooks(response: BookList.FetchBooks.Response) {
        let books = response.books
        let viewModel = BookList.FetchBooks.ViewModel(books: books)
        viewController?.displayFetchedBooks(viewModel: viewModel)
    }
    
    func presentAddedBook(response: BookList.AddBook.Response) {
        let book = response.book
        let viewModel = BookList.AddBook.ViewModel(book: book)
        viewController?.displayAddedBook(viewModel: viewModel)
    }
    
    func presentEditedBook(response: BookList.EditBook.Response) {
        let book = response.book
        let viewModel = BookList.EditBook.ViewModel(book: book)
        viewController?.displayEditedBook(viewModel: viewModel)
    }
    
    func presentDeletedBook(response: BookList.DeleteBook.Response) {
        let book = response.book
        let viewModel = BookList.DeleteBook.ViewModel(book: book)
        viewController?.displayDeletedBook(viewModel: viewModel)
    }
}
