//
//  FavoriteViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    lazy var favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .padding.betweenContentsPadding
        layout.itemSize = CGSize(width: 173, height: 193)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .red
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavBar()
        setCollectionView()
    }
    
    func setNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "내 보관함"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.grayscale1]
        appearance.shadowColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        let backIcon = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .done, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backIcon
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.mainPurple1
    }
    
    func setCollectionView() {
        view.addSubview(favoriteCollectionView)
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .padding.startHierarchyPadding),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            favoriteCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    
    // 뒤로 가기 함수
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        //TODO: - 이곳에다가 CafeInfo를 넘겨줌, 코어데이터 혹은 realm으로 저장된 값으로 배열을 불러옴
//        cell.configure(with: <#T##CafeInfo#>)
        return cell
    }
    
    
}
