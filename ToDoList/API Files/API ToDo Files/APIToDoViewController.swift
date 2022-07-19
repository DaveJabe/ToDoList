//
//  APIToDoViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/16/22.
//

import UIKit

class APIToDoViewController: UIViewController {
    
    
    private var viewModel: APIToDoViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(APIToDoCell.self, forCellReuseIdentifier: APIToDoCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setTitle("SEE COMMENTS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        viewModel = APIToDoViewModel(delegate: self)
        viewModel?.getDataFromAPIHandler(completion: {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        })
        
        view.addSubviews(tableView, commentButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        commentButton.addTarget(self,
                                action: #selector(didTapComments),
                                for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: view.width,
                                 height: view.height-Constants.width)
        
        commentButton.frame = CGRect(x: 0,
                                     y: tableView.bottom+Constants.padding,
                                     width: Constants.width,
                                     height: Constants.height)
        commentButton.centerX(in: view)
    }
    
    @objc private func didTapComments() {
        let vc = APICommentViewController()
        present(vc, animated: true)
    }
}

extension APIToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "API ToDo Items"
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: APIToDoCell.identifier, for: indexPath) as? APIToDoCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: viewModel.getTitle(forItemAt: indexPath.row),
                       id: viewModel.getID(forItemAt: indexPath.row),
                       isCompleted: viewModel.getIsCompleted(forItemAt: indexPath.row))
        
        return cell
    }
}

extension APIToDoViewController: APIToDoDelegate {
    func didGetData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
