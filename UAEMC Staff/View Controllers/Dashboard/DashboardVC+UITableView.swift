import UIKit

//MARK: UITableView Delegate and Datasource

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath) as? DashboardCell else {
            return UITableViewCell()
        }
        cell.leaveImageView.image = leaveImages[indexPath.row]
        cell.leaveLabel.text = leaves[indexPath.row]
        
        cell.imageBackgroundView.layer.cornerRadius = 5
        return cell
    }
}
