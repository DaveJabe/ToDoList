//
//  FocusViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/22/22.
//

import UIKit

class FocusViewModel: NSObject {
    
    enum FocusState: Equatable {
        case off
        case onWork
        case onBreak
    }
        
    private var timer: Timer?
    private var count = 0
    
    var workLength: Int = UserDefaults.workLength
    var breakLength: Int = UserDefaults.breakLength
    
    var tempWorkLength: Int = 300
    var tempBreakLength: Int = 300
    
    var workLengthRange = Array(300.inMinutes()...3600.inMinutes())
    
    var breakLengthRange: Array<Int> {
        if tempWorkLength < 660 {
            return Array(60.inMinutes()...300.inMinutes())
        }
        return Array(60.inMinutes()...(tempWorkLength-300).inMinutes())
    }
    
    var currentTime: Dynamic<String>
    var currentState: Dynamic<FocusState>
    var isPaused: Dynamic<Bool>
    var pomodoroCount: Dynamic<Int>
    var sessionComplete: Dynamic<Bool>
    var labelString: Dynamic<String> = Dynamic("")
    
    override init() {
        self.currentTime = Dynamic("--:--")
        self.currentState = Dynamic(.off)
        self.isPaused = Dynamic(false)
        self.pomodoroCount = Dynamic(0)
        self.sessionComplete = Dynamic(false)
        super.init()
        labelString.value = getLabelString()
    }
    
    func getLabelString() -> String {
        return "Work Time: \(workLength.inMinutes()) Break Time: \(breakLength.inMinutes())"
    }
    
    func getComponents() -> Int {
        return 2
    }
    
    func getRows(for component: Int) -> Int {
        if component == 0 {
            return workLengthRange.count
        }
        else {
            return breakLengthRange.count
        }
    }
    
    func titleForRow(component: Int, row: Int) -> String {
        if component == 0 {
            return "\(workLengthRange[row])"
        }
        else {
            return "\(breakLengthRange[row])"
        }
    }
    
    func updateTime(component: Int, row: Int) {
        if component == 0 {
            tempWorkLength = workLengthRange[row].inSeconds()
        }
        else {
            tempBreakLength = breakLengthRange[row].inSeconds()
        }
    }
    
    func toggleTimer() {
        if currentState.value == .off {
            startTimer()
            currentState.value = .onWork
        }
        else if isPaused.value {
            unPauseTimer()
        }
        else {
            pauseTimer()
        }
    }
    
    func startTimer() {
        let interval: TimeInterval = 1
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [weak self] timer in
            self?.count += 1
            self?.currentTime.value = self?.formattedTime(totalSeconds: self?.count ?? 0) ?? ""
            self?.checkIfBreakTime()
        })
    }
    
    func pauseTimer() {
        isPaused.value = true
        timer?.invalidate()
        timer = nil
    }
    
    func unPauseTimer() {
        isPaused.value = false
        startTimer()
    }
    
    func endTimer() {
        timer?.invalidate()
        timer = nil
        count = 0
        currentTime.value = "--:--"
        currentState.value = .off
    }
    
    func formattedTime(totalSeconds: Int) -> String {
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func sessionCompleted() {
        sessionComplete.value = true
        timer?.invalidate()
        timer = nil
        count = 0
        currentTime.value = "--:--"
    }
    
    func resetTempLengths() {
        tempWorkLength = workLength
        tempBreakLength = breakLength
    }
    
    func saveWorkAndBreakLengths() {
        workLength = tempWorkLength
        breakLength = tempBreakLength
        labelString.value = getLabelString()
    }

    func saveWorkAndBreakLengthsAsDefault() {
        saveWorkAndBreakLengths()
        UserDefaults.workLength = workLength
        UserDefaults.breakLength = breakLength
    }
    
    func checkIfBreakTime() {
        
        // break condition
        if currentState.value == .onWork, count == workLength {
            pomodoroCount.value += 1
            
            if pomodoroCount.value == 4 {
                sessionCompleted()
            }
            else {
                count = 0
                timer?.invalidate()
                timer = nil
                currentState.value = .onBreak
                startTimer()
            }
        }
        
        // resume work condition
        if currentState.value == .onBreak, count == breakLength {
            count = 0
            timer?.invalidate()
            timer = nil
            currentState.value = .onWork
            startTimer()
        }
    }
}

extension FocusViewModel: UIPickerViewDelegate, UIPickerViewDataSource {
            
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return getComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getRows(for: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateTime(component: component, row: row)
        if component == 0 {
            pickerView.reloadComponent(1)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleForRow(component: component, row: row)
    }
}
