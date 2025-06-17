import UIKit
import HorizonCalendar

final class DayRangeIndicatorView: UIView {
    
    private let indicatorColor: UIColor
    
    init(indicatorColor: UIColor) {
        self.indicatorColor = indicatorColor
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var framesOfDaysToHighlight = [CGRect]() {
        didSet {
            guard framesOfDaysToHighlight != oldValue else { return }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(indicatorColor.cgColor)
        
        var dayRowFrames = [CGRect]()
        var currentDayRowMinY: CGFloat?
        for dayFrame in framesOfDaysToHighlight {
            if dayFrame.minY != currentDayRowMinY {
                currentDayRowMinY = dayFrame.minY
                dayRowFrames.append(dayFrame)
            } else {
                let lastIndex = dayRowFrames.count - 1
                dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
            }
        }
        
        for dayRowFrame in dayRowFrames {
            let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: 5)
            context?.addPath(roundedRectanglePath.cgPath)
            context?.fillPath()
        }
    }
}

extension DayRangeIndicatorView: CalendarItemViewRepresentable {
    struct InvariantViewProperties: Hashable {
        let indicatorColor: UIColor
    }
    
    struct Content: Equatable {
        let framesOfDaysToHighlight: [CGRect]
    }
    
    static func makeView(
        withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> DayRangeIndicatorView {
        DayRangeIndicatorView(indicatorColor: invariantViewProperties.indicatorColor)
    }
    
    static func setContent(_ content: Content, on view: DayRangeIndicatorView) {
        view.framesOfDaysToHighlight = content.framesOfDaysToHighlight
    }
}
