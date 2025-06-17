import UIKit

//MARK: Protocol

protocol HeaderDelegate {
    func backBtnTapped()
    func notificationBtnTapped()
    func menuBtnTapped()
}

class HeaderView: UIView {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    //MARK: Varibales
    
    var delegate: HeaderDelegate!
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    //MARK: IBActions
    
    @IBAction func backTapped(_ sender: UIButton) {
        delegate.backBtnTapped()
    }
    
    @IBAction func notification(_ sender: UIButton) {
        delegate.notificationBtnTapped()
    }
    
    @IBAction func menuTapped(_ sender: UIButton) {
        delegate.menuBtnTapped()
    }
}

extension HeaderView {
    
    //MARK: Methods
    
    func configureView() {
        guard let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self)?.first as? UIView else { return }
        self.addSubview(headerView)
        headerView.frame = self.bounds
    }
}
