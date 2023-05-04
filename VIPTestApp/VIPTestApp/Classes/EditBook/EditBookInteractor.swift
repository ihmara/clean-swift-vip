//
//  EditBookInteractor.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import Foundation

protocol EditBookBusinessLogic {
    func fetchBook(request: EditBook.FetchBook.Request)
    func editBook(request: EditBook.EditBook.Request)
}

protocol EditBookDataStore {
    var book: Book? { get set }
}

final class EditBookInteractor: EditBookBusinessLogic, EditBookDataStore {
    var presenter: EditBookPresentationLogic?
    
    // MARK: EditBookDataStore
    
    var book: Book?
    
    // MARK: EditBookBusinessLogic
    
    func fetchBook(request: EditBook.FetchBook.Request) {
        guard let book else { return }
        let response = EditBook.FetchBook.Response(book: book)
        presenter?.presentFetchedBook(response: response)
    }
    
    func editBook(request: EditBook.EditBook.Request) {
        var book = request.book
        book.readed = request.readed
        let response = EditBook.EditBook.Response(book: book)
        presenter?.presentEditedBook(response: response)
    }
}
