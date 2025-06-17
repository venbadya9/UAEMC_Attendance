import UIKit
import CoreLocation
import MapKit

extension AttendanceVC: BaseProtocol {
    func createCheckInModel(_ isCheckedIn: Bool, _ isUpdate: Bool) -> CheckInModel {
        let checkIn = CheckInModel(
            checkInStatus: isCheckedIn ? CheckInStatus.checkedIn : CheckInStatus.checkedOut,
            elapsedTime: elapsedMinutes,
            checkInTime: inTimeLabel.text,
            checkOutTime: outTimeLabel.text,
            workMode: workModeLabel.text,
            location: locationLabel.text,
            checkInDate: isUpdate ? DatabaseHelper.shared.fetchCheckInDetails()?.checkInDate : Date()
        )
        return checkIn
    }
    
    func getUpdatedTime() {
        let timeString = timeFormatter.string(from: now)
        self.timeLabel.text = timeString
    }
    
    func getInOutTime(_ details: CheckInModel) {
        self.inTimeLabel.text = details.checkInTime
        self.outTimeLabel.text = details.checkOutTime
    }
    
    func getTotalWorkingHours(_ minutes: Int) {
        workingHours.text = elapsedMinutes.formatTime(minutes: minutes)
    }
    
    func getWorkingText(_ text: String) {
        workingStatus.attributedText = NSAttributedString(string: text)
    }
    
    func getCheckInDetails() {
        self.popupView.timeLabel.text = self.timeLabel.text
        if self.inTimeLabel.text == "00:00" {
            self.inTimeLabel.text = self.timeLabel.text
        }
    }
    
    func getCheckoutDetails() {
        self.popupView.timeLabel.text = self.timeLabel.text
        self.outTimeLabel.text = self.timeLabel.text
    }
    
    func resetDetails() {
        self.inTimeLabel.text = "00:00"
        self.outTimeLabel.text = "00:00"
        self.workingHours.text = "00:00"
        self.workingStatus.attributedText = NSAttributedString(string: "Not Started Yet")
    }
    
    func getLocationDetails(location: CLLocation?) {
        if let userLocation = location {
            LocationManager.shared.getReverseGeoCodedLocation(location: userLocation, completionHandler: { location, placemark, error in
                if let address = placemark {
                    self.locationLabel.text = address.name
                }
            })
            setAnnotationOnMap(location: userLocation)
        } else {
            self.locationLabel.text = "-"
        }
    }
    
    func setAnnotationOnMap(location: CLLocation) {
        let locationValue: CLLocationCoordinate2D = location.coordinate
        mapView.mapType = MKMapType.standard
        
        mapView.showsUserLocation = true
        mapView.centerCoordinate = locationValue
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: locationValue, span: span)
        mapView.setRegion(region, animated: true)
    }
}
