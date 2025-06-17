import UIKit

//MARK: UITextFieldDelegate

extension RegisterVC: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
