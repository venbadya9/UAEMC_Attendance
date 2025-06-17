import UIKit

class ServiceVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Constants
    
    let serviceImages = [#imageLiteral(resourceName: "Attendance Service"), #imageLiteral(resourceName: "Self Service"), #imageLiteral(resourceName: "Calendar Service"), #imageLiteral(resourceName: "Admin Service"), #imageLiteral(resourceName: "Dashboard Service"), #imageLiteral(resourceName: "Reports Service"), #imageLiteral(resourceName: "Summary Service"), #imageLiteral(resourceName: "Employment Service")]
    let serviceName = ["Attendance", "Self Service", "Calendar", "Admin Service", "Dashboard", "Reports", "Summary", "Employee Info"]
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        headerView.headerLabel.text = "Services"
        headerView.delegate = self
    }
}
