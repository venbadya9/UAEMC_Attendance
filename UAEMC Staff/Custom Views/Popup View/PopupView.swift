import UIKit

//MARK: Protocol

protocol PopupDelegate {
    func dismissPopup(_ popupView: PopupView)
}

class PopupView: UIView {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var forgotPassword: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: Varibales
    
    var delegate: PopupDelegate!
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
    }
    
    //MARK: IBActions
    
    @IBAction func okTapped(_ sender: UIButton) {
        delegate.dismissPopup(self)
        emailTextField.resignFirstResponder()
    }
}

extension PopupView {
    
    //MARK: Methods
    
    func configureView() {
        guard let popupView = Bundle.main.loadNibNamed("PopupView", owner: self)?.first as? UIView else { return }
        self.addSubview(popupView)
        popupView.frame = self.bounds
        
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme]
        )
        
        emailView.layer.borderColor = UIColor.theme.cgColor
        emailView.layer.borderWidth = 1.0
        emailView.layer.cornerRadius = 10.0
    }
}

//MARK: Textfield Delegate

extension PopupView: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
