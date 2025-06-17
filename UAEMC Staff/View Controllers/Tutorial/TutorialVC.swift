import UIKit
import JXPageControl

class TutorialVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: JXPageControlExchange!
    
    //MARK: Variables
    
    var slides: [SlideView] = []
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfiguration()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Functions
    
    func setupConfiguration() {
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        view.bringSubviewToFront(pageControl)
    }
    
    func createSlides() -> [SlideView] {
        let slideOne = SlideView()
        slideOne.imageView.image = UIImage(named: "Attendance Large")
        slideOne.labelTitle.text = "Attendance with Geofencing"
        slideOne.labelDesc.text = "Explore the new Era of Automated \nAttendance System with \nGeofensing"
        
        let slideTwo = SlideView()
        slideTwo.imageView.image = UIImage(named: "Report")
        slideTwo.labelTitle.text = "Reports and Calendars"
        slideTwo.labelDesc.text = "Interactive Reports and Calendar \nAvailable for ESS, MSS and \nAdmin Users"
        
        let slideThree = SlideView()
        slideThree.imageView.image = UIImage(named: "Workflow")
        slideThree.labelTitle.text = "Dynamic Workflow"
        slideThree.labelDesc.text = "Dynamic Workflow for Leaves, \nPermissions,Manual entery and \nOvertime"
        
        let slideFour = SlideView()
        slideFour.imageView.image = UIImage(named: "Access")
        slideFour.labelTitle.text = "Role based Access"
        slideFour.labelDesc.text = "Modules and Features are \nConfigured Based on \nUser Roles "
        
        return [slideOne, slideTwo, slideThree, slideFour]
    }
    
    func setupSlideScrollView(slides : [SlideView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func moveToNextScreen() {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func navigateToRegister() {
        if let registerVC = UAEMCBundleResources.vcWithName(name: "RegisterVC") {
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
    //MARK: IBActions
    
    @IBAction func skipTapped(_ sender: UIButton) {
        navigateToRegister()
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        self.moveToNextScreen()
        if scrollView.contentOffset.x < self.view.bounds.width * CGFloat(slides.count - 1) {
            scrollView.contentOffset.x +=  self.view.bounds.width
        } else {
            navigateToRegister()
        }
    }
}
