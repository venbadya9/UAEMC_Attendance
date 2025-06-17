import UIKit

//MARK: Variables

var kMainStoryboardName: String {
    let info = Bundle.main.infoDictionary!
    if let value = info["Storyboard Name"] as? String {
        return value
    } else {
        return "Main"
    }
}

//MARK: Public Class

public class UAEMCBundleResources {
    class func nib(name: String) -> UINib? {
        let nib = UINib(nibName: name, bundle: Bundle.main);
        return nib
    }

    class func mainStoryboard() -> UIStoryboard {
        return storyboard(name: kMainStoryboardName)
    }

    class func storyboard(name: String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard
    }
}

//MARK: Extensions

public extension UAEMCBundleResources {
    class func vcWithName(name: String) -> UIViewController? {
        let storyboard = mainStoryboard()
        let viewController: AnyObject! = storyboard.instantiateViewController(withIdentifier: name)
        return viewController as? UIViewController
    }
    
    class func viewFromNib(nibName: String) -> UIView? {
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil)?.first as? UIView else { return nil }
        return view
    }
}
