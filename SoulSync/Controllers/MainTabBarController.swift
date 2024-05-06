import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create view controllers
        let homeVC = HomeVC()
        let searchVC = SearchVC()
        let addPostVC = AddPostVC()
        let mapVC = MapVC()
        let profileVC = ProfileVC()

        // Set view controllers for the tab bar controller
        viewControllers = [homeVC, searchVC, addPostVC, mapVC, profileVC]
        
        // Customize tab bar items
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_home_selected")?.withRenderingMode(.alwaysOriginal))
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_search")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_search_selected")?.withRenderingMode(.alwaysOriginal))
        addPostVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_add")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_add_selected")?.withRenderingMode(.alwaysOriginal))
        mapVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_map")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_map_selected")?.withRenderingMode(.alwaysOriginal))
        profileVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_user")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ic_user_selected")?.withRenderingMode(.alwaysOriginal))
    }
}
