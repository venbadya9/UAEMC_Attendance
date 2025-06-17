import UIKit

//MARK: UITableView Delegate and Datasource

extension SelfServiceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "selfServiceCell", for: indexPath) as? SelfServiceCell else {
            return UITableViewCell()
        }
        return cell
    }
}
