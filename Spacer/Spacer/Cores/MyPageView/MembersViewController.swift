//
//  MembersViewController.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/22.
//

import UIKit

class MembersViewController: UIViewController {
    
    let backgroundColorArr = [
        UIColor(red: 255/255, green: 241/255, blue: 241/255, alpha: 1),
        UIColor(red: 234/255, green: 239/255, blue: 255/255, alpha: 1),
        UIColor(red: 255/255, green: 248/255, blue: 225/255, alpha: 1),
        UIColor(red: 227/255, green: 248/255, blue: 224/255, alpha: 1),
        UIColor(red: 238/255, green: 232/255, blue: 255/255, alpha: 1)
    ]
    let memberImageArr = ["hoaxer", "rang", "ocean", "anders", "sasha"]
    let memberNameArr = ["Hyungseo Han", "Eunbi Han", "Dasol Hur", "Boseung Kim", "Seyoung Choi"]
    let memberPositionArr = ["iOS / Backend Developer", "iOS Developer", "iOS Developer", "Product Manager", "UX / UI Designer"]
    let firstLabelArr = ["shorelinesquare@gmail.com", "0b_b0@naver.com", "hurdasol@naver.com", "kbs2047@gmail.com", "erabhre@gmail.com"]
    let secondIconArr = ["githubIcon", "githubIcon", "githubIcon", "linkedInIcon", "linkedInIcon"]
    let secondLabelArr = ["greathoaxer", "bee712", "hurdasol98", "김보승", "최세영"]
    let memberURLArr = ["https://github.com/GREATHOAXER", "https://github.com/bee712", "https://github.com/hurdasol98", "https://www.linkedin.com/in/%EB%B3%B4%EC%8A%B9-%EA%B9%80-a999b1242/", "https://www.linkedin.com/in/seyoung-choi-48b451257/"]
    
    lazy var memberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.sectionInset = .init(top: 12, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "이런 사람들입니다"
        self.navigationController?.navigationBar.tintColor = .mainPurple1
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearanceSetup()
        setup()
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
    }
    
    func appearanceSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setup() {
        view.addSubview(memberCollectionView)
        NSLayoutConstraint.activate([
            memberCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            memberCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            memberCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            memberCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MembersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as? MemberCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(
            backgroundColor: backgroundColorArr[indexPath.item],
            memberImage: memberImageArr[indexPath.item],
            memberName: memberNameArr[indexPath.item],
            memberPosition: memberPositionArr[indexPath.item],
            firstLabel: firstLabelArr[indexPath.item],
            secondIcon: secondIconArr[indexPath.item],
            secondLabel: secondLabelArr[indexPath.item]
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let url = URL(string: memberURLArr[indexPath.item]), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
