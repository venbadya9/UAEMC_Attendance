import UIKit

//MARK: UIColletionView Delegate and Datasource

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
            if let dashboardVC = UAEMCBundleResources.vcWithName(name: "DashboardVC") {
                self.navigationController?.pushViewController(dashboardVC, animated: true)
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
            if let adminVC = UAEMCBundleResources.vcWithName(name: "AdminVC") {
                self.navigationController?.pushViewController(adminVC, animated: true)
            }
        default:
            break
        }
    }
}

//MARK: UIColletionViewFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90.0, height: 110.0)
    }
}
