import UIKit
import Foundation

@IBDesignable class CustomTabBar: UITabBar {
    
    // MARK: Variables
    
    @IBInspectable public var barBackColor = UIColor(hexaRGB: "#976F33", alpha: 1.0)
    @IBInspectable public var barHeight = 80.0
    @IBInspectable public var barTopRadius = 2.0
    @IBInspectable public var barBottomRadius = 2.0
    @IBInspectable public var circleBackColor = UIColor(hexaRGB: "#976F33", alpha: 1.0)
    @IBInspectable public var circleRadius = 30.0
    
    // MARK: Lazy Variables
    
    private lazy var background: CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillColor = self.barBackColor?.cgColor
        result.mask = self.backgroundMask
        return result
    }()
    
    private lazy var circle: CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillColor = circleBackColor?.cgColor
        return result
    }()
    
    private lazy var backgroundMask: CAShapeLayer = {
        let result = CAShapeLayer()
        result.fillRule = CAShapeLayerFillRule.evenOdd
        return result
    }()
    
    // MARK: Constants

    let pi = CGFloat.pi
    let pi2 = CGFloat.pi / 2
    let pitCornerRad: CGFloat = 10

    // MARK: Private Methods
    
    private var barRect : CGRect {
        get {
            let height = self.barHeight
            let width = bounds.width
            let xPosition = bounds.minX
            let yPosition = circleRadius
            
            let rect = CGRect(x: xPosition, y: yPosition, width: width, height: height)
            return rect
        }
    }
    
    private func createCircleRect() -> CGRect {
        let backRect = barRect
        let radius = circleRadius
        let circleXCenter = getCircleCenter()
        
        let xPosition = circleXCenter - radius
        let yPosition = backRect.origin.y - radius + pitCornerRad
        
        let position = CGPoint(x: xPosition, y: yPosition)
        
        let result = CGRect(origin: position, size: CGSize(width: radius * 2, height: radius * 2))
        return result
    }
    
    private func createCirclePath() -> CGPath {
        let circleRect = createCircleRect()
        let result = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.height / 2)
        return result.cgPath
    }
    
    private func getCircleCenter() -> CGFloat {
        let totalWidth = self.bounds.width
        var xPosition = totalWidth / 2
        if let view = getViewForItem(item: self.selectedItem) {
            xPosition = view.frame.minX + (view.frame.width / 2)
        }
        return xPosition
    }
    
    private func createBackgroundPath() -> CGPath {
        let rect = barRect
        let topLeftRadius = self.barTopRadius
        let topRightRadius = self.barTopRadius
        let bottomRigtRadius = self.barBottomRadius
        let bottomLeftRadius = self.barBottomRadius
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topLeftRadius, y:rect.minY))
        path.addArc(withCenter: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius), radius: topRightRadius, startAngle:3 * pi2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRigtRadius))
        path.addArc(withCenter: CGPoint(x: rect.maxX - bottomRigtRadius, y: rect.maxY - bottomRigtRadius), radius: bottomRigtRadius, startAngle: 0, endAngle: pi2, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX + bottomRigtRadius, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius), radius: bottomLeftRadius, startAngle: pi2, endAngle: pi, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        path.addArc(withCenter: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius), radius: topLeftRadius, startAngle: pi, endAngle: 3 * pi2, clockwise: true)
        path.close()
        
        return path.cgPath
    }
    
    private func getTabBarItemViews() -> [(item: UITabBarItem, view: UIView)] {
        guard let items = self.items else {
            return[]
        }
        
        var result: [(item : UITabBarItem, view: UIView)] = []
        for item in items {
            if let view = getViewForItem(item: item) {
                result.append((item: item, view: view))
            }
        }
        return result
    }
    
    private func getViewForItem(item : UITabBarItem?) -> UIView? {
        if let item = item {
            let view = item.value(forKey: "view") as? UIView
            return view
        }
        return nil
    }
    
    private func positionItem(barRect: CGRect, totalCount: Int, index: Int, item: UITabBarItem, view: UIView) {
        let margin: CGFloat = 17
        let xPosition = view.frame.origin.x
        var yPosition = barRect.origin.y + margin
        let height = barHeight - (margin * 2)
        let width = view.frame.width
        if self.selectedItem == item {
            yPosition = barRect.origin.y - (self.circleRadius / 2)
        }
        view.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
    }
    
    private func animateHideAndShowItem(itemView : UIView) {
        itemView.alpha = 0
        itemView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() , execute: {
            UIView.animate(withDuration: 0.0) {
                itemView.alpha = 1
            }
        })
    }
    private func createPathMoveAnimation(toVal: CGPath) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.1
        animation.toValue = toVal
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        return animation
    }
    
    private func replaceAnimation(layer :CAShapeLayer, withNew : CABasicAnimation, forKey: String) {
        let existing = layer.animation(forKey: forKey) as? CABasicAnimation
        if existing != nil {
            withNew.fromValue = existing!.toValue
        }
        layer.removeAnimation(forKey: forKey)
        layer.add(withNew, forKey: forKey)
    }
    
    private func moveCircleAnimated() {
        let bgMaskNewPath = self.createPitMaskPath(rect: self.bounds)
        let circleNewPath = self.createCirclePath()
    
        let bgAni = createPathMoveAnimation(toVal: bgMaskNewPath)
        let circleAni = createPathMoveAnimation(toVal: circleNewPath)
        
        self.replaceAnimation(layer: backgroundMask, withNew: bgAni, forKey: "move_animation")
        self.replaceAnimation(layer: circle, withNew: circleAni, forKey: "move_animation")
    }
    
    private func layoutElements(selectedChanged : Bool) {
        self.background.path = self.createBackgroundPath()
        if self.backgroundMask.path == nil {
            self.backgroundMask.path = self.createPitMaskPath(rect: self.bounds)
            self.circle.path = self.createCirclePath()
        } else {
            moveCircleAnimated()
        }
        
        let items = getTabBarItemViews()
        if items.count <= 0 {
            return
        }
        
        let barR = barRect
        let total = items.count
        for (index, item) in items.enumerated() {
            if selectedChanged {
                self.animateHideAndShowItem(itemView: item.view)
            }
            self.positionItem(barRect: barR, totalCount: total, index: index, item: item.item, view: item.view)
        }
    }
    
    private func setup() {
        self.backgroundColor = UIColor.clear
        self.isTranslucent = true

        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundEffect = .none
            tabBarAppearance.shadowColor = .clear
            tabBarAppearance.backgroundColor = UIColor.clear
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        
        self.layer.insertSublayer(background, at: 0)
        self.layer.insertSublayer(circle, at: 0)
        
        self.tintColor = .white
        self.unselectedItemTintColor = UIColor.white
    }
    
    // MARK: Functions
    
    func createPitMaskPath(rect: CGRect) -> CGMutablePath {
        let circleXcenter = getCircleCenter()
        let backRect = barRect
        let xPosition: CGFloat = circleXcenter + pitCornerRad
        let yPosition = backRect.origin.y
        
        let center = CGPoint(x: xPosition, y: yPosition)
        let maskPath = CGMutablePath()
        maskPath.addRect(rect)
        
        let pit = createPitPath(center: center)
        maskPath.addPath(pit)
        return maskPath
    }
    
    func createPitPath(center: CGPoint) -> CGPath {
        let rad = self.circleRadius + 5
        let xPosition = center.x - rad - pitCornerRad
        let yPosition = center.y
        
        let result = UIBezierPath()
        result.lineWidth = 0
        result.move(to: CGPoint(x: xPosition - 0, y: yPosition + 0))
        result.addArc(withCenter: CGPoint(x: (xPosition - pitCornerRad), y: (yPosition + pitCornerRad)), radius: pitCornerRad, startAngle: CGFloat(270).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: true)
        result.addArc(withCenter: CGPoint(x: (xPosition + rad), y: (yPosition + pitCornerRad ) ), radius: rad, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
        result.addArc(withCenter: CGPoint(x: (xPosition + (rad * 2) + pitCornerRad), y: (yPosition + pitCornerRad) ), radius: pitCornerRad, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(270).toRadians(), clockwise: true)
        result.addLine(to: CGPoint(x: xPosition + (pitCornerRad * 2) + (rad * 2), y: yPosition))
        result.addLine(to: CGPoint(x: 0, y: 0))
        result.close()
        
        return result.cgPath
    }
    
    //MARK: Superclass Functions
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = self.barHeight + self.circleRadius
        return sizeThatFits
    }
    
    override var selectedItem: UITabBarItem? {
        get {
            return super.selectedItem
        }
        set {
            let changed = (super.selectedItem != newValue)
            super.selectedItem = newValue
            if changed {
                layoutElements(selectedChanged: changed)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        background.fillColor = self.barBackColor?.cgColor
        circle.fillColor = self.circleBackColor?.cgColor

        self.layoutElements(selectedChanged: false)
    }
    
    override func prepareForInterfaceBuilder() {
        self.isTranslucent = false
        self.backgroundColor = UIColor.clear
        
        background.fillColor = self.barBackColor?.cgColor
        circle.fillColor = self.circleBackColor?.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
