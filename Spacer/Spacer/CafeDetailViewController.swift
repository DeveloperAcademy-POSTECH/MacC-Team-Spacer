//
//  CafeDetailViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class CafeDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // 상세 페이지에 필요한 카페 정보
    let cafeName: String = "카페 로제"
    let cafeImages: [String] = ["signature", "bag.fill", "creditcard.fill", "giftcard", "banknote", "dollarsign.circle.fill", "heart.fill"]
    
    // 카페 이미지를 볼 때 몇번째인지 표시하기 위한 PageControl
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.scrollView.bounds.maxY - 45, width: self.view.frame.maxX, height: 55))
        
        pageControl.numberOfPages = cafeImages.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
        
    }()
    
    // 카페 이미지를 보기 위한 ScrollView
    lazy var scrollView: UIScrollView = {
        // ScrollView와 내부 Content Size 정의
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 312))
        scrollView.contentSize = CGSize(width: CGFloat(cafeImages.count) * self.view.bounds.width, height: 0)
        
        // 스크롤 인디케이터 삭제
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // 스크롤 할 때 페이징이 가능하도록 설정
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        scrollView.backgroundColor = .systemGray
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        // scrollView의 width, height
        let scrollViewWidth = self.scrollView.bounds.width, scrollViewHeight = self.scrollView.bounds.height
        
        // 카페 이미지 보여주기
        showCafeImages(width: scrollViewWidth, height: scrollViewHeight, cafeIamges: cafeImages, parentView: scrollView)
        
        // scrollView, pageControl view에 추가
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
    }
    
    func showCafeImages(width: CGFloat, height: CGFloat, cafeIamges: [String], parentView: UIView) {
        for i in 0 ..< cafeIamges.count {
            // 카페 이미지 세팅
            let image = UIImageView()
            image.image = UIImage(systemName: cafeImages[i])
            image.contentMode = .scaleAspectFill
            image.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            
            scrollView.addSubview(image)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // ScrollView에 보이는 페이지 이동이 끝나면 PageCtrol의 현재 위치 변경
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / self.scrollView.bounds.width)
            
        }
        
    }
    
}
