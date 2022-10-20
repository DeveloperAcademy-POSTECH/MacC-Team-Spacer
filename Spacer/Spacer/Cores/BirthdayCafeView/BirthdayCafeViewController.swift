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
    // MARK: - 0. section이름
    
    let sectionTitles: [String] = ["최근 카페 후기", "가장 인기 있는 카페"]
    
    private var headerView: MyHeaderView?
    
    // MARK: - 1. 카페 저장소
    
    var tempCafeArray: [CafeInfo] = [CafeInfo]()
    // 생일 카페 메인 테이블 뷰
    private let birthdayCafeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PopularCafeTableViewCell.self, forCellReuseIdentifier: PopularCafeTableViewCell.identifier)
        table.register(RecentCafeTableViewCell.self, forCellReuseIdentifier: RecentCafeTableViewCell.identifier)
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
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
        
        headerView = MyHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width*0.66))
        birthdayCafeTableView.tableHeaderView = headerView
        
        // 기존의 네비게이션을 hidden하고 새롭게 navBar로 대체
        navigationController?.isNavigationBarHidden = true
        
        scrollView.delegate = self
        
        birthdayCafeTableView.delegate = self
        birthdayCafeTableView.dataSource = self
        birthdayCafeTableView.clipsToBounds = true
        birthdayCafeTableView.separatorStyle = .none
        
        // MARK: - 1. 카페 불러오기
        
        self.tempCafeArray =  MockManager.shared.getMockData()
        
        applyConstraints()
    }
    func applyConstraints() {
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        let navBarConstraints = [
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
            navBar.heightAnchor.constraint(equalToConstant: 99 * view.bounds.height / 844)
        ]
        
        let logoButtonConstraints = [
            logoButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -.padding.underTitlePadding * view.bounds.height / 844),
            logoButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 20 * view.bounds.width / 390),
            logoButton.widthAnchor.constraint(equalToConstant: 113.89 * view.bounds.width / 390),
            logoButton.heightAnchor.constraint(equalToConstant: 24 * view.bounds.height / 844)
        ]
        
        let heartButtonConstraints = [
            heartButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -.padding.underTitlePadding * view.bounds.height / 844),
            heartButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20 * view.bounds.width / 390),
            heartButton.heightAnchor.constraint(equalToConstant: 24 * view.bounds.height / 844 )
        ]
        
        let magnifyButtonConstraints = [
            magnifyButton.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -.padding.underTitlePadding * view.bounds.height / 844),
            magnifyButton.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor, constant: -20 * view.bounds.width / 390),
            magnifyButton.heightAnchor.constraint(equalToConstant: 24 * view.bounds.height / 844 )
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
        print("goToFavorites")
    }
    
    @objc func goToSearchListView() {
        show(SearchListViewController(), sender: nil)
    }
}

extension BirthdayCafeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.recentCafeReview.rawValue: return 1
        case Sections.popularCafe.rawValue: return tempCafeArray.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.recentCafeReview.rawValue :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentCafeTableViewCell.identifier, for: indexPath) as? RecentCafeTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .systemBackground
            cell.configure(with: self.tempCafeArray)
            return cell
        case Sections.popularCafe.rawValue :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularCafeTableViewCell.identifier, for: indexPath) as? PopularCafeTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .systemBackground
            
            // MARK: - 1. 셀에 cafeInfo를 넘겨줌
            
            cell.configure(with: self.tempCafeArray[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    // section마다 title 정의
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.recentCafeReview.rawValue: return sectionTitles[0]
        case Sections.popularCafe.rawValue: return sectionTitles[1]
        default:
            return  "default"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.textColor = .label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Sections.recentCafeReview.rawValue:
            return view.bounds.height * 0.14
        case Sections.popularCafe.rawValue:
            return view.bounds.height * 0.25
        default:
            return 214
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 터치시 남아있는 회색 표시 없애기
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// 헤더뷰의 높이만큼 스크롤 되었을 경우 navBar의 cornerRadius 수정
extension BirthdayCafeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= headerView!.bounds.height {
            self.navBar.layer.cornerRadius = 24
        } else {
            self.navBar.layer.cornerRadius = 0
        }
    }
}
