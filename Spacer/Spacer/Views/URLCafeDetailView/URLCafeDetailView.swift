//
//  URLCafeDetailView.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/12/08.
//

import UIKit

class URLCafeDetailView: UIViewController {
    // FavoriteView로부터 전달받은 카페 데이터
    var urlCafeData: FavoriteURLCafeInfo?
   
    // MARK: -- UI Components
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var cafeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .mainPurple5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        imageView.image = UIImage(named: "LocationIcon")
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
        label.numberOfLines = 0
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
        button.addTarget(self, action: #selector(touchedReservationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -- View Life Sycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
        
        setNavigationBar()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBottomBar()
        setScrollView()
        setScrollViewContent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let gradientLayer = CAGradientLayer()
        cafeLinkButton.addGradient(with: gradientLayer, colorSet: UIColor.gradient1, locations: [0.0, 1.0], startEndPoints: (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5)), layerAt: 0)
    }
    
    // MARK: -- Functions
    
    private func setNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .done, target: self, action: #selector(touchedNavigationBarBackButton))
        navigationItem.leftBarButtonItem = backIcon
        navigationItem.leftBarButtonItem?.tintColor = UIColor.mainPurple1
    }
    
    private func setScrollView() {
        // scrollView와 scrollView의 내부 뷰들을 담을 containerView 생성 및 뷰에 그리기
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        let contentContainerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentContainerViewConstraints)
    }
    
    private func setScrollViewContent() {
        // containerView에 scrollView에 담을 뷰 그리기
        Task {
            let url = URL(string: urlCafeData!.cafeImageURL)
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            cafeImage.image = UIImage(data: data)
        }
        cafeNameLabel.text = urlCafeData?.cafeName
        locationLabel.text = urlCafeData?.cafeAddress
        userMemo.text = urlCafeData?.memo
        
        containerView.addSubview(cafeImage)
        containerView.addSubview(cafeNameUnberLine)
        containerView.addSubview(cafeNameLabel)
        containerView.addSubview(locationIcon)
        containerView.addSubview(locationLabel)
        containerView.addSubview(userMemoContainer)
        containerView.addSubview(userMemo)
        
        let cafeImageConstraints = [
            cafeImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            cafeImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cafeImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cafeImage.widthAnchor.constraint(equalToConstant: view.bounds.width),
            cafeImage.heightAnchor.constraint(equalToConstant: view.bounds.width / 3 * 4)
        ]
        
        let cafeNameLabelConstraints = [
            cafeNameLabel.topAnchor.constraint(equalTo: cafeImage.bottomAnchor, constant: .padding.startHierarchyPadding),
            cafeNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .padding.margin),
            cafeNameLabel.heightAnchor.constraint(equalToConstant: 23)
        ]
        
        let cafeNameUnderLabelConstraints = [
            cafeNameUnberLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .padding.margin),
            cafeNameUnberLine.centerYAnchor.constraint(equalTo: cafeNameLabel.centerYAnchor, constant: 8),
            cafeNameUnberLine.widthAnchor.constraint(equalTo: cafeNameLabel.widthAnchor),
            cafeNameUnberLine.heightAnchor.constraint(equalToConstant: 13)
        ]
        
        let locationIconConstraints = [
            locationIcon.topAnchor.constraint(equalTo: cafeNameLabel.bottomAnchor, constant: 15),
            locationIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .padding.margin),
            locationIcon.widthAnchor.constraint(equalToConstant: 20),
            locationIcon.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let locationLabelConstraints = [
            locationLabel.bottomAnchor.constraint(equalTo: locationIcon.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 4),
            locationLabel.heightAnchor.constraint(equalToConstant: 17)
        ]
        
        let userMemoContainerConstraints = [
            userMemoContainer.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: .padding.margin),
            userMemoContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            userMemoContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .padding.margin),
            userMemoContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.padding.margin),
            userMemoContainer.heightAnchor.constraint(equalToConstant: userMemo.intrinsicContentSize.height + 40)
        ]
        
        let userMemoConstraints = [
            userMemo.topAnchor.constraint(equalTo: userMemoContainer.topAnchor, constant: 20),
            userMemo.bottomAnchor.constraint(equalTo: userMemoContainer.bottomAnchor, constant: -20),
            userMemo.leadingAnchor.constraint(equalTo: userMemoContainer.leadingAnchor, constant: 20),
            userMemo.trailingAnchor.constraint(equalTo: userMemoContainer.trailingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(cafeImageConstraints)
        NSLayoutConstraint.activate(cafeNameLabelConstraints)
        NSLayoutConstraint.activate(cafeNameUnderLabelConstraints)
        NSLayoutConstraint.activate(locationIconConstraints)
        NSLayoutConstraint.activate(locationLabelConstraints)
        NSLayoutConstraint.activate(userMemoContainerConstraints)
        NSLayoutConstraint.activate(userMemoConstraints)
    }
    
    private func setBottomBar() {
        view.addSubview(bottomBar)
        view.addSubview(cafeLinkButton)
        
        let bottomBarConstraints = [
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 98)
        ]
        
        let cafeLinkButtonConstraints = [
            cafeLinkButton.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8),
            cafeLinkButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: .padding.margin),
            cafeLinkButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -.padding.margin),
            cafeLinkButton.heightAnchor.constraint(equalToConstant: 56)
        ]
        
        NSLayoutConstraint.activate(bottomBarConstraints)
        NSLayoutConstraint.activate(cafeLinkButtonConstraints)
    }
    
    @objc private func touchedNavigationBarBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func touchedReservationButton(_ sender: UIButton) {
        guard let urlResource: String = urlCafeData?.cafeURL else { return }
        
        if let url = URL(string: urlResource), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
