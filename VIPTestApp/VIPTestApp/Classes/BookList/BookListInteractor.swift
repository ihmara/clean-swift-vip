//
//  BookListInteractor.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import Foundation

protocol BookListBusinessLogic {
    func fetchBooks(request: BookList.FetchBooks.Request)
    func addBook(request: BookList.AddBook.Request)
    func editBook(request: BookList.EditBook.Request)
    func deleteBook(request: BookList.DeleteBook.Request)
}

protocol BookListDataStore {
    var books: [Book] { get set }
    func edit(book oldbook: Book, with newBook: Book)
}

final class BookListInteractor: BookListBusinessLogic, BookListDataStore {
    var presenter: BookListPresentationLogic?
    private let worker: BookListWorkerProtocol = BookListWorker()
    
    // MARK: BookListDataStore
    
    var books: [Book] = []
    
    func edit(book oldbook: Book, with newBook: Book) {
        let request = BookList.EditBook.Request.init(title: newBook.title, book: newBook)
        editBook(request: request)
    }
    
    // MARK: BookListBusinessLogic
    
    func fetchBooks(request: BookList.FetchBooks.Request) {
        worker.fetchBooks { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books
                let response = BookList.FetchBooks.Response(books: books)
                self?.presenter?.presentFetchedBooks(response: response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addBook(request: BookList.AddBook.Request) {
        let book = Book(id: books.count + 1, title: request.title, readed: false)
        books.append(book)
        let response = BookList.AddBook.Response(book: book)
        presenter?.presentAddedBook(response: response)
    }
    
    func editBook(request: BookList.EditBook.Request) {
        let book = Book(id: request.book.id, title: request.title, readed: request.book.readed)
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index] = book
            let response = BookList.EditBook.Response(book: book)
            presenter?.presentEditedBook(response: response)
        }
    }
    
    func deleteBook(request: BookList.DeleteBook.Request) {
        if let index = books.firstIndex(where: { $0.id == request.book.id }) {
            let book = books[index]
            books.remove(at: index)
            let response = BookList.DeleteBook.Response(book: book)
            presenter?.presentDeletedBook(response: response)
        }
    }
}
