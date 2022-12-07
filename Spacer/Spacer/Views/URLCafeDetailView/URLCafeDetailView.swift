//
//  URLCafeDetailView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/12/08.
//

import UIKit

class URLCafeDetailView: UIViewController {
    // 임시 정보
    let tempImage: String = ""
    let tempTilte: String = "카페 로제"
    let tempLoca: String = "서울 마포구 와우산로 90"
    let tempText: String = "메모 사항이 있다면 이렇게 여기에 뜨게 됩니다\nBody2 텍스트인데 행간이 들어가면 좋을 것 같아용\n메모가 늘어나면 박스도 늘어납니당"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .done, target: self, action: #selector(touchedNavigationBarBackButton))
        navigationItem.leftBarButtonItem = backIcon
        navigationItem.leftBarButtonItem?.tintColor = UIColor.mainPurple1
    }
    
    @objc private func touchedNavigationBarBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
