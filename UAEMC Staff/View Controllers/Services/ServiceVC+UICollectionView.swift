import UIKit

//MARK: UIColletionView Delegate and Datasource

extension ServiceVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serviceCell", for: indexPath) as? ServiceCell else { return UICollectionViewCell() }
        
        cell.serviceImageView.image = serviceImages[indexPath.item]
        cell.serviceLabel.text = serviceName[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.row) {
        case 0:
            if let attendanceVC = UAEMCBundleResources.vcWithName(name: "AttendanceVC") {
                self.navigationController?.pushViewController(attendanceVC, animated: true)
            }
        case 1:
            if let selfServiceVC = UAEMCBundleResources.vcWithName(name: "SelfServiceVC") {
                self.navigationController?.pushViewController(selfServiceVC, animated: true)
            }
        case 2:
            if let calendarVC = UAEMCBundleResources.vcWithName(name: "CalendarVC") {
                self.navigationController?.pushViewController(calendarVC, animated: true)
            }
        case 3:
            if let adminVC = UAEMCBundleResources.vcWithName(name: "AdminVC") {
                self.navigationController?.pushViewController(adminVC, animated: true)
            }
        case 4:
            if let dashboardVC = UAEMCBundleResources.vcWithName(name: "DashboardVC") {
                self.navigationController?.pushViewController(dashboardVC, animated: true)
            }
        case 5:
            if let reportVC = UAEMCBundleResources.vcWithName(name: "ReportVC") {
                self.navigationController?.pushViewController(reportVC, animated: true)
            }
        case 6:
            if let summaryVC = UAEMCBundleResources.vcWithName(name: "SummaryVC") {
                self.navigationController?.pushViewController(summaryVC, animated: true)
            }
        case 7:
            if let employeeInfoVC = UAEMCBundleResources.vcWithName(name: "EmployeeInfoVC") {
                self.navigationController?.pushViewController(employeeInfoVC, animated: true)
            }
        default:
            break
        }
    }
}

//MARK: UIColletionViewFlowLayout

extension ServiceVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width / 2) - 15.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
}
