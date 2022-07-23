//
//  ToggleCell.swift
//  ToDoList
//
//  Created by David Jabech on 7/17/22.
//

import UIKit

class ToggleCell: UITableViewCell {
    
    static let identifier = "ToggleCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.semibold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    private weak var delegate: UpdateItemCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(titleLabel, toggle)
        selectionStyle = .none
        
        toggle.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
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
                                     
                                     toggle.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
                                     toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
    }

    func configure(title: String, isCompleted: Bool, delegate: UpdateItemCellDelegate) {
        titleLabel.text = title
        toggle.isOn = isCompleted
        self.delegate = delegate
    }
    
    @objc private func toggleChanged(_ sender: UISwitch) {
        delegate?.newCompletion = sender.isOn
    }
}
