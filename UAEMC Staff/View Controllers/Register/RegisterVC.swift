import UIKit

class RegisterVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var selectedLanguage: UILabel!
    @IBOutlet weak var availableLanguage: UILabel!
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
    }
    
    //MARK: Functions
    
    func setupConfiguration() {
        
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme]
        )
        
        languageView.layer.borderColor = UIColor.theme.cgColor
        languageView.layer.borderWidth = 1.0
    }
    
    //MARK: IBActions
    
    @IBAction func didTapLanguage(_ sender: UITapGestureRecognizer) {
        dropDownView.isHidden = !dropDownView.isHidden
        availableLanguage.text = selectedLanguage.text == "English" ? "عربي" : "English"
    }
    
    @IBAction func didSelectLangauge(_ sender: UITapGestureRecognizer) {
        dropDownView.isHidden = true
        selectedLanguage.text = selectedLanguage.text == "English" ? "عربي" : "English"
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
//        if let enteredEmail = emailTextField.text, enteredEmail.isValidEmail() {
            if let loginVC = UAEMCBundleResources.vcWithName(name: "LoginVC") {
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
//        }
    }
}

