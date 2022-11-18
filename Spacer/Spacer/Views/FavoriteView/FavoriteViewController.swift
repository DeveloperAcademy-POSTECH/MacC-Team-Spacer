//
//  FavoriteViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {
    let realm = try! Realm()
    // favorite된 카페 수
    var NumberOfFavoriteCafe = 0
    var favoriteCafes: [CafeInfo] = []
    
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
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // realm에 저장된 카페이름을 가진 데이터만을 가지고 와서 favoriteCafes에 추가함
        let storedCafes = realm.objects(FavoriteCafe.self)
        NumberOfFavoriteCafe = storedCafes.count
        for i in storedCafes.indices {
            favoriteCafes.append(contentsOf: (MockManager.shared.getMockData().filter { CafeInfo in
                CafeInfo.name == storedCafes[i].cafeName
            }))
        }
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
        return NumberOfFavoriteCafe
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        //TODO: - 이곳에다가 CafeInfo를 넘겨줌, 코어데이터 혹은 realm으로 저장된 값으로 배열을 불러옴
        cell.configure(with: favoriteCafes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let cafeDetailViewController = CafeDetailViewController()
        cafeDetailViewController.tempCafeInfo = favoriteCafes[indexPath.row]
        self.navigationController?.pushViewController(cafeDetailViewController, animated: true)
    }
}
