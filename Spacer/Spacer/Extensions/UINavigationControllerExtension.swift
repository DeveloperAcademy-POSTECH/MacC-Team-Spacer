//
//  UINavigationControllerExtension.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/23.
//

import UIKit

// NavigationBar를 hidden처리하면서 기본으로 제공하는 swipe하여 뒤로가기 기능 사라짐
// -> navigationStack에 view가 1개 보다 많을 경우 interactivePopGestureRecognizer를 인식하여 동작
extension UINavigationController: UIGestureRecognizerDelegate {
    public func interactivePopIsEnable(_ bool: Bool) {
        if bool == true {
            interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
