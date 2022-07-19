//
//  ToDoViewController.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

class ToDoViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var viewModel = ToDoItemViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.identifier)
        return tableView
    }()
    
    private let noItemsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.semibold
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.text = "No To Do Items"
        return label
    }()
    
    private let editButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "tablecells.badge.ellipsis")
        button.style = .plain
        return button
    }()
    
    private let addButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.style = .plain
        return button
    }()
    
    private let sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "arrow.up.arrow.down")
        button.style = .plain
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var containerIsHidden: Bool {
        return !(containerView.frame.origin.x == 0)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(tableView, containerView)
        tableView.addSubview(noItemsLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshData()
        configureNavigationItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let navigationBarHeight = navigationController?.navigationBar.bottom ?? 0
        let tabBarHeight = tabBarController?.tabBar.height ?? 0
        
        tableView.frame = CGRect(x: 0,
                                 y: navigationBarHeight,
                                 width: view.width,
                                 height: view.height)
        
        containerView.frame = CGRect(x: -view.width/3,
                                     y: navigationController?.navigationBar.bottom ?? 0,
                                     width: view.width/3,
                                     height: view.height-navigationBarHeight-tabBarHeight)
        
        noItemsLabel.frame = tableView.bounds
        noItemsLabel.center.y = tableView.top + Constants.height
    }
    
    // MARK: - Methods
    
    private func refreshData() {
        tableView.reloadData()
        noItemsLabel.isHidden = !viewModel.isEmpty()
    }
    
    private func configureNavigationItems() {
        navigationItem.rightBarButtonItem = editButton
        navigationItem.leftBarButtonItem = sortButton
        
        editButton.action = #selector(didTapEdit)
        editButton.target = self
        
        addButton.action = #selector(didTapAddItem)
        addButton.target = self
        
        sortButton.action = #selector(didTapSort)
        sortButton.target = self
    }
    
    private func toggleSort(toggle: Bool) {
        var info = [String:CGFloat]()
        sortButton.isEnabled = false
        
        UIView.animate(withDuration: 0.3,
                       
                       animations: { [self] in
            
            if toggle {
                tableView.allowsSelection = false
                let vc = SortMenuViewController(delegate: self)
                add(vc, for: containerView)
                containerView.frame.origin.x = 0
                tableView.frame.origin.x = containerView.trailing
                info = ["pointsMoved":-containerView.width]
            }
            else {
                tableView.allowsSelection = true
                containerView.frame.origin.x = -containerView.width
                tableView.frame.origin.x = containerView.trailing
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                    self?.removeChildren()
                }
                info = ["pointsMoved":containerView.width]
            }
            NotificationCenter.default.post(name: Notification.Name ("updateButtonOrigin"), object: nil, userInfo: info)
        },
                       completion:
                        
                        { [weak self] _ in
            self?.sortButton.isEnabled = true
        })
    }
    
    private func toggleTableViewEditing(toggle: Bool) {
        if toggle {
            tableView.isEditing = true
            editButton.image = nil
            editButton.title = "Done"
            navigationItem.setRightBarButtonItems([editButton, addButton], animated: true)
            navigationItem.leftBarButtonItem = nil
        }
        else {
            tableView.isEditing = false
            editButton.image = UIImage(systemName: "tablecells.badge.ellipsis")
            editButton.title = nil
            navigationItem.setRightBarButtonItems([editButton], animated: false)
            navigationItem.leftBarButtonItem = sortButton
        }
    }
    
    // MARK: - @objc Methods
    
    @objc private func didTapAddItem() {
        let alert = UIAlertController(title: "Add New Item",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = "Enter new item here"
        }
        
        let save = UIAlertAction(title: "Save",
                                 style: .default) { [weak self] _ in
            
            guard let text = alert.textFields?.first?.text else {
                return
            }
            
            self?.viewModel.addItem(text) { success in
                if success {
                    self?.refreshData()
                }
                else {
                    self?.presentAlert(alert: Alert.emptyTextAlert, actions: [AlertAction.ok])
                }
            }
        }
        
        alert.addAction(save)
        alert.addAction(AlertAction.cancel)
        present(alert, animated: true)
    }
    
    @objc private func didTapEdit() {
        toggleTableViewEditing(toggle: !tableView.isEditing)
        if !containerIsHidden {
            toggleSort(toggle: false)
        }
    }
    
    @objc private func didTapSort() {
        toggleSort(toggle: containerIsHidden)
    }
}

// MARK: - TableView

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: viewModel.title(forItemAt: indexPath.row),
                       isCompleted: viewModel.isCompleted(itemAt: indexPath.row),
                       tag: indexPath.row,
                       delegate: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeItem(at: indexPath.row) { [weak self] in
                self?.refreshData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UpdateItemViewController(viewModel: viewModel,
                                          delegate: self,
                                          itemTitle:  viewModel.title(forItemAt: indexPath.row),
                                          isCompleted: viewModel.isCompleted(itemAt: indexPath.row),
                                          index: indexPath.row)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Delegates

extension ToDoViewController: UpdateItemViewControllerDelegate {
    func itemWasUpdated() {
        tableView.reloadData()
    }
}

extension ToDoViewController: SortMenuDelegate {
    func sortOptionWasSelected(sortOption: String) {
        viewModel.sortItems(by: sortOption)
        toggleSort(toggle: containerIsHidden)
        tableView.reloadData()
    }
}
