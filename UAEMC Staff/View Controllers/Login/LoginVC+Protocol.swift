import UIKit

//MARK: UITextFieldDelegate

extension LoginVC: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
        return false
    }
}

