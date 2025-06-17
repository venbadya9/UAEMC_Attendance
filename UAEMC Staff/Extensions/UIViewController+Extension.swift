import UIKit

// MARK: - HeaderDelegate Default Implementation for UIViewController
extension UIViewController: HeaderDelegate {
    /// Pushes the Announcement screen when the notification button is tapped.
    func notificationBtnTapped() {
        guard let announcementVC = UAEMCBundleResources.vcWithName(name: "AnnouncementVC") else {
            print("Error: Could not instantiate AnnouncementVC")
            return
        }
        navigationController?.pushViewController(announcementVC, animated: true)
    }
    
    /// Pushes the Information screen when the menu button is tapped.
    func menuBtnTapped() {
        guard let informationVC = UAEMCBundleResources.vcWithName(name: "InformationVC") else {
            print("Error: Could not instantiate InformationVC")
            return
        }
        navigationController?.pushViewController(informationVC, animated: true)
    }
    
    /// Pops the current view controller when the back button is tapped.
    func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - PopupDelegate Default Implementation for UIViewController
extension UIViewController: PopupDelegate {
    /// Dismisses the custom popup view and re-enables tab bar interaction.
    func dismissPopup(_ popupView: PopupView) {
        popupView.isHidden = true
        tabBarController?.tabBar.isUserInteractionEnabled = true
    }
}

// MARK: - UIViewController Utility Extensions
extension UIViewController {
    /// Presents a general-purpose alert with customizable title, message, and settings button.
    /// - Parameters:
    ///   - message: The alert message to display.
    ///   - title: The alert title. Default is "Alert".
    ///   - settingsAction: Whether to show a Settings button (default: false).
    func presentAlert(
        message: String,
        title: String = "Alert",
        settingsAction: Bool = false
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if settingsAction {
            let openAction = UIAlertAction(title: "Settings", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
            alert.addAction(openAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // Present on topmost view controller
        if presentedViewController == nil {
            present(alert, animated: true)
        } else {
            dismiss(animated: false) {
                self.present(alert, animated: true)
            }
        }
    }
}
