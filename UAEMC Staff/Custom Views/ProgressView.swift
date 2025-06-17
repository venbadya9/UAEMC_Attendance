import UIKit

class ProgressView: UIView {

    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var thumbImage: UIImage? {
        didSet {
            thumbImageView.image = thumbImage
        }
    }

    private let arcLayer = CAShapeLayer()
    private let thumbImageView = UIImageView()
    
    private let arcRadius: CGFloat = 80.0
    private let lineWidth: CGFloat = 10.0
    private let arcCenter: CGPoint = CGPoint(x: 200, y: 200)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        // Configure the arc layer
        arcLayer.strokeColor = UIColor.blue.cgColor
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.lineWidth = lineWidth
        arcLayer.lineCap = .round
        layer.addSublayer(arcLayer)

        // Configure the thumb image view
        thumbImageView.contentMode = .center
        addSubview(thumbImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Draw the arc path
        let startAngle: CGFloat = .pi * 3
        let endAngle: CGFloat = -.pi
        let path = UIBezierPath(arcCenter: arcCenter,
                                radius: arcRadius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        arcLayer.path = path.cgPath
        
        // Update the thumb position
        let thumbAngle = startAngle + (endAngle - startAngle) * progress
        let thumbX = arcCenter.x + arcRadius * cos(thumbAngle)
        let thumbY = arcCenter.y + arcRadius * sin(thumbAngle)
        thumbImageView.center = CGPoint(x: thumbX, y: thumbY)
        
        // Set the thumb image size based on the arc radius
        thumbImageView.bounds = CGRect(x: 0, y: 0, width: 40, height: 40) // Set the desired thumb size
    }
    
    // Call this function to set progress (value between 0.0 to 1.0)
    func setProgress(_ progress: CGFloat) {
        self.progress = max(0.0, min(1.0, progress))
    }
}
