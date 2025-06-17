import Foundation

/// Extension to format an integer representing minutes as "HH:mm" string.
extension Int {
    /// Converts minutes to a "HH:mm" formatted string.
    /// Usage: 125.toHourMinuteString() // "02:05"
    func toHourMinuteString() -> String {
        let hours = self / 60
        let mins = self % 60
        return String(format: "%02d:%02d", hours, mins)
    }
}
