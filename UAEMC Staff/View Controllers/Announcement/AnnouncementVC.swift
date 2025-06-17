import UIKit
import DropDown

class AnnouncementVC: UIViewController {

    //MARK: IBOutlets
    
    @IBOutlet weak var selectAll: UISwitch!
    @IBOutlet weak var periodDay: UISwitch!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet var buttons : [UIButton]!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var salutation: UIView!
    @IBOutlet weak var salutationLabel: UILabel!
    @IBOutlet weak var employee: UIView!
    @IBOutlet weak var employeeLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: Variables
    
    var selectedButton = 0
    var isCalendarVisisble: Bool = false
    var calendarView: CalendarStaffView!
    
    //MARK: Constants
    
    let chooseSalutationDropDown = DropDown()
    let chooseEmployeeDropDown = DropDown()
    let chooseTitleDropDown = DropDown()
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    //MARK: Methods
    
    func setupConfiguration() {
        selectAll.set(width: 24.0, height: 14.0)
        periodDay.set(width: 24.0, height: 14.0)
        
        buttons[selectedButton].isSelected = true
        
        cancelBtn.layer.borderColor = UIColor.theme.cgColor
        cancelBtn.layer.borderWidth = 1.0
        
        headerView.headerLabel.text = "Announcments"
        headerView.delegate = self
        headerView.backButton.isHidden = false
        
        chooseSalutationDropDown.anchorView = salutation
        chooseEmployeeDropDown.anchorView = employee
        chooseTitleDropDown.anchorView = titleView
        
        contentTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter Content",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: 11.0)!]
        )
        
        DropDown.appearance().cornerRadius = 10.0
        
        calendarView = CalendarStaffView(frame: CGRect(x: 20, y: 150, width: self.view.frame.size.width - 40, height: 340))
        self.view.addSubview(calendarView)
        calendarView.alpha = 0
    }
    
    //MARK: IBActions
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let tag = sender.tag
        buttons[selectedButton].isSelected = false
        buttons[tag].isSelected = true
        selectedButton = tag
    }
    
    @IBAction func chooseSalutation(_ sender: UIButton) {
        chooseSalutationDropDown.bottomOffset = CGPoint(x: 0, y: salutation.bounds.height)
        chooseSalutationDropDown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        chooseSalutationDropDown.selectionAction = { [weak self] (index, item) in
            self?.salutationLabel.text = item
        }
        chooseSalutationDropDown.show()
    }
    
    @IBAction func chooseEmployees(_ sender: UIButton) {
        chooseEmployeeDropDown.bottomOffset = CGPoint(x: 0, y: salutation.bounds.height)
        chooseEmployeeDropDown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        chooseEmployeeDropDown.selectionAction = { [weak self] (index, item) in
            self?.employeeLabel.text = item
        }
        chooseEmployeeDropDown.show()
    }
    
    @IBAction func chooseTitle(_ sender: UIButton) {
        chooseTitleDropDown.bottomOffset = CGPoint(x: 0, y: salutation.bounds.height)
        chooseTitleDropDown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        chooseTitleDropDown.selectionAction = { [weak self] (index, item) in
            self?.titleLabel.text = item
        }
        chooseTitleDropDown.show()
    }
    
    @IBAction func dateTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.calendarView.alpha = self.isCalendarVisisble ?  0 : 1
        }, completion: nil)
        
        self.isCalendarVisisble.toggle()
    }
}
