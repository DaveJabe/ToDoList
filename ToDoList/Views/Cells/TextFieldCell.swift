//
//  TextFieldCell.swift
//  ToDoList
//
//  Created by David Jabech on 7/16/22.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    static let identifier = "TextFieldCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.semibold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private weak var delegate: UpdateItemCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(titleLabel, textField)
        selectionStyle = .none
        
        textField.addTarget(self, action: #selector(textFieldTextDidChange), for: .allEditingEvents)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([titleLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
                                     titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     titleLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     titleLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     
                                     textField.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
                                     textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
    }
    
    func configure(title: String, textFieldText: String, delegate: UpdateItemCellDelegate) {
        titleLabel.text = title
        textField.text = textFieldText
        self.delegate = delegate
    }
    
    @objc private func textFieldTextDidChange() {
        delegate?.newTitle = textField.text ?? ""
    }
}
