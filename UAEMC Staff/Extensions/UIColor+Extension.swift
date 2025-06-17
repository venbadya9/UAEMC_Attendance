import UIKit

/// Extension to initialize UIColor using a hex string.
/// Supports 3-character (shorthand) and 6-character hex codes, with optional alpha.
/// Usage: UIColor(hexaRGB: "#FFAA22", alpha: 0.8)
extension UIColor {
    /// Initializes a UIColor from a hex RGB string.
    /// - Parameters:
    ///   - hexaRGB: A string representing the color hex code (e.g., "#FFAABB" or "FFAABB").
    ///   - alpha: The alpha value for the color (default is 1.0).
    convenience init?(hexaRGB: String, alpha: CGFloat = 1.0) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3:
            // Convert shorthand (e.g., "FAB") to "FFAABB"
            chars = chars.flatMap { [$0, $0] }
        case 6:
            break
        default:
            return nil
        }
        // Parse RGB values
        guard let r = UInt8(String(chars[0...1]), radix: 16),
              let g = UInt8(String(chars[2...3]), radix: 16),
              let b = UInt8(String(chars[4...5]), radix: 16) else { return nil }
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: alpha)
    }
}

// MARK: - If you want shared color definitions for both SwiftUI and UIKit,
// create a separate struct (e.g., AppColors) in a dedicated file:
import SwiftUI
struct AppColors {
    static let themeColor = Color("Theme")
    static let blackColor = Color("Black")
    static let themeUIColor = UIColor(named: "Theme") ?? .systemBlue
    static let blackUIColor = UIColor(named: "Black") ?? .black
}
