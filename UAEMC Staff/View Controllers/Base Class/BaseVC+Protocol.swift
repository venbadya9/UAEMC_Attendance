import UIKit

extension BaseVC: AttendanceDelegate {
    
    func getInTime() {
        LocationManager.shared.getLocation { [weak self] location, error in
            guard let _ = location else {
                self?.alertMessage(message: LocationManager.LocationErrors.denied.rawValue)
                self?._swipeView.setupCheckIn()
                return
            }
            self?.popupView.titleLabel.text = "Welcome to Test Location-The Time is"
            self?.showPopup()
            self?.tabBarController?.tabBar.isUserInteractionEnabled = false
            self?.delegate.getCheckInDetails()
            self?.delegate.getWorkingText("Working")
            let checkIn = self?.createCheckInDetails(isCheckedIn: true, isUpdate: false)
            DatabaseHelper.shared.updateCheckInDetails(details: checkIn!)
            self?.updateLoggedTime()
            if self?.progressTimer == nil {
                self?.progressTimer = Timer.scheduledTimer(timeInterval: 60.0
                                                           ,target: self!, selector: #selector(self?.updateLoggedTime), userInfo: nil, repeats: true)
            }
        }
    }
    
    func getOutTime() {
        LocationManager.shared.getLocation { [weak self] location, error in
            guard let _ = location else {
                self?.alertMessage(message: LocationManager.LocationErrors.denied.rawValue)
                self?._swipeView.setupCheckOut()
                return
            }
            self?.popupView.titleLabel.text = "Have a Nice Day-The Time is"
            self?.showPopup()
            self?.tabBarController?.tabBar.isUserInteractionEnabled = false
            self?.delegate.getCheckoutDetails()
            self?.delegate.getWorkingText("Working Time")
            let checkIn = self?.createCheckInDetails(isCheckedIn: false, isUpdate: true)
            DatabaseHelper.shared.updateCheckInDetails(details: checkIn!)
            UserDefaults.standard.setValue(self?.elapsedMinutes, forKey: "TotalTime")
            self?.calculatePreviousWorkingHours(checkIn!)
            self?.progressTimer = nil
            self?.progressTimer?.invalidate()
        }
    }
}
