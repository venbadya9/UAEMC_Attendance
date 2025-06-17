import UIKit

class CalendarVC: UIViewController {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        headerView.headerLabel.text = "Calendar"
        headerView.delegate = self
        headerView.backButton.isHidden = false
        
        searchView.layer.borderColor = UIColor(hexaRGB: "#976F33", alpha: 1.0)?.cgColor
        searchView.layer.borderWidth = 1.0
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search Date",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 11.0)!]
        )
    }
}

