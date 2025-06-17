import UIKit
import MapKit

class AttendanceVC: BaseVC {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var swipeView: CustomSwipeView!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var inTimeLabel: UILabel!
    @IBOutlet weak var outTimeLabel: UILabel!
    @IBOutlet weak var workingHours: UILabel!
    @IBOutlet weak var workingStatus: UILabel!
    @IBOutlet weak var workModeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _swipeView = swipeView
        _progressView = progressView

        delegate = self
        setupConfiguration()
        setup()
    }
    
    //MARK: Methods
    
    func setup() {
        headerView.headerLabel.text = "Attendance"
        headerView.delegate = self
        headerView.backButton.isHidden = false
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy, h:mm a"
        dateTimeLabel.text = formatter.string(from: now)
    }
}
