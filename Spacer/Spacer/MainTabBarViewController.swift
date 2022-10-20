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
        

        let vc1 = UINavigationController(rootViewController: BirthdayCafeViewController())
        let vc2 = UINavigationController(rootViewController: RequestViewController())
        let vc3 = UINavigationController(rootViewController: ChatViewController())
        let vc4 = UINavigationController(rootViewController: MyPageViewController())
        
        vc1.title = "생일카페"
        vc2.title = "카페 구하기"
        vc3.title = "채팅"
        vc4.title = "내 정보"
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)

        
    }


}

