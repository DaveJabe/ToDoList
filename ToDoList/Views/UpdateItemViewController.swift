//
//  UpdateItemViewController.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

class UpdateItemViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.semibold
        label.text = "Title:"
        label.numberOfLines = 1
        return label
    }()
    
    private let toggleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.semibold
        label.text = "Completed:"
        label.numberOfLines = 1
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "No Title"
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private var toggleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private var saveButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    private weak var viewModel: ToDoItemViewModel?
    
    private weak var delegate: UpdateItemViewControllerDelegate?
    
    private var itemTitle: String
    
    private var completed: Bool
    
    private var index: Int
    
    // MARK: - Lifecycle
    
    init(viewModel: ToDoItemViewModel, delegate: UpdateItemViewControllerDelegate, itemTitle: String, completed: Bool, index: Int) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.itemTitle = itemTitle
        self.completed = completed
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update Item"
        view.backgroundColor = .secondarySystemBackground
        
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(titleTextField)
        
        toggleStack.addArrangedSubview(toggleLabel)
        toggleStack.addArrangedSubview(toggle)
        
        view.addSubviews(titleStack, toggleStack, saveButton)
        
        titleTextField.text = itemTitle
        titleTextField.delegate = self
        
        toggle.setOn(completed, animated: false)
        
        saveButton.addTarget(self,
                             action: #selector(saveData),
                             for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleStack.frame = CGRect(x: 0,
                                  y: Constants.padding*8,
                                  width: Constants.width,
                                  height: Constants.height)
        titleStack.centerX(in: view)
        
        toggleStack.frame = CGRect(x: titleStack.leading,
                                   y: titleStack.bottom+Constants.smallPadding,
                                   width: Constants.width,
                                   height: Constants.height)
        
        saveButton.frame = CGRect(x: 0,
                                  y: view.bottom-Constants.padding*6,
                                  width: Constants.width,
                                  height: Constants.height)
        saveButton.centerX(in: view)
    }
    
    // MARK: - Methods
    
    @objc private func saveData() {
        guard let text = titleTextField.text else { return }
        viewModel?.updateItem(title: text, completed: toggle.isOn, at: index) { success in
            if !success {
                presentAlert(alert: Alert.emptyTextAlert, actions: [AlertAction.ok])
            }
            else {
                delegate?.itemWasUpdated()
                navigationController?.popViewController(animated: true)
            }
        }
    }
}

    // MARK: - Textfield

extension UpdateItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
