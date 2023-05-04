//
//  EditBookModels.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import Foundation

enum EditBook {
    
    // MARK: Use cases
    
    enum FetchBook {
        struct Request {}
        struct Response {
            var book: Book
        }
        struct ViewModel {
            var book: Book
        }
    }
    
    enum EditBook {
        struct Request {
            var book: Book
            var readed: Bool
        }
        struct Response {
            var book: Book
        }
        struct ViewModel {
            var book: Book
        }
    }
}
