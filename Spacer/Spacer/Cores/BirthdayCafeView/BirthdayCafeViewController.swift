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
    
    // 커스텀 네비게이션 바
    let navBar: UIView = {
        let navBar = UIView()
        navBar.backgroundColor = .grayscale7
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        navBar.clipsToBounds = true
        return navBar
    }()
    
    // 로고 이미지
    let logoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "CELEBER_Logo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    // 네비게이션 아이템 - 돋보기
    let magnifyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "MagnifyingGlass"), for: .normal)
//        button.setImage(UIImage(named: "MagnifyingGlass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        button.tintColor = .mainPurple1
        button.translatesAutoresizingMaskIntoConstraints = false
        // MARK: - TODO: 버튼에 액션 추가
        return button
    }()
    // MARK: - 0. section정보
    
    let sectionTitles: [String] = ["최근 카페 후기", "지금 인기 있는 카페"]
    let sectionImages: [String] = ["RecentReviewCafeIcon", "PopularCafeIcon"]
    
    private var headerView: MyHeaderView?
    
    // MARK: - 1. 카페 저장소
    
    var tempCafeArray: [CafeInfo] = [CafeInfo]()
    
    // 카페 데이터를 받아올 새 프로퍼티
    private var cafeDataArray: [Cafeinfo] = [Cafeinfo]()
    
    // 썸네일에 사용될 이미지 url 주소
    private lazy var thumbnailImageInfos: [CafeThumbnailImage] = [CafeThumbnailImage]()
    
    // 생일 카페 메인 테이블 뷰
    private let birthdayCafeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PopularCafeTableViewCell.self, forCellReuseIdentifier: PopularCafeTableViewCell.identifier)
        
        //MARK: - 리뷰가 완료 되기 전까지 RecentCafeTableViewCell가 아닌 ReviewUnderConstructionTableViewCell로 대체됨
        
//        table.register(RecentCafeTableViewCell.self, forCellReuseIdentifier: RecentCafeTableViewCell.identifier)
        table.register(ReviewUnderConstructionTableViewCell.self, forCellReuseIdentifier: ReviewUnderConstructionTableViewCell.identifier)
        table.register(BirthdayCafeTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: BirthdayCafeTableViewSectionHeader.identifier)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        // scrollUp시 navBar와 tableHeader가 떨어지는것 방지
        table.bounces = false
        // 우측에 생기는 인디케이터 삭제
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // API로 데이터 호출
        Task {
            cafeDataArray = try await APICaller.requestGetData(url: "/cafeinfo/", dataType: [Cafeinfo].self) as! [Cafeinfo]
            
            for data in cafeDataArray {
                var thumbnailImageInfo: CafeThumbnailImage
                
                // 각 카페 별 썸네일 이미지 url 요청하고 데이터가 없을 경우 기본 이미지로 썸네일 이미지 대체
                do {
                    thumbnailImageInfo = try await APICaller.requestGetData(url: "/static/getfirstimage/\(data.cafeID)", dataType: CafeThumbnailImage.self) as! CafeThumbnailImage
                    thumbnailImageInfos.append(thumbnailImageInfo)
                } catch {
                    thumbnailImageInfos.append(CafeThumbnailImage(cafeImageUrl: "http://158.247.222.189:12232/static/images/6693852c64b011ed94ba0242ac110003/cafeId3_img_001.jpg", imageCategory: "", imageProductSize: ""))
                }
            }
            
            birthdayCafeTableView.reloadData()
        }
        
        view.addSubview(navBar)
        view.addSubview(birthdayCafeTableView)
        
        navBar.addSubview(logoButton)
        navBar.addSubview(magnifyButton)
        
        headerView = MyHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 150 / 390))
        birthdayCafeTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        birthdayCafeTableView.tableHeaderView = headerView
        
        headerView?.headerButton.addTarget(self, action: #selector(goToVisualTagView), for: .touchUpInside)
        
        birthdayCafeTableView.delegate = self
        birthdayCafeTableView.dataSource = self
        birthdayCafeTableView.clipsToBounds = true
        birthdayCafeTableView.separatorStyle = .none
        
        // MARK: - 1. 카페 불러오기
        
        self.tempCafeArray =  MockManager.shared.getMockData()
        
        magnifyButton.addTarget(self, action: #selector(goToSearchListView), for: .touchUpInside)
        
        applyConstraints()
        
        // VisualTagEventElementsView에서 완료버튼을 눌렀을 경우 SearchListView로 넘어갑니다.
        NotificationCenter.default.addObserver(self, selector: #selector(gotoSearchListViewFromVisualTag), name: NSNotification.Name("goToSearchListView"), object: nil)
    }
    
    func applyConstraints() {
        
        let navBarConstraints = [
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
            navBar.heightAnchor.constraint(equalToConstant: 99)
        ]
        
        let logoButtonConstraints = [
            logoButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -.padding.underTitlePadding),
            logoButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: .padding.homeMargin),
            logoButton.widthAnchor.constraint(equalToConstant: 120),
            logoButton.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        let magnifyButtonConstraints = [
            magnifyButton.centerYAnchor.constraint(equalTo: logoButton.centerYAnchor),
            magnifyButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -.padding.homeMargin),
            magnifyButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let birthdayCafeTableViewConstraints = [
            birthdayCafeTableView.topAnchor.constraint(equalTo:navBar.bottomAnchor),
            birthdayCafeTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthdayCafeTableView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            birthdayCafeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(navBarConstraints)
        NSLayoutConstraint.activate(logoButtonConstraints)
        NSLayoutConstraint.activate(magnifyButtonConstraints)
        NSLayoutConstraint.activate(birthdayCafeTableViewConstraints)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        birthdayCafeTableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 처음 실행되었다면 UserDefaults에 oldUser라는 값이 False
        if !UserDefaults.standard.bool(forKey: "oldUser") {
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            pageVC.modalPresentationStyle = .fullScreen
            present(pageVC, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 기존의 네비게이션을 hidden하고 새롭게 navBar로 대체
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func goToFavorites() {
        show(FavoriteViewController(),sender: nil)
    }
    
    // 바로 돋보기 버튼으로 SearchListView로 넘어갔을 경우
    @objc func goToSearchListView() {
        UserDefaults.standard.removeObject(forKey: "eventElements")
        UserDefaults.standard.removeObject(forKey: "region")
        UserDefaults.standard.removeObject(forKey: "firstDate")
        UserDefaults.standard.removeObject(forKey: "lastDate")
        let searchListViewController = SearchListViewController()
        self.navigationController!.pushViewController(searchListViewController, animated: true)
    }
    
    // VisualTagView에서 SearchListView로 넘어갔을 경우
    @objc func gotoSearchListViewFromVisualTag() {
        let searchListViewController = SearchListViewController()
        self.navigationController!.pushViewController(searchListViewController, animated: true)
    }
    
    @objc func goToVisualTagView() {
        let visualTagCalendarViewController = UINavigationController(rootViewController: VisualTagCalendarViewController())
        visualTagCalendarViewController.modalPresentationStyle = .fullScreen
        self.present(visualTagCalendarViewController, animated: true, completion: nil)
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
        sectionHeader.sectionImage.image = UIImage(named: sectionImages[section])
        
        return sectionHeader
    }
    
    // 섹션헤더의 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Sections.recentCafeReview.rawValue:
            return .padding.startHierarchyPadding + .padding.underTitlePadding + 24
        case Sections.popularCafe.rawValue:
            return .padding.differentHierarchyPadding + .padding.underTitlePadding
        default:
            return 10
        }
    }
    
    // 섹션에 들어갈 셀 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.recentCafeReview.rawValue: return 1
        case Sections.popularCafe.rawValue: return cafeDataArray.count
        default:
            return 1
        }
    }
    
    // 셀 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.recentCafeReview.rawValue :
            
            //MARK: - 리뷰가 완료 되기 전까지 RecentCafeTableViewCell가 아닌 ReviewUnderConstructionTableViewCell로 대체됨
            
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentCafeTableViewCell.identifier, for: indexPath) as? RecentCafeTableViewCell else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewUnderConstructionTableViewCell.identifier) as? ReviewUnderConstructionTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .systemBackground
            cell.selectionStyle = .none
            
            //MARK: - 3. self( = BirthdayCafeViewController)를 cell의 delegate로 채택
//            cell.cellSelectedDelegate = self
            
//            cell.configure(with: self.tempCafeArray)
            
            return cell
            
        case Sections.popularCafe.rawValue :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCafeTableViewCell.identifier, for: indexPath) as? PopularCafeTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = .systemBackground
            
            // MARK: - 1. 셀에 cafeinfo를 넘겨줌
            
            cell.configure(with: self.cafeDataArray[indexPath.row], imageURL: thumbnailImageInfos[indexPath.row].cafeImageUrl)
            cell.selectionStyle = .none
            
            // cell에 쉐도우 넣기
            cell.layer.cornerRadius = 12
            cell.contentView.layer.masksToBounds = true
            cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowRadius = 3
            cell.contentView.layer.shadowOpacity = 0.15
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
        if indexPath.section == 1 {
            let cafeDetailViewController = CafeDetailViewController()
            cafeDetailViewController.cafeData = cafeDataArray[indexPath.row]
            self.navigationController?.pushViewController(cafeDetailViewController, animated: true)
        }
    }
}

//MARK: - 3. 프로토콜을 채택 -> 함수 지정: 다른 뷰로 넘어가는 기능
extension BirthdayCafeViewController: CellSelectedDelegate {
    func selectionAction(data: CafeInfo?, indexPath: IndexPath) {
        let cafeDetailViewController = CafeDetailViewController()
        cafeDetailViewController.cafeData = cafeDataArray[indexPath.row]
        navigationController?.pushViewController(cafeDetailViewController, animated: true)
    }
}
