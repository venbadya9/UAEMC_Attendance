import UIKit

class HomeVC: BaseVC {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var swipeView: CustomSwipeView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var inTimeLabel: UILabel!
    @IBOutlet weak var outTimeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var workingHours: UILabel!
    @IBOutlet weak var workingStatus: UILabel!
    @IBOutlet weak var workModeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    //MARK: Constants
    
    let serviceImages = [#imageLiteral(resourceName: "Attendance"), #imageLiteral(resourceName: "Dashboard"), #imageLiteral(resourceName: "Calendar"), #imageLiteral(resourceName: "Admin")]
    let serviceName = ["Attendance", "Dashboard", "Calendar", "Admin Service"]
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _backgroundView = backgroundView
        _swipeView = swipeView
        _progressView = progressView

        delegate = self
        setupConfiguration()
        setupProfile()
    }
    
    //MARK: Methods

    func setupProfile() {
        let name = "Welcome, Venkatesh Badya"
        let attributedText = NSMutableAttributedString(string: name)
        let fontAttribute = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 14.0)]
        let rangeToRegular = (name as NSString).range(of: "Welcome,")
        attributedText.addAttributes(fontAttribute as [NSAttributedString.Key : Any], range: rangeToRegular)
        nameLabel.attributedText = attributedText
        
        let dateString = dateFormatter.string(from: now)
        dateLabel.text = dateString
    }

    //MARK: IBActions
    
    @IBAction func profileTapped(_ sender: Any) {
        if let profileVC = UAEMCBundleResources.vcWithName(name: "ProfileVC") {
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    @IBAction func informationTapped(_ sender: Any) {
        if let informationVC = UAEMCBundleResources.vcWithName(name: "InformationVC") {
            self.navigationController?.pushViewController(informationVC, animated: true)
        }
    }
    
    @IBAction func notificationTapped(_ sender: Any) {
        if let announcementVC = UAEMCBundleResources.vcWithName(name: "AnnouncementVC") {
            self.navigationController?.pushViewController(announcementVC, animated: true)
        }
    }
    
    @IBAction func viewAllServicesTapped(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
}
