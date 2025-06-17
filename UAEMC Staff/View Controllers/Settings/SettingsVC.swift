import UIKit
import WMSegmentControl

class SettingsVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var segmentedControl: WMSegment!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var enableFingerPrint: UISwitch!
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        headerView.headerLabel.text = "Settings"
        headerView.delegate = self
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.SelectedFont = UIFont(name: "Poppins-SemiBold", size: 12.0)!
        segmentedControl.normalFont = UIFont(name: "Poppins-SemiBold", size: 12.0)!
        
        backgroundView.addShadow()
        backgroundView.layer.borderColor = UIColor(hexaRGB: "#E2E2E2")?.cgColor
        backgroundView.layer.borderWidth = 1.0
        
        enableFingerPrint.set(width: 24.0, height: 14.0)
    }
}
