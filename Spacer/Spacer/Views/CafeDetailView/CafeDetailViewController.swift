//
//  CafeDetailViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    // 임시 카페 정보
    private let cafeInfos: [CafeInfoForDetailView] = [
        CafeInfoForDetailView(cafeID: 0, cafeName: "카페로제", imageDirectories: ["signature", "bag.fill", "creditcard.fill", "giftcard", "banknote", "dollarsign.circle.fill", "heart.fill"], address: "서울 홍대 어쩌고 저쩌고 106", cafePhoneNumber: "010-7189-8294", SNS: "@gumbee_h", cafeMinPeople: 20, cafeMaxPeople: 50, locationID: 0),
        CafeInfoForDetailView(cafeID: 1, cafeName: "랑카페", imageDirectories: ["banknote", "bag.fill", "creditcard.fill", "giftcard", "signature", "dollarsign.circle.fill", "heart.fill"], address: "부산 어쩌고 저쩌고 11", cafePhoneNumber: "010-0000-8294", SNS: "@eunbi_Han", cafeMinPeople: 30, cafeMaxPeople: 40, locationID: 1)
    ]
    
    private let cafeIndex = 0
    
    // MARK: - UI 요소
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
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
    
    // 카페 이미지를 볼 때 몇번째인지 표시하기 위한 PageControl
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: imageScrollView.bounds.height - 45, width: scrollView.bounds.width, height: 55))
        pageControl.numberOfPages = cafeInfos[cafeIndex].imageDirectories.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(red: 159/255, green: 159/255, blue: 159/255, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    // 카페 이미지를 보기 위한 ScrollView
    lazy var imageScrollView: UIScrollView = {
        // ScrollView와 내부 Content Size 정의
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 4 * 3))
        scrollView.contentSize = CGSize(width: CGFloat(cafeInfos[cafeIndex].imageDirectories.count) * view.bounds.width, height: 0)
        
        // 스크롤 인디케이터 삭제
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // 스크롤 할 때 페이징이 가능하도록 설정
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        scrollView.backgroundColor = .systemGray
        return scrollView
    }()
    
    let cafeBasicinfoView: CafeBasicInfoView = {
        let cafeBasicInfoView = CafeBasicInfoView(title: "카페 로제", starRate: 4.6, reviewCount: 50, location: "서울 마포구 와우산로 90", min: 20, max: 50)
        cafeBasicInfoView.translatesAutoresizingMaskIntoConstraints = false
        return cafeBasicInfoView
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
        bottomBar.backgroundColor = .systemBackground
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
    
    let chatButton: UIButton = {
        // TODO: 색상, 폰트 교체
        let chatButton = UIButton()
        chatButton.setTitle("1:1 문의", for: .normal)
        chatButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        chatButton.backgroundColor = UIColor(displayP3Red: 113/255, green: 113/255, blue: 113/255, alpha: 1)
        chatButton.layer.cornerRadius = 12
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        return chatButton
    }()
    
    let reservationButton: UIButton = {
        // TODO: 색상, 폰트 교체
        let reservationButton = UIButton()
        reservationButton.setTitle("예약하기", for: .normal)
        reservationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        reservationButton.backgroundColor = UIColor(displayP3Red: 119/255, green: 89/255, blue: 240/255, alpha: 1)
        reservationButton.layer.cornerRadius = 12
        reservationButton.translatesAutoresizingMaskIntoConstraints = false
        return reservationButton
    }()
    
    // 추후 segmentedControl에 추가할 ViewController 정의
    let detailInfoView: UIViewController = {
        let viewController = DetailInfomationViewController()
        return viewController
    }()
    
    let reviewView: UIViewController = {
        let viewController = CafeReviewViewController()
        return viewController
    }()
    
    var dataViewControllers: [UIViewController] {
        [detailInfoView, reviewView]
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // scrollView의 width, height
        let scrollViewWidth = imageScrollView.bounds.width, scrollViewHeight = imageScrollView.bounds.height
        
        // 카페 이미지 보여주기
        showCafeImages(width: scrollViewWidth, height: scrollViewHeight, cafeImages: cafeInfos[cafeIndex].imageDirectories, parentView: imageScrollView)
        
        // view.addSubview
        view.addSubview(scrollView)
        view.addSubview(bottomBar)
        
        // scrollView.addSubView
        scrollView.addSubview(dynamicStackView)
        scrollView.addSubview(imageScrollView)
        scrollView.addSubview(pageControl)
        scrollView.addSubview(cafeBasicinfoView)
        scrollView.addSubview(segmentedControl)
        
        // dynamicStackView.addArrangedSubview
        dynamicStackView.addArrangedSubview(pageController.view)
        
        // bottomBar View에 버튼 추가
        bottomBar.addSubview(chatButton)
        bottomBar.addSubview(reservationButton)
        
        applyConstraints()
    }
    
    // MARK: - functions
    
    // segmentControl을 터치하면 아래 PageViewController의 view가 바뀜
    @objc private func changePageControllerViewController(_ sender: UISegmentedControl) {
        pageController.setViewControllers([dataViewControllers[sender.selectedSegmentIndex]], direction: sender.selectedSegmentIndex == 1 ? .forward : .reverse, animated: true)
    }
    
    func showCafeImages(width: CGFloat, height: CGFloat, cafeImages: [String], parentView: UIView) {
        for i in 0 ..< cafeImages.count {
            // 카페 이미지 세팅
            let cafeImage = UIImageView()
            cafeImage.image = UIImage(systemName: cafeInfos[cafeIndex].imageDirectories[i])
            cafeImage.contentMode = .scaleAspectFit
            cafeImage.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: width / 4 * 3)
            
            imageScrollView.addSubview(cafeImage)
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
            dynamicStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            dynamicStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            dynamicStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dynamicStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ]
        
        let bottomBarConstraints = [
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        // TODO: chatButton, reservationButton의 width, height 비율로 바꾸기
        let chatButtonConstraints = [
            chatButton.widthAnchor.constraint(equalToConstant: 114),
            chatButton.heightAnchor.constraint(equalToConstant: 56),
            chatButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: .padding.margin),
            chatButton.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 10)
        ]
        
        let reservationButtonConstraints = [
            reservationButton.heightAnchor.constraint(equalToConstant: 56),
            reservationButton.leadingAnchor.constraint(equalTo: chatButton.trailingAnchor, constant: .padding.betweenButtonsPadding),
            reservationButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -.padding.margin),
            reservationButton.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 10)
        ]
        
        let segmentControlConstraints = [
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: cafeBasicinfoView.bottomAnchor, constant: .padding.differentHierarchyPadding),
            segmentedControl.heightAnchor.constraint(equalToConstant: 34)
        ]
        
        let pageControllerConstraints = [
            pageController.view.leadingAnchor.constraint(equalTo: dynamicStackView.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: dynamicStackView.trailingAnchor),
            pageController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            pageController.view.heightAnchor.constraint(equalToConstant: pageController.view.bounds.height)
        ]
        
        let cafeBasicInfoConstraints = [
            cafeBasicinfoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: .padding.margin),
            cafeBasicinfoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -.padding.margin),
            cafeBasicinfoView.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: .padding.startHierarchyPadding),
            cafeBasicinfoView.heightAnchor.constraint(equalToConstant: 131)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(dynamicContentconstraints)
        NSLayoutConstraint.activate(bottomBarConstraints)
        NSLayoutConstraint.activate(chatButtonConstraints)
        NSLayoutConstraint.activate(reservationButtonConstraints)
        NSLayoutConstraint.activate(segmentControlConstraints)
        NSLayoutConstraint.activate(pageControllerConstraints)
        NSLayoutConstraint.activate(cafeBasicInfoConstraints)
    }
                                   
}

// 임시 카페 정보 구조: Merge 후 정의된 Model로 교체할 예정
struct CafeInfoForDetailView: Codable {
    let cafeID: Int
    let cafeName: String
    let imageDirectories: [String]
    let address: String
    let cafePhoneNumber: String
    var SNS: String = ""
    let cafeMinPeople: Int
    let cafeMaxPeople: Int
    var costs: Int = 0
    let locationID: Int
}

extension CafeDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // ScrollView에 보이는 페이지 이동이 끝나면 PageCtrol의 현재 위치 변경
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / imageScrollView.bounds.width)
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
