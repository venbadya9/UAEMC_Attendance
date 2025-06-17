import UIKit

class AdminVC: UIViewController {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var headerView: HeaderView!

    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        headerView.headerLabel.text = "Admin Services"
        headerView.delegate = self
        headerView.backButton.isHidden = false
    }
    
    //MARK: IBActions
    
    @IBAction func announcementTapped(_ sender: UIButton) {
        if let announcementVC = UAEMCBundleResources.vcWithName(name: "AnnouncementVC") {
            self.navigationController?.pushViewController(announcementVC, animated: true)
        }
    }
    
    @IBAction func permissionTapped(_ sender: UIButton) {
        if let permissionVC = UAEMCBundleResources.vcWithName(name: "PermissionVC") {
            self.navigationController?.pushViewController(permissionVC, animated: true)
        }
    }
}
