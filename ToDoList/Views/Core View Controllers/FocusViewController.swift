//
//  FocusViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/22/22.
//

import UIKit

class FocusViewController: UIViewController {
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "--:--"
        label.textAlignment = .center
        label.font = Constants.largeFont
        return label
    }()
    
    private let pomodoroButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.semibold
        button.backgroundColor = .systemGreen
        button.layer.masksToBounds = true
        return button
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "1"
        label.textAlignment = .center
        label.font = Constants.semibold
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "2"
        label.textAlignment = .center
        label.font = Constants.semibold
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "3"
        label.textAlignment = .center
        label.font = Constants.semibold
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "4"
        label.textAlignment = .center
        label.font = Constants.semibold
        return label
    }()
    
    private let vStack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private let vStack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private let vStack3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private let vStack4: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment  = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var endTimer: UIBarButtonItem = {
        let button = UIBarButtonItem()
        return button
    }()
    
    private lazy var info: UIBarButtonItem = {
        let button = UIBarButtonItem()
        return button
    }()
    
    private lazy var viewModel = FocusViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureNavButtons()
        updateUI()
    }
    
    private func configureSubviews() {
        vStack1.addArrangedSubviews(label1,UIImageView())
        vStack2.addArrangedSubviews(label2,UIImageView())
        vStack3.addArrangedSubviews(label3,UIImageView())
        vStack4.addArrangedSubviews(label4,UIImageView())
        
        hStack.addArrangedSubviews(vStack1, vStack2, vStack3, vStack4)
        
        view.addSubviews(timerLabel, pomodoroButton, hStack)
        
        pomodoroButton.frame = CGRect(x: 0,
                                      y: 0,
                                      width: Constants.width,
                                      height: Constants.width)
        pomodoroButton.center(in: view)
        pomodoroButton.layer.cornerRadius = pomodoroButton.width/2
        
        pomodoroButton.addTarget(self,
                                 action: #selector(buttonWasTapped), for: .touchUpInside)
        
        hStack.frame = CGRect(x: 0,
                              y: pomodoroButton.bottom+Constants.padding,
                              width: view.width,
                              height: Constants.height)
        
        timerLabel.frame = CGRect(x: 0,
                                  y: pomodoroButton.top-(Constants.padding*4),
                                  width: view.width,
                                  height: Constants.height)
    }
    
    private func configureNavButtons() {
        
        let config = UIImage.SymbolConfiguration(weight: .heavy)
        
        endTimer = UIBarButtonItem(image: UIImage(systemName: "xmark.circle")?.withConfiguration(config),
                                   style: .plain,
                                   target: self,
                                   action: #selector(didTapEndTimer))
        endTimer.tintColor = .systemRed
        
        info = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                               style: .plain,
                               target: self,
                               action: #selector(didTapInfo))
    }
    
    private func toggleWorkTime() {
        UIView.animate(withDuration: 0.5) { [self] in
            pomodoroButton.backgroundColor = .systemGray6
            pomodoroButton.setTitleColor(.systemGreen, for: .normal)
            pomodoroButton.setTitle("Work Time", for: .normal)
            view.backgroundColor = .systemGreen
        }
    }
    
    private func toggleBreakTime() {
        UIView.animate(withDuration: 0.5) { [self] in
            pomodoroButton.backgroundColor = .systemGray6
            pomodoroButton.setTitleColor(.systemBlue, for: .normal)
            pomodoroButton.setTitle("Break Time", for: .normal)
            view.backgroundColor = .systemBlue
        }
    }
    
    private func reset() {
        UIView.animate(withDuration: 0.5) { [self] in
            pomodoroButton.backgroundColor = .systemGreen
            pomodoroButton.setTitleColor(.white, for: .normal)
            pomodoroButton.setTitle("START", for: .normal)
            view.backgroundColor = .systemBackground
        }
    }
    
    private func updateUI() {
        viewModel.currentTime.bindAndFire { [unowned self] in
            timerLabel.text = $0
        }
        
        viewModel.isPaused.bindAndFire { [unowned self] in
            if let paused = $0 {
                if paused {
                    pomodoroButton.setTitle("PAUSED", for: .normal)
                }
                else if let onBreak = viewModel.onBreak.value {
                    if !onBreak {
                        toggleWorkTime()
                    }
                    else {
                        toggleBreakTime()
                    }
                }
            }
        }
        
        viewModel.onBreak.bindAndFire { [unowned self] in
            if let onBreak = $0 {
                if !onBreak {
                    toggleWorkTime()
                }
                else {
                    toggleBreakTime()
                }
            }
        }
    }
    
    @objc private func buttonWasTapped() {
        if viewModel.isPaused.value == nil {
            navigationItem.setRightBarButton(endTimer, animated: true)
        }
        viewModel.toggleTimer()
    }
    
    @objc private func didTapEndTimer() {
        
        let endAction = AlertActionModel(title: "End Timer", style: .destructive) { [weak self] _ in
            self?.viewModel.endTimer()
            self?.navigationItem.setRightBarButton(nil, animated: true)
            self?.reset()
        }
        
        presentAlert(alert: Alert.areYouSure, actions: [AlertAction.cancel, endAction])
    }
    
    @objc private func didTapInfo() {
         
    }
}
