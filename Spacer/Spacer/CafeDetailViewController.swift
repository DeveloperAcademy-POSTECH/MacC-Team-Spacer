//
//  CafeDetailViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class CafeDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // 임시 카페 정보
    private let cafeInfos: [CafeInfoForDetailView] = [
        CafeInfoForDetailView(cafeID: 0, cafeName: "카페로제", imageDirectories: ["signature", "bag.fill", "creditcard.fill", "giftcard", "banknote", "dollarsign.circle.fill", "heart.fill"], address: "서울 홍대 어쩌고 저쩌고 106", cafePhoneNumber: "010-7189-8294", SNS: "@gumbee_h", cafeMinPeople: 20, cafeMaxPeople: 50, locationID: 0),
        CafeInfoForDetailView(cafeID: 1, cafeName: "랑카페", imageDirectories: ["banknote", "bag.fill", "creditcard.fill", "giftcard", "signature", "dollarsign.circle.fill", "heart.fill"], address: "부산 어쩌고 저쩌고 11", cafePhoneNumber: "010-0000-8294", SNS: "@eunbi_Han", cafeMinPeople: 30, cafeMaxPeople: 40, locationID: 1)
    ]
    private let cafeIndex = 0
    
    // 카페 이미지를 볼 때 몇번째인지 표시하기 위한 PageControl
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.scrollView.bounds.maxY - 45, width: self.view.frame.maxX, height: 55))
        
        pageControl.numberOfPages = cafeInfos[cafeIndex].imageDirectories.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
        
    }()
    
    // 카페 이미지를 보기 위한 ScrollView
    lazy var scrollView: UIScrollView = {
        // ScrollView와 내부 Content Size 정의
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / 4 * 3))
        scrollView.contentSize = CGSize(width: CGFloat(cafeInfos[cafeIndex].imageDirectories.count) * self.view.bounds.width, height: 0)
        
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
        showCafeImages(width: scrollViewWidth, height: scrollViewHeight, cafeIamges: cafeInfos[cafeIndex].imageDirectories, parentView: scrollView)
        
        // scrollView, pageControl view에 추가
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
    }
    
    func showCafeImages(width: CGFloat, height: CGFloat, cafeIamges: [String], parentView: UIView) {
        for i in 0 ..< cafeIamges.count {
            // 카페 이미지 세팅
            let image = UIImageView()
            image.image = UIImage(systemName: cafeInfos[cafeIndex].imageDirectories[i])
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

// 임시 카페 정보 구조
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

