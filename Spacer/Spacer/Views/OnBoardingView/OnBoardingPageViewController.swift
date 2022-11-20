//
//  OnBoardingPageViewController.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/21.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    // 온보딩 페이지 담는 배열
    lazy var onBoardPages = [UIViewController]()
    
    // 페이지 컨트롤러
    lazy var pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPage = 0
        pageController.currentPageIndicatorTintColor = .mainPurple3
        pageController.pageIndicatorTintColor = .grayscale5
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    // 온보딩 마지막 페이지 확인 버튼
    lazy var lastButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("생일 카페를 찾으러 가볼까요?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOnBoard()
        setLastButton()
        setControll()
    }
    
    func setOnBoard(){
        let firstOnBoardView = OnBoardingViewController()
        firstOnBoardView.mainImage.image = UIImage(named: "TagBanner")
        firstOnBoardView.mainLabel.text = "생일 카페를 선택할 때는 \n3가지 조건을 생각하세요!"
        
        let underLine1 = makeUnderLine()
        firstOnBoardView.view.insertSubview(underLine1, at: 0)
        NSLayoutConstraint.activate([
            underLine1.leadingAnchor.constraint(equalTo: firstOnBoardView.mainLabel.leadingAnchor),
            underLine1.bottomAnchor.constraint(equalTo: firstOnBoardView.mainLabel.bottomAnchor, constant: -4),
            underLine1.widthAnchor.constraint(equalToConstant: 103),
            underLine1.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        let secondOnBoardView = OnBoardingViewController()
        secondOnBoardView.mainImage.image = UIImage(named: "TagBanner")
        secondOnBoardView.mainLabel.text = "내가 원하는 기간에 예약이\n가능한 카페를 찾아야 해요"
        
        let underLine2 = makeUnderLine()
        secondOnBoardView.view.insertSubview(underLine2, at: 0)
        NSLayoutConstraint.activate([
            underLine2.centerXAnchor.constraint(equalTo: secondOnBoardView.mainLabel.centerXAnchor, constant: -10),
            underLine2.topAnchor.constraint(equalTo: secondOnBoardView.mainLabel.topAnchor, constant: 24),
            underLine2.widthAnchor.constraint(equalToConstant: 130),
            underLine2.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        let thirdOnBoardView = OnBoardingViewController()
        thirdOnBoardView.mainImage.image = UIImage(named: "TagBanner")
        thirdOnBoardView.mainLabel.text = "원하는 위치에 있는\n카페를 골라야 해요"
        setAttr(label: thirdOnBoardView.mainLabel)
        
        let underLine3 = makeUnderLine()
        thirdOnBoardView.view.insertSubview(underLine3, at: 0)
        NSLayoutConstraint.activate([
            underLine3.centerXAnchor.constraint(equalTo: thirdOnBoardView.mainLabel.centerXAnchor, constant: -24),
            underLine3.topAnchor.constraint(equalTo: thirdOnBoardView.mainLabel.topAnchor, constant: 24),
            underLine3.widthAnchor.constraint(equalToConstant: 130),
            underLine3.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        let fourthOnBoardView = OnBoardingViewController()
        fourthOnBoardView.mainImage.image = UIImage(named: "TagBanner")
        fourthOnBoardView.mainLabel.text = "나의 예산과 카페에서 가능한\n전시를 고려해야 해요"
        
        let underLine4 = makeUnderLine()
        fourthOnBoardView.view.insertSubview(underLine4, at: 0)
        NSLayoutConstraint.activate([
            underLine4.centerXAnchor.constraint(equalTo: fourthOnBoardView.mainLabel.centerXAnchor, constant: -77),
            underLine4.topAnchor.constraint(equalTo: fourthOnBoardView.mainLabel.topAnchor, constant: 24),
            underLine4.widthAnchor.constraint(equalToConstant: 110),
            underLine4.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        let underLine5 = makeUnderLine()
        fourthOnBoardView.view.insertSubview(underLine5, at: 0)
        NSLayoutConstraint.activate([
            underLine5.centerXAnchor.constraint(equalTo: fourthOnBoardView.mainLabel.centerXAnchor, constant: -66),
            underLine5.bottomAnchor.constraint(equalTo: fourthOnBoardView.mainLabel.bottomAnchor, constant: -4),
            underLine5.widthAnchor.constraint(equalToConstant: 64),
            underLine5.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        onBoardPages.append(firstOnBoardView)
        onBoardPages.append(secondOnBoardView)
        onBoardPages.append(thirdOnBoardView)
        onBoardPages.append(fourthOnBoardView)
        
        // 첫 번째 페이지로 설정
        setViewControllers([firstOnBoardView], direction: .forward, animated: true, completion: nil)
        
        dataSource = self
        delegate = self
    }
    
    func setLastButton() {
        view.addSubview(lastButton)
        NSLayoutConstraint.activate([
            lastButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            lastButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            lastButton.heightAnchor.constraint(equalToConstant: 56),
            lastButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        lastButton.addTarget(self, action: #selector(lastButtonTapped), for: .touchUpInside)
        
        lastButton.isHidden = true
    }
    
    func setControll() {
        
        pageController.numberOfPages = onBoardPages.count
        
        view.addSubview(pageController)
        NSLayoutConstraint.activate([
            pageController.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            pageController.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        pageController.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    // 강조 언더라인 생성 함수
    private func makeUnderLine() -> UIView {
        let underLine = UIView()
        underLine.backgroundColor = .subYellow1
        underLine.translatesAutoresizingMaskIntoConstraints = false
        return underLine
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        self.setViewControllers([onBoardPages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func lastButtonTapped(){
        UserDefaults.standard.set(true, forKey: "oldUser")
        self.dismiss(animated: true)
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        
        guard let currentIndex = onBoardPages.firstIndex(of: currentVC) else {
            return
        }
        
        pageController.currentPage = currentIndex
        
        // 마지막 온보딩 페이지에서 button을 보임
        if currentIndex == onBoardPages.count - 1{
            lastButton.isHidden = false
        } else {
            lastButton.isHidden = true
        }
    }
    
    // 이전 페이지
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onBoardPages.firstIndex(of: viewController) else {
            return nil
        }
        
        // 처음 온보딩 페이지
        if currentIndex == 0 {
            return nil
        }
        
        return onBoardPages[currentIndex - 1]
    }
    
    // 다음 페이지
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onBoardPages.firstIndex(of: viewController) else {
            return nil
        }
        
        // 마지막 온보딩 페이지
        if currentIndex == onBoardPages.count - 1 {
            return nil
        }
        
        return onBoardPages[currentIndex + 1]
    }
}
