//
//  CafeReview.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/18.
//

import UIKit

class CafeReviewViewController: UIViewController {
    // 리뷰 목록을 보여주는 ViewController
    
    // 뷰가 준비중임을 나타내는 이미지
    private lazy var underConstructionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cafeReviewViewUnderConstruction")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(underConstructionImage)
        
        let underConstructionImageConstraints = [
            underConstructionImage.topAnchor.constraint(equalTo: view.topAnchor, constant: .padding.startHierarchyPadding),
            underConstructionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            underConstructionImage.widthAnchor.constraint(equalToConstant: 256),
            underConstructionImage.heightAnchor.constraint(equalToConstant: 102)
        ]
        NSLayoutConstraint.activate(underConstructionImageConstraints)
    }
    
}
