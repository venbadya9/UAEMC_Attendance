import UIKit

//MARK: UIScrollViewDelegate

extension TutorialVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.moveToNextScreen()
    }
}
