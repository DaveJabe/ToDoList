//
//  UpdateItemViewController.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

class UpdateItemViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.identifier)
        tableView.register(ToggleCell.self, forCellReuseIdentifier: ToggleCell.identifier)
        return tableView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private weak var viewModel: ToDoItemViewModel?
    
    private var cellViewModel: UpdateItemCellViewModel
    
    private weak var delegate: UpdateItemViewControllerDelegate?
    
    private var index: Int
    
    // MARK: - Lifecycle
    
    init(viewModel: ToDoItemViewModel, delegate: UpdateItemViewControllerDelegate, itemTitle: String, isCompleted: Bool, index: Int) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.index = index
        cellViewModel = UpdateItemCellViewModel(itemTitle: itemTitle, isCompleted: isCompleted)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update Item"
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubviews(tableView, saveButton)
        
        tableView.delegate = self
        tableView.dataSource = self
                
        saveButton.addTarget(self,
                             action: #selector(saveData),
                             for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        
        saveButton.frame = CGRect(x: 0,
                                  y: tableView.height/2,
                                  width: Constants.width,
                                  height: Constants.height)
        saveButton.centerX(in: view)
    }
    
    // MARK: - Methods
    
    @objc private func saveData() {
        viewModel?.updateItem(title: cellViewModel.newTitle,
                              completed: cellViewModel.newCompletion,
                              at: index) { success in
            if success {
                delegate?.itemWasUpdated()
                navigationController?.popViewController(animated: true)
            }
            else {
                presentAlert(alert: Alert.emptyTextAlert, actions: [AlertAction.ok])
            }
        }
    }
}

    // MARK: - TableView

extension UpdateItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Update Fields Below"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModel.cellCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellViewModel.cellType(at: indexPath.row) {
            
        case .textFieldCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as? TextFieldCell else {
                return UITableViewCell()
            }
            cell.configure(title: model.title, textFieldText: model.textFieldText, delegate: cellViewModel)
            return cell
            
        case .toggleCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ToggleCell.identifier, for: indexPath) as? ToggleCell else {
                return UITableViewCell()
            }
            cell.configure(title: model.title, isCompleted: model.isOn, delegate: cellViewModel)
            return cell
        }
    }
}
