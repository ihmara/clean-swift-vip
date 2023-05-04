//
//  BookListWorker.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import Foundation

protocol BookListWorkerProtocol {
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void)
}

final class BookListWorker: BookListWorkerProtocol {
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let books = [
                Book(id: 1, title: "Book 1", readed: false),
                Book(id: 2, title: "Book 2", readed: false),
                Book(id: 3, title: "Book 3", readed: true),
                Book(id: 4, title: "Book 4", readed: false),
                Book(id: 5, title: "Book 5", readed: true)]
            completion(.success(books))
        }
    }
}
