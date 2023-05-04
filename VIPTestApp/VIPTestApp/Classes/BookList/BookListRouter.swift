//
//  BookListRouter.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import UIKit

protocol BookListRoutingLogic {
    func routeToEditBook(book: Book)
}

protocol BookListDataPassing: AnyObject {
    var dataStore: BookListDataStore? { get }
    func edit(book oldbook: Book, with newBook: Book)
}

final class BookListRouter: BookListRoutingLogic, BookListDataPassing {
    weak var viewController: BookListViewController?
    
    // MARK: BookListDataPassing

    var dataStore: BookListDataStore?
    
    func edit(book oldbook: Book, with newBook: Book) {
        dataStore?.edit(book: oldbook, with: newBook)
    }
    
    // MARK: BookListRoutingLogic
    
    func routeToEditBook(book: Book) {
        guard let viewController = viewController else { return }
        let destinationVC = createEditBookListViewController()
        var destinationDS = destinationVC.router?.dataStore
        passDataToEditBook(book: book, destination: &destinationDS)
        viewController.show(UINavigationController(rootViewController: destinationVC), sender: nil)
    }
    
    func passDataToEditBook(book: Book, destination: inout EditBookDataStore?) {
        destination?.book = book
    }
    
    // MARK: Private methods
    
    private func createEditBookListViewController() -> EditBookViewController {
        let viewController = EditBookViewController()
        let interactor = EditBookInteractor()
        let presenter = EditBookPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        let router = EditBookRouter()
        router.viewController = viewController
        router.dataStore = interactor
        router.bookListRouter = self
        viewController.router = router
        return viewController
    }
    
    
}
