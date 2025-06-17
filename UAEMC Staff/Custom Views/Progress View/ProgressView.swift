import UIKit

class ProgressView: UIView {
    
    //MARK: Private Variables
    
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    //MARK: Variables
    
    let thumbView = UIImageView()

    var progress: CGFloat = 0 {
        didSet {
            progress = min(max(progress, 0), 1)
            updateProgress()
        }
    }
    
    //MARK: Lifecycle Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let path = createArcPath()
        trackLayer.path = path.cgPath
        progressLayer.path = path.cgPath
        updateProgress()
    }

    //MARK: Private Functions
    
    private func setupView() {
        trackLayer.strokeColor = UIColor(hexaRGB: "#C2B7A6")?.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)

        progressLayer.strokeColor = UIColor.theme.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 20
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)

        thumbView.image = UIImage(named: "Initial Handler")
        thumbView.frame.size = CGSize(width: 18, height: 18)
        thumbView.layer.cornerRadius = 9
        thumbView.layer.masksToBounds = true
        addSubview(thumbView)
    }

    private func createArcPath() -> UIBezierPath {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - trackLayer.lineWidth / 2
        
        return UIBezierPath(arcCenter: center,
                            radius: radius,
                            startAngle: -CGFloat.pi * 4 / 3,
                            endAngle: CGFloat.pi / 3,
                            clockwise: true)
    }

    private func updateProgress() {
        let startAngle = -CGFloat.pi * 4 / 3
        let endAngle = CGFloat.pi / 3
        
        let angle = startAngle + progress * (endAngle - startAngle)
        let radius = min(bounds.width, bounds.height) / 2 - trackLayer.lineWidth / 2
        
        let thumbCenter = CGPoint(
            x: bounds.midX + radius * cos(angle),
            y: bounds.midY + radius * sin(angle)
        )
        
        thumbView.center = thumbCenter
        progressLayer.strokeEnd = progress
    }
}
