import UIKit

class ProfileVC: UIViewController {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var headerView: HeaderView!

    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        headerView.headerLabel.text = "Profile"
        headerView.delegate = self
        headerView.backButton.isHidden = false
        [headerView.menuButton, headerView.notificationButton].forEach( { $0?.isHidden = true })
    }
    
    //MARK: IBActions
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        
    }
}
