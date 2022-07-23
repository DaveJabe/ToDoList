//
//  FocusViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/22/22.
//

import Foundation

class FocusViewModel {
    
    private var timer: Timer?
    
    var currentTime: Dynamic<String>
    var isPaused: Dynamic<Bool?>
    var onBreak: Dynamic<Bool?>
    
    var count = 0
    
    init() {
        self.currentTime = Dynamic("00:00")
        self.isPaused = Dynamic(nil)
        self.onBreak = Dynamic(nil)
    }
    
    func toggleTimer() {
        if let paused = isPaused.value {
            if paused {
                startTimer()
            }
            else {
                pauseTimer()
            }
            isPaused.value = !isPaused.value!
        }
        else {
            startTimer()
            isPaused.value = false
        }
    }
    
    func startTimer() {
        let interval: TimeInterval = 1
        if onBreak.value == nil {
            onBreak.value = false
        }
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [weak self] timer in
            self?.count += 1
            self?.currentTime.value = self?.formattedTime(totalSeconds: self?.count ?? 0) ?? ""
            self?.checkIfBreakTime()
        })
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func endTimer() {
        pauseTimer()
        onBreak.value = nil
        isPaused.value = nil
        count = 0
        currentTime.value = formattedTime(totalSeconds: 0)
    }
    
    func formattedTime(totalSeconds: Int) -> String {
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func checkIfBreakTime() {
        
        // break condition
        if count == 30 {
            endTimer()
            onBreak.value = true
            startTimer()
        }
        
        // resume work condition
        if let onBreakValue = onBreak.value {
            if onBreakValue, count == 15 {
                onBreak.value = false
                endTimer()
                startTimer()
            }
        }
    }
}
