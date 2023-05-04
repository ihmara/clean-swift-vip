//
//  EditBookViewController.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import UIKit

protocol EditBookDisplayLogic: AnyObject {
    func displayFetchedBook(viewModel: EditBook.FetchBook.ViewModel)
    func displayEditedBook(viewModel: EditBook.EditBook.ViewModel)
}

final class EditBookViewController: UIViewController, EditBookDisplayLogic {
    var interactor: EditBookBusinessLogic?
    var router: (EditBookRoutingLogic & EditBookDataPassing)?
    
    // MARK: UI
    
    private var titleLabel = UILabel()
    private var completionSwitch = UISwitch()
    private var contentStackView = UIStackView()
    
    // MARK: Properties
    
    var book: Book?
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchBook()
    }
    
    // MARK: Private methods
    
    private func setupUI() {
        title = NSLocalizedString("Edit Book", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveTapped))
        
        view.backgroundColor = .white
        
        contentStackView.axis = .horizontal
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStackView)
        
        let offset: CGFloat = 16
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(completionSwitch)
        
        completionSwitch.addTarget(self, action: #selector(completionSwitchTapped), for: .valueChanged)
    }
    
    private func fetchBook() {
        let request = EditBook.FetchBook.Request()
        interactor?.fetchBook(request: request)
    }
    
    // MARK: EditBookDisplayLogic
    
    func displayFetchedBook(viewModel: EditBook.FetchBook.ViewModel) {
        let book = viewModel.book
        titleLabel.text = book.title
        completionSwitch.isOn = book.readed
        self.book = book
    }
    
    func displayEditedBook(viewModel: EditBook.EditBook.ViewModel) {
        let book = viewModel.book
        titleLabel.text = book.title
        completionSwitch.isOn = book.readed
        self.book = book
    }
    
    // MARK: Action
    
    @objc
    func cancelTapped() {
        router?.routeToBookList(book: nil)
    }
    
    @objc
    func saveTapped() {
        router?.routeToBookList(book: book)
    }
    
    @objc
    func completionSwitchTapped() {
        guard let book else { return }
        let request = EditBook.EditBook.Request(book: book, readed: !book.readed)
        interactor?.editBook(request: request)
    }

}
