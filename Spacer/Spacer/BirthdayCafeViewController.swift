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
    
    // MARK: - 로고 이미지
    let logoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "RANG"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
   // MARK: - 0. section이름
    let sectionTitles: [String] = ["최근 카페 후기", "가장 인기 있는 카페"]
    
    private var headerView: MyHeaderView?
    // MARK: - 1. 카페 저장소
    var tempCafeArray: [CafeInfo] = [CafeInfo]()
    // 최근카페 후기 테이블 뷰
    private let recentCafeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PopularCafeTableViewCell.self, forCellReuseIdentifier: PopularCafeTableViewCell.identifier)
        table.register(RecentCafeTableViewCell.self, forCellReuseIdentifier: RecentCafeTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(recentCafeTable)
        recentCafeTable.backgroundColor = .white
        headerView = MyHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width*0.66))
        recentCafeTable.tableHeaderView = headerView
        headerView?.layoutIfNeeded()
        
        
        recentCafeTable.delegate = self
        recentCafeTable.dataSource = self
        recentCafeTable.clipsToBounds = true
        
        recentCafeTable.separatorStyle = .none
        // MARK: - 1. 카페 불러오기
        self.tempCafeArray =  MockManager.shared.getMockData()
        setNavBar()
    }
    // MARK: - 네비게이션 설정
    func setNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.init(red: 227/255, green: 217/255, blue: 255/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        // 네비게이션 좌측 로고
        NSLayoutConstraint.activate([
            logoButton.widthAnchor.constraint(equalToConstant: 100),
            logoButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        let logo = UIBarButtonItem(customView: logoButton)
        
        self.navigationItem.leftBarButtonItem = logo
        
        // 네비게이션 우측 아이템
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(bye))
        let heart = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(hi))
        self.navigationItem.rightBarButtonItems = [heart,search]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        recentCafeTable.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    @objc func hi() {
        print("hi")
    }
    @objc func bye() {
        print("bye")
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




// MARK: - extension gradient

extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero

        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }

        layer.colors = layerColorSet
        layer.locations = layerLocations

        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }

        self.layer.insertSublayer(layer, above: self.layer)
    }
}
