//
//  APICommentViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import UIKit

class APICommentViewController: UIViewController {
    
    private var viewModel: APICommentViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(APICommentCell.self, forCellReuseIdentifier: APICommentCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = APICommentViewModel(delegate: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension APICommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "API Comments"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: APICommentCell.identifier, for: indexPath) as? APICommentCell else {
            return UITableViewCell()
        }
        
        cell.configure(text: viewModel.getBody(forItemAt: indexPath.row))
        return cell
    }
}

extension APICommentViewController: APICommentDelegate {
    func didGetData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
}
