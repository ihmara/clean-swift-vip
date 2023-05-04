//
//  BookListModels.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import Foundation

enum BookList {
    
    // MARK: Use cases
    
    enum FetchBooks {
        struct Request {}
        struct Response {
            var books: [Book]
        }
        struct ViewModel {
            var books: [Book]
        }
    }
    
    enum AddBook {
        struct Request {
            var title: String
        }
        struct Response {
            var book: Book
        }
        struct ViewModel {
            var book: Book
        }
    }
    
    enum EditBook {
        struct Request {
            var title: String
            var book: Book
        }
        struct Response {
            var book: Book
        }
        struct ViewModel {
            var book: Book
        }
    }
    
    enum DeleteBook {
        struct Request {
            var book: Book
        }
        struct Response {
            var book: Book
        }
        struct ViewModel {
            var book: Book
        }
    }
}
