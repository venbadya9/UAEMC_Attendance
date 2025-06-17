import UIKit
import MessageUI

class ContactVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var licenseView: UIView!
    @IBOutlet weak var licenseHeaderView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productHeaderView: UIView!

    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        headerView.headerLabel.text = "Contact Us"
        headerView.delegate = self
        [licenseView, productView].forEach( {
            $0?.addShadow()
            $0?.layer.borderColor = UIColor(hexaRGB: "#E2E2E2")?.cgColor
            $0?.layer.borderWidth = 1.0
        } )
    }
    
    func openMailBox(_ emailString: String) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            composeVC.setToRecipients(["\(emailString)"])
            composeVC.setSubject("Query")
            composeVC.setMessageBody("", isHTML: false)
            
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    //MARK: IBActions
    
    @IBAction func licenseContactTapped(_ sender: UIButton) {
        if  let url = URL(string: "tel:123345678999999999"), UIApplication.shared.canOpenURL(url)  {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func licenseEmailTapped(_ sender: UIButton) {
        openMailBox("uaemc@uaemc.gov.ae")
    }
    
    @IBAction func productContactTapped(_ sender: UIButton) {
        if  let url = URL(string: "tel:962653338565"), UIApplication.shared.canOpenURL(url)  {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func productEmailTapped(_ sender: UIButton) {
        openMailBox("helpdesk@uaemc.gov.ae")
    }
    
    @IBAction func websiteTapped(_ sender: UIButton) {
        if let yourURL = URL(string: "https://uaemc.gov.ae") {
            UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
        }
    }
}
