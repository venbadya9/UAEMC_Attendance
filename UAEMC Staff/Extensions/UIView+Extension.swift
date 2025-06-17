import UIKit

extension UIView {
    /// Removes all layout constraints involving this view, from itself and any superviews.
    /// - Warning: Use with extreme caution! Removing all constraints may break your layout.
    public func removeAllConstraints() {
        var currentSuperview = self.superview
        while let superview = currentSuperview {
            for constraint in superview.constraints {
                if (constraint.firstItem as? UIView) == self || (constraint.secondItem as? UIView) == self {
                    superview.removeConstraint(constraint)
                }
            }
            currentSuperview = superview.superview
        }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }

    /// Adds a customizable drop shadow to the view.
    /// - Parameters:
    ///   - color: The color of the shadow (default: black).
    ///   - opacity: The opacity of the shadow (default: 0.5).
    ///   - offset: The offset of the shadow (default: (0, 3)).
    ///   - radius: The blur radius of the shadow (default: 3.0).
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offset: CGSize = CGSize(width: 0, height: 3),
        radius: CGFloat = 3.0
    ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}
