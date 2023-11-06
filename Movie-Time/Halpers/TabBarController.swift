import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.viewControllers = [UpComingVC(nibName: "UpComingVC", bundle: nil), SearchVC(nibName: "SearchVC", bundle: nil)]
        
        let home = HomeVC(nibName: "HomeVC", bundle: nil)
        let navHome = UINavigationController(rootViewController: home)
        home.title = "Home"
        home.tabBarItem.image = UIImage(systemName: "house")
        
        let upComing = UpComingVC(nibName: "UpComingVC", bundle: nil)
        let navupComing = UINavigationController(rootViewController: upComing)
        upComing.title = "upComing"
        upComing.tabBarItem.image = UIImage(systemName: "heart")
        
        
        let searCh = SearchVC(nibName: "SearchVC", bundle: nil)
        let navSearCh = UINavigationController(rootViewController: searCh)
        searCh.title = "search"
        searCh.tabBarItem.image = UIImage(systemName: "target")
        
        tabBar.tintColor = .black
        self.setViewControllers([navHome, navupComing ,navSearCh], animated: true)
    }
}




