import UIKit

class InformationVC: UIViewController {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var headerView: HeaderView!

    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        headerView.headerLabel.text = "Information"
        headerView.delegate = self
        headerView.backButton.isHidden = false
        [headerView.menuButton, headerView.notificationButton].forEach( { $0?.isHidden = true })
    }
}
