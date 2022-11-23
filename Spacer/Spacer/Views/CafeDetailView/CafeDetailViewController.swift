//
//  CafeDetailViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    // TODO: 이미지 받아오는 데 성공하면 해당 변수 삭제 필요
    var tempCafeInfo: CafeInfo? = MockManager.shared.getMockData()[0]
    
    // 서버에서 받아온 카페 기본 정보
    var cafeData: Cafeinfo?
    
    // MARK: - UI 요소
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var dynamicStackView: UIStackView = {
        let dynamicStackView = UIStackView(arrangedSubviews: [])
        dynamicStackView.alignment = .center
        dynamicStackView.axis = .vertical
        dynamicStackView.translatesAutoresizingMaskIntoConstraints = false
        return dynamicStackView
    }()
    
    // 카페 이미지를 보기 위한 ScrollView
    lazy var imageScrollView: UIScrollView = {
        // ScrollView와 내부 Content Size 정의
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 3 * 4))
        
        // 스크롤 인디케이터 삭제
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // 스크롤 할 때 페이징이 가능하도록 설정
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        return scrollView
    }()
    
    // 카페의 이미지에 대한 설명을 담을 뷰
    lazy var imageDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainPurple1.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
       let label = UILabel()
        label.textColor = .grayscale7
        label.font = .systemFont(for: .body3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainPurple5
        label.font = .systemFont(for: .caption)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cafeTitleLabel: UILabel = {
        let label = UILabel()
        // TODO: 나중에 추가된 커스텀 폰트로 교체해야함
        label.font = .systemFont(for: .header1_2)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cafeTitleUnderLine: UIView = {
        let view =  UIView()
        view.backgroundColor = .subYellow1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var favortieImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "heartIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var numberOfFavorties: UILabel = {
        let label = UILabel()
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var callReservationButton: UIButton = {
       let button = UIButton()
        button.setTitle("전화 문의하기", for: .normal)
        button.titleLabel?.font = .systemFont(for: .header6)
        button.titleLabel?.textColor = .grayscale7
        button.backgroundColor = .grayscale2
        button.layer.cornerRadius = 12
        button.tag = 100
        button.addTarget(self, action: #selector(touchedReservationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    // 상세정보와 리뷰 페이지를 위한 segmentedControl
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = CustomSegmentControl(items: ["상세정보", "리뷰"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(changePageControllerViewController(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    // ViewController를 표시할 pageController
    lazy var pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageController.setViewControllers([dataViewControllers[0]], direction: .forward, animated: true)
        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    // 하단에 고정할 버튼을 담을 View
    let bottomBar: UIView = {
        let bottomBar = UIView()
        bottomBar.backgroundColor = UIColor.white
        bottomBar.layer.borderWidth = 1
        bottomBar.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0)
        bottomBar.layer.masksToBounds = false
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        bottomBar.layer.shadowOpacity = 0.25
        bottomBar.layer.shadowRadius = 4.0
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        return bottomBar
    }()
    
    let favoriteOnOffButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heartIcon")?.withTintColor(.grayscale4), for: .normal)
        button.backgroundColor = .mainPurple6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.mainPurple5.cgColor
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(touchedFavoriteOnOffButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("예약하러 가기", for: .normal)
        button.titleLabel?.font = .systemFont(for: .header1_3)
        button.titleLabel?.textColor = .grayscale7
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.tag = 101
        button.addTarget(self, action: #selector(touchedReservationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 추후 segmentedControl에 추가할 ViewController 정의
    var detailInfoView: DetailInfomationViewController = {
        let viewController = DetailInfomationViewController()
        return viewController
    }()
    
    let reviewView: CafeReviewViewController = {
        let viewController = CafeReviewViewController()
        return viewController
    }()
    
    var dataViewControllers: [UIViewController] {
        [detailInfoView, reviewView]
    }
    
    private var totalImageCount = 0
    private var categoryNames = [String]()
    private var sizeDescriptions = [String]()
    private var isFavoriteButtonOn = false
    private let navigationAppearance = UINavigationBarAppearance()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigationBar & tabBar 설정
        navigationAppearance.configureWithTransparentBackground()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        navigationController?.navigationBar.tintColor = .mainPurple1
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        detailInfoView.cafeInfoData = tempCafeInfo
        detailInfoView.cafeBasicInfo = cafeData
        
        // scrollView의 topAnchor가 안전영역 끝쪽에 붙도록
        scrollView.contentInsetAdjustmentBehavior = .never
        
        // 카페 이미지 보여주기
        setCafeImages(width: view.bounds.width, cafeImageInfos: tempCafeInfo!.imageInfos)
        
        // 이미지별 카테고리와 사이즈 라벨 초기화
        setImageDescriptionView(categoryName: tempCafeInfo?.imageInfos[0].category ?? "", tempImageNumber: 1, numberOfImages: totalImageCount, sizeDescription: tempCafeInfo?.imageInfos[0].productSize ?? "")
        
        // callReservationButton과 reservationButton 세팅
        setIfButtonDisable()
        
        // 카페 이름과 좋아요 수 설정
        if let cafeName = cafeData?.cafeName {
            cafeTitleLabel.text = cafeName
        }
        numberOfFavorties.text = "\(cafeData?.numberOfFavorites ?? 0)"
        
        // view.addSubview
        view.addSubview(scrollView)
        view.addSubview(bottomBar)
        bottomBar.isHidden = true
        
        // scrollView.addSubView
        scrollView.addSubview(dynamicStackView)
        scrollView.addSubview(imageScrollView)
        scrollView.addSubview(imageDescriptionView)
        scrollView.addSubview(segmentedControl)
        
        imageDescriptionView.addSubview(categoryLabel)
        imageDescriptionView.addSubview(sizeLabel)
        
        
        scrollView.addSubview(cafeTitleUnderLine)
        scrollView.addSubview(cafeTitleLabel)
        scrollView.addSubview(favortieImage)
        scrollView.addSubview(numberOfFavorties)
        scrollView.addSubview(callReservationButton)
        
        // dynamicStackView.addArrangedSubview
        dynamicStackView.addArrangedSubview(pageController.view)
        
        // bottomBar View에 버튼 추가
        bottomBar.addSubview(favoriteOnOffButton)
        bottomBar.addSubview(reservationButton)
        
        applyConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // reservationButton의 터치가 가능할 때 그라디언트 백그라운드 레이어 추가
        if reservationButton.isUserInteractionEnabled == true {
            let gradientLayer = CAGradientLayer()
            reservationButton.addGradient(with: gradientLayer, colorSet: UIColor.gradient1, locations: [0.0, 1.0], startEndPoints: (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5)), layerAt: 0)
        }
    }
        
    // MARK: - functions
    
    // segmentControl을 터치하면 아래 PageViewController의 view가 바뀜
    @objc private func changePageControllerViewController(_ sender: UISegmentedControl) {
        pageController.setViewControllers([dataViewControllers[sender.selectedSegmentIndex]], direction: sender.selectedSegmentIndex == 1 ? .forward : .reverse, animated: true)
    }
    
    @objc private func touchedReservationButton(_ sender: UIButton) {
        var urlResource: String?

        switch sender.tag {
        case 100:
            // url을 이용해 연결하기 위해 받아온 전화번호에서 '-' 제거
            guard let cafePhoneNumber = cafeData?.cafePhoneNumber else { return }
            var telURL = ""
            for char in cafePhoneNumber {
                if char != "-" {
                    telURL += String(char)
                }
            }
            urlResource = "tel://\(telURL)"
        case 101:
            urlResource = cafeData?.cafeOpenURL
        default:
            break
        }

        // url 인스턴스를 만들고, canOpenURL 메서드를 이용해 앱을 사용할 수 있는지 확인
        if let url = URL(string: urlResource ?? ""), UIApplication.shared.canOpenURL(url) {
            // 사용 가능할 경우 url 인스턴스를 열어 연결
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // favortieOnOffButton 터치 시 하트 이미지와 전체 하트 수에 변화
    @objc private func touchedFavoriteOnOffButton(_ sender: UIButton) {
        isFavoriteButtonOn.toggle()
        if isFavoriteButtonOn {
            sender.setImage(UIImage(named: "heartIcon"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "heartIcon")?.withTintColor(.grayscale4), for: .normal)
        }
        // TODO: 서버 연결 후 버튼 터치 시 numberOfFavorites에 업데이트 필요
    }
    
    func setCafeImages(width: CGFloat, cafeImageInfos: [ImageInfo]) {
        Task {
            // TODO: url이 임의가 아닌 현재 카페의 cafeID로 변경되어야 함
            let imageInfos = try await APICaller.requestGetData(url: "/static/getImages/f7c51eda64af11ed94ba0242ac110003", dataType: [CafeThumbnailImage].self) as! [CafeThumbnailImage]
            
            for info in imageInfos {
                totalImageCount += 1
                
                // 불러온 이미지 주소를 데이터로 저장
                guard let url = URL(string: info.cafeImageUrl) else {
                    print("Can't create image url")
                    return
                }
                let data = try! Data(contentsOf: url)
                
                // 각 이미지를 imageScrollView에 추가
                let cafeImage = UIImageView()
                cafeImage.image = UIImage(data: data)
                cafeImage.contentMode = .scaleAspectFill
                cafeImage.clipsToBounds = true
                cafeImage.frame = CGRect(x: CGFloat(imageIndex - 1) * width, y: 0, width: width, height: width / 3 * 4)
                
                imageScrollView.addSubview(cafeImage)
                
                // imageScrollView에서 이미지가 넘어갈 때마다 카테고리, 사이즈 정보를 활용할 수 있도록 배열에 추가
                categoryNames.append(info.imageCategory)
                sizeDescriptions.append(info.imageProductSize)
            }
            
            setImageDescriptionView(categoryName: categoryNames[0], tempImageNumber: 1, numberOfImages: totalImageCount, sizeDescription: sizeDescriptions[0])
            
            // 전체 이미지 수에 따라 imageScrollView의 width 설정
            imageScrollView.contentSize = CGSize(width: CGFloat(totalImageCount) * view.bounds.width, height: 0)
        }
    }
    
    private func setImageDescriptionView(categoryName: String, tempImageNumber: Int, numberOfImages: Int, sizeDescription: String) {
        categoryLabel.text = "\(categoryName) | \(tempImageNumber)/\(numberOfImages)"
        sizeLabel.text = sizeDescription
    }
    
    private func setIfButtonDisable() {
        if cafeData?.cafePhoneNumber == nil || cafeData?.cafePhoneNumber == "" || cafeData?.cafePhoneNumber == " " {
            callReservationButton.backgroundColor = .grayscale5
            callReservationButton.isUserInteractionEnabled = false
        }
        
        if cafeData?.cafeOpenURL == nil || cafeData?.cafeOpenURL == "" {
            reservationButton.backgroundColor = .grayscale5
            reservationButton.isUserInteractionEnabled = false
        }
    }
    
    func applyConstraints() {
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let dynamicContentconstraints = [
            dynamicStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            dynamicStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            dynamicStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            dynamicStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dynamicStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ]
        
        let imageScrollViewConstraints = [
            imageScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        ]
        
        let imageDescriptionViewConstraints = [
            imageDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageDescriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageDescriptionView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor),
            imageDescriptionView.heightAnchor.constraint(equalToConstant: 51)
        ]
        
        let categoryLabelConstraints = [
            categoryLabel.trailingAnchor.constraint(equalTo: imageDescriptionView.trailingAnchor, constant: -.padding.margin),
            categoryLabel.topAnchor.constraint(equalTo: imageDescriptionView.topAnchor, constant: 8),
            categoryLabel.heightAnchor.constraint(equalToConstant: 17)
        ]
        
        let sizeLabelConstraints = [
            sizeLabel.trailingAnchor.constraint(equalTo: imageDescriptionView.trailingAnchor, constant: -.padding.margin),
            sizeLabel.bottomAnchor.constraint(equalTo: imageDescriptionView.bottomAnchor, constant: -8),
            sizeLabel.heightAnchor.constraint(equalToConstant: 14)
        ]
        
        let cafeTitleUnderLineConstraints = [
            cafeTitleUnderLine.leadingAnchor.constraint(equalTo: cafeTitleLabel.leadingAnchor),
            cafeTitleUnderLine.centerYAnchor.constraint(equalTo: cafeTitleLabel.centerYAnchor, constant: 8),
            cafeTitleUnderLine.heightAnchor.constraint(equalToConstant: 13),
            cafeTitleUnderLine.widthAnchor.constraint(equalTo: cafeTitleLabel.widthAnchor)
        ]
        
        let cafeTitleLabelConstraints = [
            cafeTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: .padding.margin), 
            cafeTitleLabel.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: .padding.startHierarchyPadding),
            cafeTitleLabel.heightAnchor.constraint(equalToConstant: 23)
        ]
        
        let favoriteImageConstraints = [
            favortieImage.leadingAnchor.constraint(equalTo: cafeTitleLabel.trailingAnchor, constant: 8),
            favortieImage.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 28),
            favortieImage.widthAnchor.constraint(equalToConstant: 20),
            favortieImage.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let numberOfFavoritesConstraints = [
            numberOfFavorties.leadingAnchor.constraint(equalTo: favortieImage.trailingAnchor, constant: 2),
            numberOfFavorties.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 30),
            numberOfFavorties.heightAnchor.constraint(equalToConstant: 17)
        ]
        
        let callReservationButtonConstraints = [
            callReservationButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: .padding.margin),
            callReservationButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -.padding.margin),
            callReservationButton.topAnchor.constraint(equalTo: cafeTitleLabel.bottomAnchor, constant: 19),
            callReservationButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        
        let bottomBarConstraints = [
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let favoriteOnOffButtonConstraints = [
            favoriteOnOffButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 40) / 5),
            favoriteOnOffButton.heightAnchor.constraint(equalToConstant: 56),
            favoriteOnOffButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: .padding.margin),
            favoriteOnOffButton.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8)
        ]
         
        let reservationButtonConstraints = [
            reservationButton.heightAnchor.constraint(equalToConstant: 56),
            reservationButton.leadingAnchor.constraint(equalTo: favoriteOnOffButton.trailingAnchor, constant: .padding.betweenButtonsPadding),
            reservationButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -.padding.margin),
            reservationButton.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8)
        ]
        
        let segmentControlConstraints = [
            segmentedControl.topAnchor.constraint(equalTo: callReservationButton.bottomAnchor, constant: .padding.startHierarchyPadding),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 34)
        ]
        
        let pageControllerConstraints = [
            pageController.view.leadingAnchor.constraint(equalTo: dynamicStackView.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: dynamicStackView.trailingAnchor),
            pageController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            pageController.view.heightAnchor.constraint(equalToConstant: 1100)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(dynamicContentconstraints)
        NSLayoutConstraint.activate(imageScrollViewConstraints)
        NSLayoutConstraint.activate(imageDescriptionViewConstraints)
        NSLayoutConstraint.activate(cafeTitleUnderLineConstraints)
        NSLayoutConstraint.activate(cafeTitleLabelConstraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(sizeLabelConstraints)
        NSLayoutConstraint.activate(favoriteImageConstraints)
        NSLayoutConstraint.activate(numberOfFavoritesConstraints)
        NSLayoutConstraint.activate(callReservationButtonConstraints)
        NSLayoutConstraint.activate(bottomBarConstraints)
        NSLayoutConstraint.activate(favoriteOnOffButtonConstraints)
        NSLayoutConstraint.activate(reservationButtonConstraints)
        NSLayoutConstraint.activate(segmentControlConstraints)
        NSLayoutConstraint.activate(pageControllerConstraints)
    }
    
}

extension CafeDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 이미지를 스크롤해서 넘기면 해당 이미지의 카테고리와 세부 사이즈 정보, 현재 이미지 번호로 업데이트
        let currentImageNumber = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            setImageDescriptionView(categoryName: categoryNames[currentImageNumber], tempImageNumber: currentImageNumber + 1, numberOfImages: totalImageCount, sizeDescription: sizeDescriptions[currentImageNumber])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 세로방향 스크롤 높이에 따라 navigationBar와 bottom 상태 업데이트
        if scrollView.contentOffset.y >= view.bounds.width / 3 * 2 && bottomBar.isHidden {
            // 카페 이미지를 반 이상 내리면 navigationBar 스타일과 title 지정 및 bottomBar 보이도록 설정
            title = cafeData?.cafeName
            navigationController?.navigationBar.standardAppearance.backgroundColor = .white
            navigationController?.navigationBar.alpha = 0
            bottomBar.isHidden = false
            bottomBar.alpha = 0
            UIView.animate(withDuration: 0.2, animations: { [self] in
                navigationController?.navigationBar.alpha = 0.9
                bottomBar.alpha = 1
            })
        } else if scrollView.contentOffset.y < view.bounds.width / 3 * 2 && !bottomBar.isHidden {
            // 카페 이미지 높이의 반 미만일 때 navigationBar 스타일 및 bottomBar 안보이도록 설정
            UIView.animate(withDuration: 0.2, animations: { [self] in
                navigationController?.navigationBar.alpha = 0
                bottomBar.alpha = 0
            })
            // animation이 동작하는 시간이 지나면 navigationBar와 bottomBar 설정 변경
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [self] in
                navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
                navigationController?.navigationBar.alpha = 1
                title = nil
                bottomBar.isHidden = true
            })
        }
    }
}

extension CafeDetailViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // pageViewController를 오른쪽에서 왼쪽으로 스크롤 할 때 ViewController 변경
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController), index - 1 >= 0 else {
            return nil
        }
        return dataViewControllers[index - 1]
    }
    
    // pageViewController를 왼쪽에서 오른쪽으로 스크롤 할 때 ViewController 변경
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController), index + 1 < dataViewControllers.count else {
            return nil
        }
        return dataViewControllers[index + 1]
    }
    
    // pageViewController 애니메이션이 끝났을 때 segmentdControl의 selectedIndex 변경
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0], let index = dataViewControllers.firstIndex(of: viewController) else {
            return
        }
        segmentedControl.selectedSegmentIndex = index
    }
    
}
