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
        
        configureTabBarAppearance()
    }
    
    private func configureTabBarAppearance() {
               // Customize the appearance of the tab bar based on system theme
               if #available(iOS 13.0, *) {
                   let tabBarAppearance = UITabBarAppearance()
                   tabBarAppearance.configureWithOpaqueBackground()
                   
                   // Set colors for both light and dark modes
                   tabBarAppearance.backgroundColor = UIColor { traitCollection in
                       switch traitCollection.userInterfaceStyle {
                           case .dark:
                               return .black // Background color for dark mode
                           default:
                               return .white // Background color for light mode
                       }
                   }

                   // Apply the appearance settings to the tab bar
                   tabBar.standardAppearance = tabBarAppearance
                   tabBar.scrollEdgeAppearance = tabBar.standardAppearance
               } else {
                   // Fallback on earlier versions: manually set for light theme only
                   tabBar.barTintColor = .white // Background color for iOS 12 and below
               }
           }
}
