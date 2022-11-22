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
        button.setTitleColor(.grayscale7, for: .normal)
        button.titleLabel?.font = .systemFont(for: .header6)
        button.backgroundColor = .mainPurple3
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // X버튼
    lazy var XButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setOnBoard()
        setLastButton()
        setControll()
        setXButton()
    }
    
    func setOnBoard(){
        // 온보딩 1페이지
        let firstOnBoardView = FirstOnBoardViewController()
        
        // 온보딩 2페이지
        let secondOnBoardView = OnBoardingViewController()
        secondOnBoardView.mainImage.image = UIImage(named: "secondOnBoardImage")
        secondOnBoardView.mainLabel.text = "내가 원하는 기간에 예약이\n가능한 카페를 찾아야 해요"
        secondOnBoardView.backgroundView.backgroundColor = .mainPurple5
        setAttr(label: secondOnBoardView.mainLabel)
        
        let underLine2 = makeUnderLine()
        secondOnBoardView.view.insertSubview(underLine2, at: 0)
        NSLayoutConstraint.activate([
            underLine2.centerXAnchor.constraint(equalTo: secondOnBoardView.mainLabel.centerXAnchor, constant: -10),
            underLine2.topAnchor.constraint(equalTo: secondOnBoardView.mainLabel.topAnchor, constant: 24),
            underLine2.widthAnchor.constraint(equalToConstant: 130),
            underLine2.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        // 온보딩 3페이지
        let thirdOnBoardView = OnBoardingViewController()
        thirdOnBoardView.mainImage.image = UIImage(named: "thirdOnBoardImage")
        thirdOnBoardView.mainLabel.text = "원하는 위치에 있는\n카페를 찾아야 해요"
        thirdOnBoardView.backgroundView.backgroundColor = .mainPurple4
        setAttr(label: thirdOnBoardView.mainLabel)
        
        let underLine3 = makeUnderLine()
        thirdOnBoardView.view.insertSubview(underLine3, at: 0)
        NSLayoutConstraint.activate([
            underLine3.centerXAnchor.constraint(equalTo: thirdOnBoardView.mainLabel.centerXAnchor, constant: -24),
            underLine3.topAnchor.constraint(equalTo: thirdOnBoardView.mainLabel.topAnchor, constant: 24),
            underLine3.widthAnchor.constraint(equalToConstant: 130),
            underLine3.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        // 온보딩 4페이지
        let fourthOnBoardView = OnBoardingViewController()
        fourthOnBoardView.mainImage.image = UIImage(named: "fourthOnBoardImage")
        fourthOnBoardView.mainLabel.text = "내가 하고 싶은 데코레이션을 \n진행할 수 있는 카페를 찾아야 해요"
        fourthOnBoardView.backgroundView.backgroundColor = .mainPurple3
        setAttr(label: fourthOnBoardView.mainLabel)
        
        let underLine4 = makeUnderLine()
        fourthOnBoardView.view.insertSubview(underLine4, at: 0)
        NSLayoutConstraint.activate([
            underLine4.centerXAnchor.constraint(equalTo: fourthOnBoardView.mainLabel.centerXAnchor, constant: 70),
            underLine4.topAnchor.constraint(equalTo: fourthOnBoardView.mainLabel.topAnchor, constant: 24),
            underLine4.widthAnchor.constraint(equalToConstant: 122),
            underLine4.heightAnchor.constraint(equalToConstant: 13)
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
            lastButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        lastButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        lastButton.isHidden = true
    }
    
    func setControll() {
        pageController.numberOfPages = onBoardPages.count
        
        view.addSubview(pageController)
        NSLayoutConstraint.activate([
            pageController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -116),
            pageController.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        pageController.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    func setXButton() {
        view.addSubview(XButton)
        NSLayoutConstraint.activate([
            XButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            XButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            XButton.widthAnchor.constraint(equalToConstant: 24),
            XButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        XButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // 강조 언더라인 생성 함수
    private func makeUnderLine() -> UIView {
        let underLine = UIView()
        underLine.backgroundColor = .subYellow1
        underLine.translatesAutoresizingMaskIntoConstraints = false
        return underLine
    }
    
    // lineSpacing 설정 함수
    func setAttr(label: UILabel) {
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        self.setViewControllers([onBoardPages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func buttonTapped(){
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
