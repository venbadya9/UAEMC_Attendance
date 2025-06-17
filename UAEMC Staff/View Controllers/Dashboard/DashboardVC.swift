import UIKit
import DGCharts
import WMSegmentControl

class DashboardVC: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var segmentedControl: WMSegment!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    
    var isCalendarVisisble: Bool = false
    var calendarView: CalendarStaffView!
    
    //MARK: Constants
    
    let leaveType = ["Leave Days", "Violation Days", "Absent Days"]
    let leavePercent = [35.0, 45.0, 20.0]
    
    let leaveImages = [#imageLiteral(resourceName: "Leave Days"), #imageLiteral(resourceName: "Violation Days"), #imageLiteral(resourceName: "Absent Days"), #imageLiteral(resourceName: "Remote Days")]
    let leaves = ["Leave Days  0.0%", "Violation Days  0.0%", "Absent Days  0.0%", "Remote Days  0.0%"]
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        setup(pieChartView: chartView)
        chartView.entryLabelColor = .white
        chartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        
        headerView.headerLabel.text = "Dashboard"
        headerView.delegate = self
        headerView.backButton.isHidden = false
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.SelectedFont = UIFont(name: "Poppins-SemiBold", size: 12.0)!
        segmentedControl.normalFont = UIFont(name: "Poppins-SemiBold", size: 12.0)!
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 11.0)!])
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        calendarView = CalendarStaffView(frame: CGRect(x: 25, y: 235, width: self.view.frame.size.width - 50, height: 340))
        self.view.addSubview(calendarView)
        calendarView.alpha = 0
    }
    
    func setup(pieChartView chartView: PieChartView) {
        chartView.usePercentValuesEnabled = false
        chartView.drawEntryLabelsEnabled = false
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.3
        chartView.transparentCircleRadiusPercent = 0
        chartView.chartDescription.enabled = false
        chartView.isUserInteractionEnabled = false

        chartView.drawCenterTextEnabled = true
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let legend = chartView.legend
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        legend.form = .circle
        legend.formSize = 11
        legend.orientation = .horizontal
        legend.font = UIFont(name: "Poppins-Regular", size: 10.0)!
        legend.textColor = .theme
        
        self.setDataCount(3, range: 100)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: leavePercent[i],
                                     label: leaveType[i])
        }
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        set.valueTextColor = .clear
        
        set.colors = [UIColor.theme, UIColor.lighterTheme, UIColor.fadedTheme]
        
        let data = PieChartData(dataSet: set)
        chartView.data = data
    }
    
    //MARK: IBActions
    
    @IBAction func dateTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.calendarView.alpha = self.isCalendarVisisble ?  0 : 1
        }, completion: nil)
        
        self.isCalendarVisisble.toggle()
    }
}
