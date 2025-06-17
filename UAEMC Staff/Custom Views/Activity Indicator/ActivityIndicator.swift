import UIKit
import NVActivityIndicatorView

public class LoadingIndicator {
    
    //MARK: Variables
    
    private static var indicatorView: UIView?
    
    //MARK: Methods
    
    public class func showLoading() {
        guard let window = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last else { return }
        
        let loadingIndicatorView: NVActivityIndicatorView
        if let existedView = window.subviews.first(where: { $0 is NVActivityIndicatorView }) as? NVActivityIndicatorView {
            loadingIndicatorView = existedView
        } else {
            loadingIndicatorView = NVActivityIndicatorView(frame: .zero)
        }
        
        loadingIndicatorView.frame = CGRect(x: (window.frame.size.width / 2) - 25, y: (window.frame.size.height / 2) - 25, width: 50, height: 50)
        loadingIndicatorView.color = UIColor.theme
        loadingIndicatorView.type = .ballRotateChase
        
        indicatorView = UIView(frame: window.frame)
        indicatorView?.backgroundColor = UIColor.black
        indicatorView?.addSubview(loadingIndicatorView)
        
        window.addSubview(indicatorView!)
        loadingIndicatorView.startAnimating()
        indicatorView = loadingIndicatorView
    }
    
    public class func hideLoading() {
        DispatchQueue.main.async {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    indicatorView?.alpha = 0
                }, completion: { _ in
                    indicatorView?.removeFromSuperview()
                }
            )
        }
    }
}
