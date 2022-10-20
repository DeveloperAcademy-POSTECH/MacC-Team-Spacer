//
//  RequestViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class RequestViewController: UIViewController {

    lazy var button : UIButton = {
        let button = UIButton()
        let width: CGFloat = 200
        let height: CGFloat = 80
        let posX: CGFloat = self.view.bounds.width/2 - width/2
        let posY: CGFloat = self.view.bounds.height/2 - height/2
        
        button.frame = CGRect(x: posX, y: posY, width: width, height: height)
        button.backgroundColor = .black
        
        button.setTitle("testForModal", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        
        button.addTarget(self, action: #selector(buttonTest(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonTest(_ sender: Any) {
        if sender is UIButton{
            let vc = UINavigationController(rootViewController: VisualTagCalendarViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }

}
