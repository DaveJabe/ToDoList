//
//  APIToDoCell.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import UIKit

class APIToDoCell: UITableViewCell {
    
    static let identifier = "APIToDoCell"
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = Constants.semibold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toDoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.smallFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubviews(toDoLabel, idLabel, completionButton)
        
        NSLayoutConstraint.activate([idLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Constants.padding),
                                     idLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -Constants.padding),
                                     idLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: Constants.smallPadding),
                                     idLabel.layoutMarginsGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.smallWidth),
                                     
                                     toDoLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Constants.padding),
                                     toDoLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -Constants.padding),
                                     toDoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     toDoLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: idLabel.layoutMarginsGuide.trailingAnchor, constant: Constants.padding),
                                     toDoLabel.layoutMarginsGuide.trailingAnchor.constraint(equalTo: completionButton.layoutMarginsGuide.leadingAnchor, constant: -Constants.padding),
                                     
                                     completionButton.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.smallPadding),
                                     completionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     completionButton.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     completionButton.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     completionButton.layoutMarginsGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.smallWidth)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
        toDoLabel.text = nil
        completionButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    
    func configure(title: String, id: Int, isCompleted: Bool) {
        idLabel.text = "\(id)"
        toDoLabel.text = title
        completionButton.tag = isCompleted ? 1 : 0
        setCompletionButtonImage()
    }
    
    private func setCompletionButtonImage() {
        switch completionButton.tag {
        case 0:
            completionButton.setImage(UIImage(systemName: "circle"), for: .normal)
        case 1:
            completionButton.setImage(UIImage(systemName: "circle.circle.fill"), for: .normal)
        default:
            print("error!")
        }
    }
}


