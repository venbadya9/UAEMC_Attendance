import UIKit

/// Extension to allow UISwitch scaling via transform.
/// Note: Scaling UISwitch via transform is a UIKit workaround and may impact pixel-perfect rendering or touch target accuracy.
/// Use with caution and always test on actual devices.
extension UISwitch {
    /// Scales the UISwitch to the specified width and height.
    /// - Parameters:
    ///   - width: The target width for the switch.
    ///   - height: The target height for the switch.
    func scale(toWidth width: CGFloat, height: CGFloat) {
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        guard width > 0, height > 0 else {
            assertionFailure("UISwitch width and height must be positive.")
            return
        }

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        self.transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
