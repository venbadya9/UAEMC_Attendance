import UIKit
import CoreLocation

protocol BaseProtocol {
    func createCheckInModel(_ isCheckedIn: Bool, _ isUpdate: Bool) -> CheckInModel
    func getUpdatedTime()
    func getInOutTime(_ details: CheckInModel)
    func getTotalWorkingHours(_ minutes: Int)
    func getWorkingText(_ text: String)
    func getCheckInDetails()
    func getCheckoutDetails()
    func getLocationDetails(location: CLLocation?)
    func resetDetails()
}

class BaseVC: UIViewController {
    
    //MARK: Variables
    
    var now = Date()
    var timeTimer = Timer()
    var progressTimer: Timer?
    var elapsedMinutes: Int = 0
    var popupView = PopupView()
    
    var _backgroundView: UIView!
    var _swipeView: CustomSwipeView!
    var _progressView: ProgressView!
    
    var dateFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    var delegate: BaseProtocol!
    
    //MARK: Constants
    
    let totalMinutes: Int = 8 * 60
    
    //MARK: Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timeTimer.invalidate()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        updateTime()
        timeTimer = Timer.scheduledTimer(timeInterval: 60.0
                                                , target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "E, d MMM"
        
        if let bg = _backgroundView {
            bg.layer.borderColor = UIColor(hexaRGB: "#E2E2E2")?.cgColor
            bg.layer.borderWidth = 1.0
            bg.addShadow()
        }
        _swipeView.addShadow()
        
        _swipeView.delegate = self
        _swipeView.updateInitialConfig()
        
        popupView.delegate = self
        
        popupView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupView)
        popupView.isHidden = true
        
        checkLocation()
        detectCheckInStatus()
    }
    
    func createCheckInDetails(
        isCheckedIn: Bool = true,
        isUpdate: Bool = false
    ) -> CheckInModel {
        
        return delegate.createCheckInModel(isCheckedIn, isUpdate)
    }
    
    func showPopup() {
        self.popupView.headerView.isHidden = false
        self.popupView.forgotPassword.isHidden = true
        self.popupView.isHidden = false
    }
    
    func checkLocation() {
        LocationManager.shared.getLocation { [weak self] location, error in
            guard let userLocation = location else {
                self?.alertMessage(message: LocationManager.LocationErrors.denied.rawValue)
                self?.delegate.getLocationDetails(location: nil)
                return
            }
            self?.delegate.getLocationDetails(location: userLocation)
        }
    }
    
    func detectCheckInStatus() {
        if let details = DatabaseHelper.shared.fetchCheckInDetails() {
            if details.checkInStatus == .checkedIn && details.checkInTime != nil {
                if progressTimer == nil {
                    progressTimer = Timer.scheduledTimer(timeInterval: 60.0
                                                         ,target: self, selector: #selector(updateLoggedTime), userInfo: nil, repeats: true)
                }
                delegate.getWorkingText("Working")
                updateLoggedTime()
            } else if details.checkInStatus == .checkedOut && details.checkInTime != nil {
                delegate.getWorkingText("Working Time")
                updateLoggedTime()
            } else {
                delegate.getWorkingText("Not Started Yet")
            }
        }
    }
    
    func minutesBetweenDates(_ oldDate: Date, _ newDate: Date) -> Int {
        let newDateMinutes = newDate.timeIntervalSinceReferenceDate/60
        let oldDateMinutes = oldDate.timeIntervalSinceReferenceDate/60
        return Int(CGFloat(newDateMinutes - oldDateMinutes))
    }
    
    func calculatePreviousWorkingHours(_ details: CheckInModel) {
        if let details = DatabaseHelper.shared.fetchCheckInDetails() {
            if details.checkInStatus == .checkedIn && (UserDefaults.standard.object(forKey: "TotalTime") == nil) {
                elapsedMinutes = minutesBetweenDates(details.checkInDate, Date())
            } else {
                if (UserDefaults.standard.object(forKey: "TotalTime") != nil) && details.checkInStatus == .checkedIn {
                    let totalMin = UserDefaults.standard.value(forKey: "TotalTime") as! Int
                    elapsedMinutes = minutesBetweenDates(details.checkInDate, Date()) + totalMin
                } else {
                    elapsedMinutes = details.elapsedTime
                }
            }
        }
        let progressFraction = CGFloat(elapsedMinutes) / CGFloat(totalMinutes)
        _progressView.progress = progressFraction
    }
    
    func detectDateChange() {
        let details = DatabaseHelper.shared.fetchCheckInDetails()
        if let checkedInDate = details?.checkInDate {
            if !Calendar.current.isDateInToday(checkedInDate) {
                DatabaseHelper.shared.deleteCheckInDetails()
                UserDefaults.standard.removeObject(forKey: "TotalTime")
                self.setupConfiguration()
                progressTimer = nil
                progressTimer?.invalidate()
                self.delegate.resetDetails()
            }
        }
    }
    
    //MARK: Objc Methods
    
    @objc func updateTime() {
        now = Date()
        timeFormatter.timeZone = TimeZone.current
        timeFormatter.dateFormat = "h:mm a"
        detectDateChange()
        delegate.getUpdatedTime()
    }
    
    @objc func updateLoggedTime() {
        _progressView.thumbView.image = UIImage(named: "Handler")
        _progressView.thumbView.frame.size = CGSize(width: 25, height: 25)
        
        guard elapsedMinutes < totalMinutes else {
            progressTimer = nil
            progressTimer?.invalidate()
            return
        }
        
        let progressFraction = CGFloat(elapsedMinutes) / CGFloat(totalMinutes)
        _progressView.progress = progressFraction
        
        if let details = DatabaseHelper.shared.fetchCheckInDetails() {
            if details.checkInTime == nil {
                let checkIn = self.createCheckInDetails(isUpdate: false)
                DatabaseHelper.shared.createCheckinDetails(details: checkIn)
            } else {
                delegate.getInOutTime(details)
                
                calculatePreviousWorkingHours(details)
                delegate.getTotalWorkingHours(elapsedMinutes)
                var isUpdate: Bool = true
                let checkInStatus = details.checkInStatus == .checkedIn ? true : false
                if details.checkInStatus == .checkedOut {
                    isUpdate = false
                }
                
                let checkIn = self.createCheckInDetails(isCheckedIn: checkInStatus, isUpdate: isUpdate)
                DatabaseHelper.shared.updateCheckInDetails(details: checkIn)
            }
        }
    }
    
    @objc func appMovedToForeground() {
        checkLocation()
        updateTime()
    }
}
