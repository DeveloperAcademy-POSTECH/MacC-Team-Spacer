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
   
    // MARK: -- UI 요소
    
    private lazy var cafeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cafeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .header1_2)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cafeNameUnberLine: UIView = {
        let view = UIView()
        view.backgroundColor = .subYellow1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .body3)
        label.textColor = .grayscale2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userMemoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPurple6
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var userMemo: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cafeLinkButton: UIButton = {
        let button = UIButton()
        button.setTitle("카페 보러가기", for: .normal)
        button.titleLabel?.font = .systemFont(for: .header1_3)
        button.titleLabel?.textColor = .grayscale7
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
