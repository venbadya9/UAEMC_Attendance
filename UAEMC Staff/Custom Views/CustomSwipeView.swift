import UIKit

class CustomSwipeView: UIView {

    //MARK: Variables
    
    var button: UIButton!
    var imageView: UIImageView!
    let inImage = UIImage(named: "In")
    let outImage = UIImage(named: "Out")
    var initialPosition: CGPoint!
    
    //MARK: Constants
    
    let imageWidth = 108.0
    let imagePadding = 20.0
    let imageHeight = 24.0
    let viewPadding = 10.0
    
    // MARK: Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    //MARK: Private Functions
    
    private func setupView() {
        imageView = UIImageView(frame: CGRect(x: self.frame.width - imageWidth - imagePadding, y: 16.0, width: imageWidth, height: imageHeight))
        imageView.contentMode = .scaleAspectFit
        imageView.image = inImage
        addSubview(imageView)

        button = UIButton(frame: CGRect(x: 5.0, y: 5.0, width: 127.0, height: 46.0))
        button.setTitle("In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16.0)
        button.backgroundColor = UIColor(hexaRGB: "#DBCDB8")
        button.layer.cornerRadius = 20.0
        addSubview(button)
        
        self.layer.cornerRadius = 28.0
        initialPosition = button.center
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        button.addGestureRecognizer(panGesture)
    }
    
    //MARK: Pan Gesture Method
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let vel = gesture.velocity(in: gesture.view)
        
        switch gesture.state {
        case .began:
            initialPosition = gesture.view?.center
            
        case .changed:
            if (initialPosition.x + button.frame.width/2) < self.frame.width - viewPadding {
                if vel.x > 0 && translation.x > 0 {
                    button.center = CGPoint(x: (button.frame.width/2) - 5.0 + min(abs(translation.x), self.frame.width - self.button.frame.size.width), y: button.center.y)
                } else if button.frame.origin.x > 0 && button.frame.origin.x + 132.0 < self.frame.width {
                    button.center = CGPoint(x: translation.x, y: button.center.y)
                }
            } else if initialPosition.x > (button.frame.width/2) + 5 {
                if vel.x < 0 && translation.x < 0 {
                    button.center = CGPoint(x: initialPosition.x + viewPadding - min(abs(translation.x), self.frame.width - self.button.frame.size.width), y: button.center.y)
                } else {
                    button.center = CGPoint(x: initialPosition.x, y: button.center.y)
                }
            }
            
        case .ended, .cancelled:
            let swipeProgress = abs(translation.x) / self.bounds.width
            
            if swipeProgress > 0.4 {
                if translation.x > 0 {
                    self.imageView.image = self.outImage
                    self.animateButton(to: CGPoint(x: self.frame.width - 5.0 - self.button.bounds.width / 2, y: self.button.center.y))
                    self.imageView.removeAllConstraints()
                    self.imageView.frame = CGRect(x: imagePadding, y: 16.0, width: imageWidth, height: 24.0)
                    self.button.setTitle("Out", for: .normal)
                    self.button.backgroundColor = UIColor(hexaRGB: "#CDA262")
                    
                } else {
                    imageView.image = inImage
                    animateButton(to: CGPoint(x: button.bounds.width / 2 + 5.0, y: button.center.y))
                    self.imageView.frame = CGRect(x: self.frame.width - imageWidth - imagePadding, y: 16.0, width: imageWidth, height: imageHeight)
                    self.button.setTitle("In", for: .normal)
                    button.backgroundColor = UIColor(hexaRGB: "#DBCDB8")
                }
            } else {
                animateButton(to: initialPosition)
            }
            
        default:
            break
        }
    }
    
    // MARK: Methods
    
    func animateButton(to position: CGPoint) {
        UIView.animate(withDuration: 0.3, animations: {
            self.button.center = position
        })
    }
}
