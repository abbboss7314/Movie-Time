import UIKit
import WebKit

class UpComingPlayVideo: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieInfo: UITextView!
    
    var url: String = ""
    var moviename: String = ""
    var movieinfo: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
       
        guard let urll = URL(string: "https://www.youtube.com/embed/" + self.url) else { return }
        webView.load(URLRequest(url: urll))
        
        movieName.text = moviename
        movieInfo.text = movieinfo
        
    }
    
    func loadUrl(url: String) {
        
    }
}


extension UpComingPlayVideo: WKUIDelegate, WKNavigationDelegate {
    
}
