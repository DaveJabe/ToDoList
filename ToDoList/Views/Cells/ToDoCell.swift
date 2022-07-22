//
//  ToDoCell.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit
import CoreData

class ToDoCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ToDoCell"
    
    private weak var delegate: ToDoCellDelegate?
    
    private let toDoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Constants.semibold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: SFSymbol.incomplete), for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        contentView.addSubviews(completionButton, toDoLabel)
        
        completionButton.addTarget(self,
                                   action: #selector(toggled),
                                   for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateButtonOrigin(_:)),
                                               name: Notification.Name ("updateButtonOrigin"),
                                               object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([toDoLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
                                     toDoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     toDoLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     toDoLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     
                                     completionButton.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
                                     completionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     completionButton.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     completionButton.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        toDoLabel.text = ""
        completionButton.setImage(nil, for: .normal)
        tag = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    private func setCompletionButtonImage() {
        switch completionButton.tag {
        case 0:
            completionButton.setImage(UIImage(systemName: SFSymbol.incomplete), for: .normal)
        case 1:
            completionButton.setImage(UIImage(systemName: SFSymbol.complete), for: .normal)
        default:
            print("error!")
        }
    }
    
    @objc private func toggled() {
        let isCompleted = completionButton.tag == 1
        completionButton.tag = isCompleted ? 0 : 1
        setCompletionButtonImage()
        delegate?.toDoItemWasToggled(on: completionButton.tag == 1, index: tag)
    }
    
    @objc private func updateButtonOrigin(_ sender: Notification) {
        guard let info = sender.userInfo as? [String:CGFloat] else { return }
        completionButton.frame.origin.x += info["pointsMoved"] ?? 0
    }
    
    func configure(title: String, isCompleted: Bool, tag: Int, delegate: ToDoCellDelegate) {
        toDoLabel.text = title
        completionButton.tag = isCompleted ? 1 : 0
        setCompletionButtonImage()
        self.tag = tag
        self.delegate = delegate
    }
    
    func hideToggle(_ hide: Bool) {
        completionButton.isHidden = hide
    }
}
