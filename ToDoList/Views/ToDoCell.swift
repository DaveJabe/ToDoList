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
        return label
    }()
    
    private let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.setOn(false, animated: false)
        return toggle
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        contentView.addSubviews(toggle, toDoLabel)
        toggle.addTarget(self, action: #selector(toggled), for: .valueChanged)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateToggleOrigin(_:)),
                                               name: Notification.Name ("updateToggleOrigin"),
                                               object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        toDoLabel.frame = CGRect(x: Constants.smallPadding,
                                 y: 0,
                                 width: Constants.width,
                                 height: contentView.height)
        
        let toggleX = contentView.width-toggle.width-5
        
        toggle.frame = CGRect(x: toggleX,
                              y: 0,
                              width: Constants.smallWidth,
                              height: contentView.height)
        toggle.center.y = contentView.center.y
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        toDoLabel.text = ""
        toggle.setOn(false, animated: false)
        tag = 0
    }
    
    // MARK: - Methods
    
    @objc private func toggled() {
        delegate?.toDoItemWasToggled(on: toggle.isOn, index: tag)
    }
    
    @objc private func updateToggleOrigin(_ sender: Notification) {
        guard let info = sender.userInfo as? [String:CGFloat] else { return }
        toggle.frame.origin.x += info["pointsMoved"] ?? 0
    }
    
    func configure(title: String, completed: Bool, tag: Int, delegate: ToDoCellDelegate) {
        toDoLabel.text = title
        toggle.setOn(completed, animated: false)
        self.tag = tag
        self.delegate = delegate
    }
    
    func hideToggle(_ hide: Bool) {
        toggle.isHidden = hide
    }
}
