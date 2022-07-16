//
//  SortMenuCell.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

class SortMenuCell: UITableViewCell {
    
    // MARK: - Properties

    static let identifier = "SortMenuCell"
    
    private let sortIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let sortParamLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.smallFont
        label.textColor = .secondaryLabel
        return label
    }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .blue
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(sortIcon, sortParamLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sortIcon.frame = CGRect(x: Constants.smallPadding,
                                y: 0,
                                width: Constants.smallPadding,
                                height: Constants.smallPadding)
        sortIcon.centerY(in: contentView)
        
        sortParamLabel.sizeToFit()
        sortParamLabel.frame.origin.x = contentView.trailing-sortParamLabel.width-Constants.smallPadding
        sortParamLabel.centerY(in: contentView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sortIcon.image = nil
        sortParamLabel.text = nil
    }
    
    // MARK: - Methods
    
    func configure(iconName: String, paramName: String) {
        sortIcon.image = UIImage(systemName: iconName)
        sortParamLabel.text = paramName
    }
}
