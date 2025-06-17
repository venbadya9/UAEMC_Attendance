import UIKit
import WMSegmentControl

class SelfServiceVC: UIViewController {
    
    //MARK: IBOutelts
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: WMSegment!
    @IBOutlet weak var headerView: HeaderView!
    
    //MARK: Variables
    
    var isCalendarVisisble: Bool = false
    var calendarView: CalendarStaffView!
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        searchView.layer.borderColor = UIColor(hexaRGB: "#976F33", alpha: 1.0)?.cgColor
        searchView.layer.borderWidth = 1.0
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search Date",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 11.0)!]
        )
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.SelectedFont = UIFont(name: "Poppins-SemiBold", size: 12.0)!
        segmentedControl.normalFont = UIFont(name: "Poppins-SemiBold", size: 12.0)!
        
        headerView.headerLabel.text = "Self Services"
        headerView.delegate = self
        headerView.backButton.isHidden = false
        
        calendarView = CalendarStaffView(frame: CGRect(x: 25, y: 235, width: self.view.frame.size.width - 50, height: 340))
        self.view.addSubview(calendarView)
        calendarView.alpha = 0
    }
    
    //MARK: IBActions
    
    @IBAction func dateTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.calendarView.alpha = self.isCalendarVisisble ?  0 : 1
        }, completion: nil)
        
        self.isCalendarVisisble.toggle()
    }
}
