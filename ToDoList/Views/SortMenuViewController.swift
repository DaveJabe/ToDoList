//
//  SortMenuViewController.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

class SortMenuViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SortMenuCell.self, forCellReuseIdentifier: SortMenuCell.identifier)
        return tableView
    }()
    
    private weak var delegate: SortMenuDelegate?
    
    private lazy var viewModel = SortMenuViewModel()
    
    // MARK: - Lifecycle
    
    init(delegate: SortMenuDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

    // MARK: - TableView

extension SortMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortOptionsCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sort"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortMenuCell.identifier, for: indexPath) as? SortMenuCell else {
            return UITableViewCell()
        }
        
        cell.configure(iconName: viewModel.sortOptionIcon(at: indexPath.row),
                       paramName: viewModel.sortOptionName(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.sortOptionWasSelected(sortOption: viewModel.sortOptionName(at: indexPath.row))
    }
}
