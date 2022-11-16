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
        
        let birthdayCafeViewController = UINavigationController(rootViewController: BirthdayCafeViewController())
        let MyPageViewController = UINavigationController(rootViewController: MyPageViewController())
        
        // 선택되었을 경우 색상
        self.tabBar.tintColor = .mainPurple3
        
        // tabBar가 선택되지 않았을 때의 색상
        self.tabBar.unselectedItemTintColor = .mainPurple3
        
        // tabBar 기본 배경색
        tabBar.backgroundColor = .white
        
        // tabBar shadow 세팅
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 0
        
        
        let birthdayCafeViewControllerTabBarItem = UITabBarItem(title: "생일카페", image:  UIImage(named: "BirthdayCafe_Outline")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "BirthdayCafe_Fill")?.withRenderingMode(.alwaysOriginal))
        birthdayCafeViewController.tabBarItem = birthdayCafeViewControllerTabBarItem
        
        let MyPageViewControllerTabBarItem = UITabBarItem(title: "내 정보", image: UIImage(named: "MyPage_Outline")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "MyPage_Fill")?.withRenderingMode(.alwaysOriginal))
        MyPageViewController.tabBarItem = MyPageViewControllerTabBarItem
        
        setViewControllers([birthdayCafeViewController, MyPageViewController], animated: true)
    }
    
}
