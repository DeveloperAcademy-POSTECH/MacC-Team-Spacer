//
//  BirthdayCafeViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

// MARK: - 0. section나누기

enum Sections: Int {
    case recentCafeReview = 0
    case popularCafe = 1
}

class BirthdayCafeViewController: UIViewController {
    
    // 전체를 감싸는 스크롤뷰 - delegate를 활용하여 navBar 변화를 주기 위해 사용
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // TODO: - 테두리가 깎이는 상황에서 백그라운드가 clear로 .mainPurple4가 나와야함
    
    // 커스텀 네비게이션 바
    let navBar: UIView = {
        let navBar = UIView()
        navBar.backgroundColor = .mainPurple4
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        navBar.clipsToBounds = true
        return navBar
    }()
    
    // 로고 이미지
    let logoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "CELEBER"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    // 네비게이션 아이템 - 돋보기
    let magnifyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.tintColor = .mainPurple6
        button.translatesAutoresizingMaskIntoConstraints = false
        // MARK: - TODO: 버튼에 액션 추가
        return button
    }()
    
    // 네비게이션 아이템 - 하트
    let heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.tintColor = .mainPurple6
        button.translatesAutoresizingMaskIntoConstraints = false
        // MARK: - TODO: 버튼에 액션 추가
        return button
    }()
    // MARK: - 0. section정보
    
    let sectionTitles: [String] = ["최근 카페 후기", "가장 인기 있는 카페"]
    let sectionImages: [String] = ["book", "leaf"]
    
    private var headerView: MyHeaderView?
    
    // MARK: - 1. 카페 저장소
    
    var tempCafeArray: [CafeInfo] = [CafeInfo]()
    // 생일 카페 메인 테이블 뷰
    private let birthdayCafeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PopularCafeTableViewCell.self, forCellReuseIdentifier: PopularCafeTableViewCell.identifier)
        table.register(RecentCafeTableViewCell.self, forCellReuseIdentifier: RecentCafeTableViewCell.identifier)
        table.register(BirthdayCafeTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: BirthdayCafeTableViewSectionHeader.identifier)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        // 우측에 생기는 인디케이터 삭제
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        view.addSubview(navBar)
        
        scrollView.addSubview(birthdayCafeTableView)
        
        navBar.addSubview(logoButton)
        navBar.addSubview(magnifyButton)
        navBar.addSubview(heartButton)
        
        headerView = MyHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 150 / 390))
        birthdayCafeTableView.tableHeaderView = headerView
        headerView?.headerButton.addTarget(self, action: #selector(goToSearchListView), for: .touchUpInside)
        
        // 기존의 네비게이션을 hidden하고 새롭게 navBar로 대체
        navigationController?.isNavigationBarHidden = true
        
        scrollView.delegate = self
        
        birthdayCafeTableView.delegate = self
        birthdayCafeTableView.dataSource = self
        birthdayCafeTableView.clipsToBounds = true
        birthdayCafeTableView.separatorStyle = .none
        
        // MARK: - 1. 카페 불러오기
        
        self.tempCafeArray =  MockManager.shared.getMockData()
        
        magnifyButton.addTarget(self, action: #selector(goToSearchListView), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(goToFavorites), for: .touchUpInside)
        
        applyConstraints()
    }
    func applyConstraints() {
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        var navBarConstraints = [
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
            navBar.heightAnchor.constraint(equalToConstant: 99)
        ]
        
        // 노치가 없을 경우 navBar 오토레이아웃 처리
        if !UIDevice.current.hasNotch {
            navBarConstraints = [
                navBar.topAnchor.constraint(equalTo: view.topAnchor),
                navBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
                navBar.heightAnchor.constraint(equalToConstant: 79)
            ]
        }
        
        
        let logoButtonConstraints = [
            logoButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -.padding.underTitlePadding),
            logoButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: .padding.homeMargin),
            logoButton.widthAnchor.constraint(equalToConstant: 120),
            logoButton.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        let heartButtonConstraints = [
            heartButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -.padding.underTitlePadding),
            heartButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -.padding.homeMargin),
            heartButton.heightAnchor.constraint(equalToConstant: 28)
        ]
        
        let magnifyButtonConstraints = [
            magnifyButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -.padding.underTitlePadding),
            magnifyButton.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -.padding.homeMargin),
            magnifyButton.heightAnchor.constraint(equalToConstant: 28)
        ]
        
        let birthdayCafeTableViewConstraints = [
            birthdayCafeTableView.topAnchor.constraint(equalTo:navBar.bottomAnchor),
            birthdayCafeTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthdayCafeTableView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            birthdayCafeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(navBarConstraints)
        NSLayoutConstraint.activate(logoButtonConstraints)
        NSLayoutConstraint.activate(heartButtonConstraints)
        NSLayoutConstraint.activate(magnifyButtonConstraints)
        NSLayoutConstraint.activate(birthdayCafeTableViewConstraints)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        birthdayCafeTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    @objc func goToFavorites() {
        show(FavoriteViewController(),sender: nil)
    }
    
    @objc func goToSearchListView() {
        show(SearchListViewController(), sender: nil)
    }
}

extension BirthdayCafeViewController: UITableViewDelegate, UITableViewDataSource {
    // 섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // MARK: - SectionHeader
    
    // 커스텀 섹션 헤더 - 타이틀
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: BirthdayCafeTableViewSectionHeader.identifier) as? BirthdayCafeTableViewSectionHeader else { return UIView() }
        
        // 섹션 헤더뷰 설정
        sectionHeader.sectionTitle.text = sectionTitles[section]
        sectionHeader.sectionImage.image = UIImage(systemName: sectionImages[section])
        
        return sectionHeader
    }
    
    // TODO: - 사샤에게 패딩 컨펌받기
    
    // 섹션헤더의 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Sections.recentCafeReview.rawValue:
            return .padding.startHierarchyPadding + .padding.underTitlePadding + 24
        case Sections.popularCafe.rawValue:
            return .padding.differentHierarchyPadding + .padding.underTitlePadding + 24
        default:
            return 10
        }
    }
    
    // 섹션에 들어갈 셀 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.recentCafeReview.rawValue: return 1
        case Sections.popularCafe.rawValue: return tempCafeArray.count
        default:
            return 1
        }
    }
    
    // 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.recentCafeReview.rawValue :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentCafeTableViewCell.identifier, for: indexPath) as? RecentCafeTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBackground
            
            cell.configure(with: self.tempCafeArray)
            
            return cell
            
        case Sections.popularCafe.rawValue :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCafeTableViewCell.identifier, for: indexPath) as? PopularCafeTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBackground
            
            // MARK: - 1. 셀에 cafeInfo를 넘겨줌
            
            cell.configure(with: self.tempCafeArray[indexPath.row])
            cell.selectionStyle = .none

            // cell에 쉐도우 넣기
            cell.layer.cornerRadius = 12
            cell.contentView.layer.masksToBounds = true
            cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowRadius = 3
            cell.contentView.layer.shadowOpacity = 0.25
            cell.contentView.layer.masksToBounds = false
            
            return cell
            
        default:
            
            return UITableViewCell()
        }
    }
    
    // 셀의 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Sections.recentCafeReview.rawValue:
            return 112
        case Sections.popularCafe.rawValue:
            return 214
        default:
            return 214
        }
    }
    
    // 셀을 터치했을 경우
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 터치시 남아있는 회색 표시 없애기
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// 헤더뷰의 높이만큼 스크롤 되었을 경우 navBar의 cornerRadius 수정
extension BirthdayCafeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= headerView!.bounds.height - 8 {
            self.navBar.layer.cornerRadius = 24
        } else {
            self.navBar.layer.cornerRadius = 0
        }
    }
    
    // TODO: - ScrollUp방지
    
}

// MARK: - 기기 별 대응하기 위한 extension
// TODO: - 각 상황마다 어떻게 처리할 지 팀과 합의, case분류 작업

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }

}
