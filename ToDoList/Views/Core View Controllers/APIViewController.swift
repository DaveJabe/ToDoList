//
//  APIViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/16/22.
//

import UIKit

class APIViewController: UIViewController {
    
    
    private var viewModel = APIViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension APIViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: viewModel.titleForItem(at: indexPath.row),
                       isCompleted: viewModel.isCompletedForItem(at: indexPath.row),
                       tag: indexPath.row,
                       delegate: self)
        
        return cell
    }
}

extension APIViewController: ToDoCellDelegate {

    func toDoItemWasToggled(on: Bool, index: Int) {
        
    }
}
