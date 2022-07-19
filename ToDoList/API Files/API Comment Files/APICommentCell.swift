//
//  APICommentCell.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import UIKit

class APICommentCell: UITableViewCell {

    static let identifier = "APICommentCell"
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.smallFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(bodyLabel)
        NSLayoutConstraint.activate([bodyLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Constants.smallPadding),
                                     bodyLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -Constants.smallPadding),
                                     bodyLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: Constants.smallPadding),
                                     bodyLabel.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -Constants.smallPadding)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bodyLabel.text = nil
    }
    
    func configure(text: String) {
        bodyLabel.text = text
    }
}
