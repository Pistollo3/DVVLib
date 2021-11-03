//
//  VFGLoginVerification+ResendButtonTimer.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 09/06/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
extension VFGLoginVerification {
    func startResendButtonTimer() {
        countdownSeconds = verificationDelegate?.resendCodeCountDownSeconds ?? 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateResendButtonText),
            userInfo: nil,
            repeats: true
        )
        updateResendButtonText()
    }

    func stopResendButtonTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc func updateResendButtonText() {
        countdownSeconds -= 1
        let countdown = formatTimeInSeconds(countdownSeconds)
        if countdownSeconds > 0 {
            setupResendButton(countDownValue: countdown)
        } else {
            setupResendButton()
            timer?.invalidate()
        }
    }

    func formatTimeInSeconds(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
