import UIKit

class SlideView: UIView {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
}

extension SlideView {
    
    //MARK: Functions
    
    func configureView() {
        guard let slideView = Bundle.main.loadNibNamed("SlideView", owner: self)?.first as? UIView else { return }
        slideView.frame = self.bounds
        self.addSubview(slideView)
    }
}
