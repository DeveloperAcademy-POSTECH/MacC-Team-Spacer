//
//  ViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/07.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: BirthdayCafeViewController())
        let vc2 = UINavigationController(rootViewController: RequestViewController())
        let vc3 = UINavigationController(rootViewController: MyPageViewController())
        
        // 선택되었을 경우 색상
        self.tabBar.tintColor = .mainPurple3
        
        // tabBar가 선택되지 않았을 때의 색상
        self.tabBar.unselectedItemTintColor = .mainPurple3
        
        let vc1TabBarItem = UITabBarItem(title: "생일카페", image:  UIImage(named: "BirthdayCafe_Outline")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "BirthdayCafe_Fill")?.withRenderingMode(.alwaysOriginal))
        vc1.tabBarItem = vc1TabBarItem
        
        let vc2TabBarItem = UITabBarItem(title: "카페 구하기", image: UIImage(named: "Request_Outline")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "Request_Fill")?.withRenderingMode(.alwaysOriginal))
        vc2.tabBarItem = vc2TabBarItem
        
        let vc3TabBarItem = UITabBarItem(title: "내 정보", image: UIImage(named: "MyPage_Outline")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "MyPage_Fill")?.withRenderingMode(.alwaysOriginal))
        vc3.tabBarItem = vc3TabBarItem
        
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
    
}
