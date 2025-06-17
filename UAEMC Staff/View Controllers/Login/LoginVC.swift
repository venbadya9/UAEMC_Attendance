import UIKit

class LoginVC: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberButton: UIButton!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var selectedLanguage: UILabel!
    @IBOutlet weak var availableLanguage: UILabel!
    
    //MARK: Variables
    
    var unchecked = true
    var popupView = PopupView()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        [self.emailTextField, self.passwordTextField].forEach { $0.resignFirstResponder() }
    }
    
    //MARK: Functions
    
    func setupConfiguration() {
        
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme]
        )
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme]
        )
        
        languageView.layer.borderColor = UIColor.theme.cgColor
        languageView.layer.borderWidth = 1.0
        
        popupView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(popupView)
        popupView.isHidden = true
        popupView.delegate = self
    }
    
    //MARK: IBActions
    
    @IBAction func rememberMeTapped(_ sender: UIButton) {
        if unchecked {
            sender.setImage(UIImage(named:"Checked"), for: .normal)
            unchecked = false
        } else {
            sender.setImage( UIImage(named:"Checkbox"), for: .normal)
            unchecked = true
        }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        if let tabBarController = UAEMCBundleResources.vcWithName(name: "TabBarVC") {
            self.navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        self.popupView.headerView.isHidden = true
        self.popupView.forgotPassword.isHidden = false
        self.popupView.isHidden = false
    }
    
    @IBAction func didTapLanguage(_ sender: UITapGestureRecognizer) {
        dropDownView.isHidden = !dropDownView.isHidden
        availableLanguage.text = selectedLanguage.text == "English" ? "عربي" : "English"
    }
    
    @IBAction func didSelectLangauge(_ sender: UITapGestureRecognizer) {
        dropDownView.isHidden = true
        selectedLanguage.text = selectedLanguage.text == "English" ? "عربي" : "English"
    }
}
