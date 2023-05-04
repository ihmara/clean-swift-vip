//
//  BookListViewController.swift
//  VIPTestApp
//
//  Created by Igor Hmara on 4.05.23.
//

import UIKit

protocol BookListDisplayLogic: AnyObject {
    func displayFetchedBooks(viewModel: BookList.FetchBooks.ViewModel)
    func displayAddedBook(viewModel: BookList.AddBook.ViewModel)
    func displayEditedBook(viewModel: BookList.EditBook.ViewModel)
    func displayDeletedBook(viewModel: BookList.DeleteBook.ViewModel)
}

final class BookListViewController: UIViewController, BookListDisplayLogic {
    var interactor: BookListBusinessLogic?
    var router: BookListRoutingLogic?
    
    // MARK: UI
    
    private var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: Properties
    
    var books: [Book] = []
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("My Library", comment: "")
        setupTableView()
        fetchBooks()
    }
    
    // MARK: Private methods
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
    }
    
    private func fetchBooks() {
        let request = BookList.FetchBooks.Request()
        interactor?.fetchBooks(request: request)
    }
    
    private func createBookStatusLabel(book: Book) -> UILabel {
        let label = UILabel(frame: .init(origin: .zero, size: .init(width: 100, height: 30)))
        label.text = book.readed ? NSLocalizedString("Readed", comment: "") : NSLocalizedString("Unreaded", comment: "")
        label.backgroundColor =  book.readed ? .green : .clear
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }
    
    // MARK: BookListDisplayLogic
    
    func displayFetchedBooks(viewModel: BookList.FetchBooks.ViewModel) {
        books = viewModel.books
        tableView.reloadData()
    }
    
    func displayAddedBook(viewModel: BookList.AddBook.ViewModel) {
        books.append(viewModel.book)
        tableView.reloadData()
    }
    
    func displayEditedBook(viewModel: BookList.EditBook.ViewModel) {
        if let index = books.firstIndex(where: { $0.id == viewModel.book.id }) {
            books[index] = viewModel.book
            tableView.reloadData()
        }
    }
    
    func displayDeletedBook(viewModel: BookList.DeleteBook.ViewModel) {
        if let index = books.firstIndex(where: { $0.id == viewModel.book.id }) {
            books.remove(at: index)
            tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.accessoryView = createBookStatusLabel(book: book)
        return cell
    }
}

// MARK: UITableViewDelegate

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        router?.routeToEditBook(book: book)
    }
}
