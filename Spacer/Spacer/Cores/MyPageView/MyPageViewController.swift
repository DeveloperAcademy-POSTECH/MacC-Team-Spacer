//
//  MyPageViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let mainLabelArr = ["카페 등록하기", "앱 피드백하기"]
    let subLabelArr = ["셀레버에 카페를 등록하고 싶다면?", "셀러버 앱을 피드백하고 싶다면"]
    let mainImageArr = ["registerCafe","feedBack"]
    let backgroundArr: [UIColor] = [.mainPurple3, .systemBlue]
    
    lazy var preparingView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "preparingMyPage")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var myPageTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var memberButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "members")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(goToMembers), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var whoWeAreLabel: UILabel = {
        let label = UILabel()
        label.text = "만든 사람들 보러 가기"
        label.font = UIFont(name: "esamanru OTF Medium", size: 14)
        label.textColor = .grayscale4
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        setLayout()
        
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
    }
    
    func setLayout() {
        view.addSubview(preparingView)
        view.addSubview(myPageTableView)
        view.addSubview(memberButton)
        view.addSubview(whoWeAreLabel)
        NSLayoutConstraint.activate([
            preparingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            preparingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            preparingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            
            myPageTableView.topAnchor.constraint(equalTo: preparingView.bottomAnchor, constant: 32),
            myPageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            myPageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            myPageTableView.bottomAnchor.constraint(equalTo: whoWeAreLabel.topAnchor, constant: -.padding.differentHierarchyPadding),
            
            memberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            memberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            memberButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            memberButton.heightAnchor.constraint(equalToConstant: 69),
            
            whoWeAreLabel.bottomAnchor.constraint(equalTo: memberButton.topAnchor, constant: -13),
            whoWeAreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            whoWeAreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
        ])
    }
    
    @objc func goToMembers() {
        self.navigationController!.pushViewController(MembersViewController(), animated: false)
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainLabelArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageTableViewCell.identifier) as? MyPageTableViewCell else { return UITableViewCell() }
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        cell.configure(mainLabel: mainLabelArr[indexPath.section], subLabel: subLabelArr[indexPath.section], mainImage: mainImageArr[indexPath.section], backgroundColor: backgroundArr[indexPath.section])
        return cell
    }
    
    // cell간 간격을 띄우기 위해 indexPath.section과 footer를 활용함
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if let url = URL(string: "https://forms.gle/8Qtdeg5bVqEfxzpKA"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 1:
            if let url = URL(string: "https://forms.gle/fTiDfttXNn6uWw849"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        default:
            print("error")
        }
    }
}
