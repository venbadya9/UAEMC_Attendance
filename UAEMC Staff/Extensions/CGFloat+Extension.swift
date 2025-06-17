import UIKit

// MARK: - CGFloat Math Extensions
extension CGFloat {
    /// Converts degrees to radians.
    /// Usage: 45.0.toRadians()
    func toRadians() -> CGFloat {
        self * .pi / 180.0
    }
}
