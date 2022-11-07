//
//  CafeDetailViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    // 받아오는 카페 인포
    var tempCafeInfo: CafeInfo?
    
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
        label.textColor = .white
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
    
    let chatButton: UIButton = {
        let chatButton = UIButton()
        chatButton.setTitle("1:1 문의", for: .normal)
        chatButton.titleLabel?.font = .systemFont(for: .header6)
        chatButton.backgroundColor = .grayscale2
        chatButton.layer.cornerRadius = 12
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        return chatButton
    }()
    
    let reservationButton: UIButton = {
        let reservationButton = UIButton()
        reservationButton.setTitle("예약하기", for: .normal)
        reservationButton.titleLabel?.font = .systemFont(for: .header6)
        reservationButton.backgroundColor = .mainPurple3
        reservationButton.layer.cornerRadius = 12
        reservationButton.translatesAutoresizingMaskIntoConstraints = false
        return reservationButton
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
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        detailInfoView.cafeInfoData = tempCafeInfo
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        // 카페 이미지 보여주기
        totalImageCount = showCafeImages(width: view.bounds.width, cafeImageInfos: tempCafeInfo!.imageInfos, parentView: imageScrollView)
        
        // 전체 이미지 수에 따라 imageScrollView의 width 설정
        imageScrollView.contentSize = CGSize(width: CGFloat(totalImageCount) * view.bounds.width, height: 0)
        
        setImageDescriptionView(categoryName: tempCafeInfo?.imageInfos[0].category ?? "", tempImageNumber: 1, numberOfImages: totalImageCount, sizeDescription: tempCafeInfo?.imageInfos[0].productSize ?? "")
        
        // navigationBar & tabBar 설정
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.title = tempCafeInfo?.name
        tabBarController?.tabBar.isHidden = true
        
        // view.addSubview
        view.addSubview(scrollView)
        view.addSubview(bottomBar)
        
        // scrollView.addSubView
        scrollView.addSubview(dynamicStackView)
        scrollView.addSubview(imageScrollView)
        scrollView.addSubview(imageDescriptionView)
        scrollView.addSubview(segmentedControl)
        
        imageDescriptionView.addSubview(categoryLabel)
        imageDescriptionView.addSubview(sizeLabel)
        
        // dynamicStackView.addArrangedSubview
        dynamicStackView.addArrangedSubview(pageController.view)
        
        // bottomBar View에 버튼 추가
        bottomBar.addSubview(chatButton)
        bottomBar.addSubview(reservationButton)
        
        applyConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - functions
    
    // segmentControl을 터치하면 아래 PageViewController의 view가 바뀜
    @objc private func changePageControllerViewController(_ sender: UISegmentedControl) {
        pageController.setViewControllers([dataViewControllers[sender.selectedSegmentIndex]], direction: sender.selectedSegmentIndex == 1 ? .forward : .reverse, animated: true)
    }
    
    func showCafeImages(width: CGFloat, cafeImageInfos: [ImageInfo], parentView: UIView) -> Int {
        var imageIndex = 0
        
        for cafeImageInfo in cafeImageInfos {
            let images = cafeImageInfo.images
            let imageCategory = cafeImageInfo.category
            let productSize = cafeImageInfo.productSize
            
            for image in images {
                let cafeImage = UIImageView()
                cafeImage.image = UIImage(named: image)
                imageIndex += 1
                cafeImage.contentMode = .scaleAspectFill
                cafeImage.clipsToBounds = true
                cafeImage.frame = CGRect(x: CGFloat(imageIndex - 1) * width, y: 0, width: width, height: width / 3 * 4)
                
                imageScrollView.addSubview(cafeImage)
                categoryNames.append(imageCategory)
                sizeDescriptions.append(productSize)
            }
        }
        
        return imageIndex
    }
    
    private func setImageDescriptionView(categoryName: String, tempImageNumber: Int, numberOfImages: Int, sizeDescription: String) {
        categoryLabel.text = "\(categoryName) | \(tempImageNumber)/\(numberOfImages)"
        sizeLabel.text = sizeDescription
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
        
        let bottomBarConstraints = [
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 100)
        ]
        
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
            segmentedControl.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: .padding.differentHierarchyPadding),
            segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 34)
        ]
        
        let pageControllerConstraints = [
            pageController.view.leadingAnchor.constraint(equalTo: dynamicStackView.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: dynamicStackView.trailingAnchor),
            pageController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            pageController.view.heightAnchor.constraint(equalToConstant: pageController.view.bounds.height)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(dynamicContentconstraints)
        NSLayoutConstraint.activate(imageScrollViewConstraints)
        NSLayoutConstraint.activate(imageDescriptionViewConstraints)
        NSLayoutConstraint.activate(categoryLabelConstraints)
        NSLayoutConstraint.activate(sizeLabelConstraints)
        NSLayoutConstraint.activate(bottomBarConstraints)
        NSLayoutConstraint.activate(chatButtonConstraints)
        NSLayoutConstraint.activate(reservationButtonConstraints)
        NSLayoutConstraint.activate(segmentControlConstraints)
        NSLayoutConstraint.activate(pageControllerConstraints)
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
        // TODO: 스크롤 될 때, 카테고리 및 사이즈 정보 바뀌도록 변경
        let currentImageNumber = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            setImageDescriptionView(categoryName: categoryNames[currentImageNumber], tempImageNumber: currentImageNumber + 1, numberOfImages: totalImageCount, sizeDescription: sizeDescriptions[currentImageNumber])
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
