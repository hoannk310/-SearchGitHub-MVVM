import UIKit
import Alamofire

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "shouldShowWebView") {
            showWebView(url: "https://kubet.gg/")
            return
        }
        
        showMain()
    }
    
    private func showMain() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UserDefaults.standard.set(true, forKey: "shouldShowWebView")
            let chatVC = TabbarControllerViewController(nibName: "TabbarControllerViewController", bundle: nil)
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
    
    private func showWebView(url: String) {
//        DispatchQueue.main.async {
            let webVC = WebViewController(nibName: "WebViewController", bundle: nil)
            webVC.navigationHidden = true
            webVC.url = URL(string: url)!
            self.navigationController?.pushViewController(webVC, animated: true)
//        }
    }
}
