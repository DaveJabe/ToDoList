//
//  FocusViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/22/22.
//

import UIKit

class FocusViewController: UIViewController {
    
    private let workLengthAndBreakLength: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = Constants.semibold
        label.addShadow(radius: 0.1, opacity: 0.3)
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "--:--"
        label.textAlignment = .center
        label.font = Constants.largeFont
        label.addShadow(radius: 1)
        return label
    }()
    
    private let pomodoroButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Constants.semibold
        button.backgroundColor = .systemGreen
        button.addShadow(offset: CGSize(width: 0.5, height: 0.5))
        return button
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "1"
        label.textAlignment = .center
        label.font = Constants.semibold
        label.addShadow(radius: 1, opacity: 0.3)
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "2"
        label.textAlignment = .center
        label.font = Constants.semibold
        label.addShadow(radius: 1, opacity: 0.3)
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "3"
        label.textAlignment = .center
        label.font = Constants.semibold
        label.addShadow(radius: 1, opacity: 0.3)
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "4"
        label.textAlignment = .center
        label.font = Constants.semibold
        label.addShadow(radius: 1, opacity: 0.3)
        return label
    }()
    
    private let imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.tag = 1
        return imageView
    }()
    
    private let imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.tag = 2
        return imageView
    }()
    
    private let imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.tag = 3
        return imageView
    }()
    
    private let imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.tag = 4
        return imageView
    }()
    
    
    private let vStack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = Constants.padding
        return stack
    }()
    
    private let vStack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = Constants.padding
        return stack
    }()
    
    private let vStack3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = Constants.padding
        return stack
    }()
    
    private let vStack4: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = Constants.padding
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
        vStack1.addArrangedSubviews(imageView1,label1)
        vStack2.addArrangedSubviews(imageView2,label2)
        vStack3.addArrangedSubviews(imageView3,label3)
        vStack4.addArrangedSubviews(imageView4,label4)
        
        hStack.addArrangedSubviews(vStack1,vStack2,vStack3,vStack4)
        
        view.addSubviews(workLengthAndBreakLength,timerLabel,pomodoroButton,hStack)
        
        pomodoroButton.frame = CGRect(x: 0,
                                      y: 0,
                                      width: Constants.width,
                                      height: Constants.width)
        pomodoroButton.center(in: view)
        pomodoroButton.layer.cornerRadius = pomodoroButton.width/2
        
        pomodoroButton.addTarget(self,
                                 action: #selector(buttonWasTapped),
                                 for: .touchUpInside)
        
        hStack.frame = CGRect(x: 0,
                              y: pomodoroButton.bottom+Constants.padding,
                              width: view.width,
                              height: Constants.height)
        
        timerLabel.frame = CGRect(x: 0,
                                  y: pomodoroButton.top-(Constants.padding*4),
                                  width: view.width,
                                  height: Constants.height)
        
        workLengthAndBreakLength.frame = CGRect(x: 0,
                                                y: timerLabel.top+workLengthAndBreakLength.height-(Constants.padding*4),
                                                width: view.width,
                                                height: Constants.height)
    }
    
    private func configureNavButtons() {
        
        endTimer = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(didTapEndTimer))
        endTimer.tintColor = .systemRed
        
        info = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                               style: .plain,
                               target: self,
                               action: #selector(didTapInfo))
        navigationItem.setLeftBarButton(info, animated: true)
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
        navigationItem.setRightBarButton(nil, animated: true)
        
        UIView.animate(withDuration: 0.5) { [self] in
            pomodoroButton.backgroundColor = .systemGreen
            pomodoroButton.setTitleColor(.white, for: .normal)
            pomodoroButton.setTitle("START", for: .normal)
            view.backgroundColor = .systemBackground
        }
    }
    
    private func updateUI() {
        
        viewModel.labelString.bindAndFire { [unowned self] in
            workLengthAndBreakLength.text = $0
        }
        
        viewModel.currentTime.bindAndFire { [unowned self] in
            timerLabel.text = $0
        }
        
        viewModel.isPaused.bindAndFire { [unowned self] in
            if $0 {
                pomodoroButton.setTitle("PAUSED", for: .normal)
            }
            else {
                let title = viewModel.currentState.value == .onWork ? "Work Time" : "Break Time"
                pomodoroButton.setTitle(title, for: .normal)
            }
        }
        
        viewModel.currentState.bindAndFire { [unowned self] state  in
            switch state {
            case .off:
                reset()
            case .onWork:
                toggleWorkTime()
            case .onBreak:
                toggleBreakTime()
            }
        }
        
        viewModel.pomodoroCount.bindAndFire { [unowned self] count in
            switch count {
            case 1:
                imageView1.image = UIImage(systemName: SFSymbol.pomodoroComplete)
            case 2:
                imageView2.image = UIImage(systemName: SFSymbol.pomodoroComplete)
            case 3:
                imageView3.image = UIImage(systemName: SFSymbol.pomodoroComplete)
            case 4:
                imageView4.image = UIImage(systemName: SFSymbol.pomodoroComplete)
            default:
                print("error")
            }
        }
        
        viewModel.sessionComplete.bindAndFire { [unowned self] complete in
            if complete {
                let restart = AlertActionModel(title: "Restart Timer",
                                               style: .default) { _ in viewModel.startTimer() }
                
                let soundsGood = AlertActionModel(title: "Sounds good",
                                                  style: .default) { _ in reset()  }
                
                presentAlert(alert: Alert.greatWork, actions: soundsGood, restart)
            }
        }
    }
    
    @objc private func buttonWasTapped() {
        if viewModel.currentState.value == .off {
            navigationItem.setRightBarButton(endTimer, animated: true)
        }
        viewModel.toggleTimer()
    }
    
    @objc private func didTapEndTimer(_ sender: UIBarButtonItem) {
        
        let endAction = AlertActionModel(title: "End Timer", style: .destructive) { [weak self] _ in
            self?.viewModel.endTimer()
            self?.reset()
        }
        
        presentAlert(alert: Alert.areYouSure, actions: AlertAction.cancel, endAction)
    }
    
    @objc private func didTapInfo() {
        let alert = UIAlertController(title: "Customize Pomodoro Time",
                                      message: nil,
                                      preferredStyle: .alert)
        
        let save = AlertActionModel(title: "Save",
                                    style: .default,
                                    handler: { [weak self] _ in self?.viewModel.saveWorkAndBreakLengths() })
        
        
        let saveAsDefault = AlertActionModel(title: "Save As Default",
                                             style: .default,
                                             handler: { [weak self] _ in self?.viewModel.saveWorkAndBreakLengthsAsDefault() })
        
        let cancel = AlertActionModel(title: "Cancel",
                                      style: .cancel,
                                      handler: { [weak self] _ in self?.viewModel.resetTempLengths() })
        
        
        alert.addActions(save, saveAsDefault, cancel)
        alert.addPickerView(delegateAndDataSource: viewModel)
        present(alert, animated: true)
    }
    
    @objc private func didTapCustomize() {
        
    }
}
