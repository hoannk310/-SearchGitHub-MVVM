//
//  TabbarControllerViewController.swift
//  SearchRepositories+Mvvm
//
//  Created by Apple on 3/2/21.
//

import UIKit
import RealmSwift
class TabbarControllerViewController: UITabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navRepo = generateNav(vc: MainViewController(), title: "Hero", image: UIImage(systemName: "cylinder.split.1x2")!, selectedImage: UIImage(systemName: "cylinder.split.1x2.fill")!)
        let navUser = generateNav(vc: SearchUserViewController(), title: "Player", image: UIImage(systemName: "person.circle")!, selectedImage: UIImage(systemName: "person.circle.fill")!)
        let navFavorite = generateNav(vc: FavoriteViewController(), title: "Favorite Hero", image: UIImage(systemName: "suit.heart")!, selectedImage: UIImage(systemName: "suit.heart.fill")!)
     viewControllers = [navRepo,navUser,navFavorite]
        
        let real = try! Realm()
        print(real.configuration.fileURL!.path)
    }
    
    fileprivate func generateNav(vc: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return navController
    }

 
    }
    


