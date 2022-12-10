//
//  FavoriteViewController.swift
//  Spacer
//
//  Created by Eunbi Han on 2022/10/11.
//

import UIKit
import RealmSwift

struct FavoriteURLCafeInfo {
    let cafeName: String
    let cafeAddress: String
    let cafeImageURL: String
    let memo: String
    let cafeURL: String
}

class FavoriteViewController: UIViewController {
    
    let realm = try! Realm()
    // favorite된 카페 수
    var NumberOfFavoriteCafe = 0
    var favoriteCafes: [Cafeinfo] = []
    private var favoriteURLCafeInfos: [FavoriteURLCafeInfo] = []
    private var thumbnailImageInfos: [CafeThumbnailImage] = [CafeThumbnailImage]()
    
    lazy var countLabel : UILabel = {
        let label = UILabel()
        label.text = "찜한 카페 0개"
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var linkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "LinkURL")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .padding.betweenContentsPadding
        layout.itemSize = CGSize(width: 173, height: 193)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 4, left: .padding.margin, bottom: .padding.betweenContentsPadding-4, right: .padding.margin)
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavBar()
        setup()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
        
        // 한 번 배열에 값을 append한 후 초기화해주는 코드가 없어서 발생한 잘못된 카페 정보를 받아오는 문제 해결
        NumberOfFavoriteCafe = 0
        favoriteCafes = []
        favoriteURLCafeInfos = []
        thumbnailImageInfos = []
        
        Task {
            // realm에 url을 이용해 저장된 카페 정보 favoriteURLCafeInfos에 추가
            let stroedURLCafe = realm.objects(FavoriteURLCafe.self)
            for urlCafe in stroedURLCafe {
                let urlCafeInfo = FavoriteURLCafeInfo(cafeName: urlCafe.cafeName, cafeAddress: urlCafe.cafeAddress, cafeImageURL: urlCafe.cafeImageURL, memo: urlCafe.memo, cafeURL: urlCafe.cafeURL)
                favoriteURLCafeInfos.append(urlCafeInfo)
            }
            NumberOfFavoriteCafe += favoriteURLCafeInfos.count
            
            // realm에 저장된 카페이름을 가진 데이터만을 가지고 와서 favoriteCafes에 추가함
            let storedCafes = realm.objects(FavoriteCafe.self)
            NumberOfFavoriteCafe += storedCafes.count
            
            countLabel.text = "찜한 카페 \(NumberOfFavoriteCafe)개"

            let allCafeData = try await APICaller.requestGetData(url: "/cafeinfo/", dataType: [Cafeinfo].self) as! [Cafeinfo]

            for i in storedCafes.indices {
                favoriteCafes.append(contentsOf: (allCafeData.filter { CafeInfo in
                    CafeInfo.cafeName == storedCafes[i].cafeName
                }))
            }
            
            for data in favoriteCafes {
                var thumbnailImageInfo: CafeThumbnailImage
                
                // 각 카페 별 썸네일 이미지 url 요청하고 데이터가 없을 경우 기본 이미지로 썸네일 이미지 대체
                do {
                    thumbnailImageInfo = try await APICaller.requestGetData(url: "/static/getfirstimage/\(data.cafeID)", dataType: CafeThumbnailImage.self) as! CafeThumbnailImage
                    thumbnailImageInfos.append(thumbnailImageInfo)
                } catch {
                    thumbnailImageInfos.append(CafeThumbnailImage(cafeImageUrl: "http://158.247.222.189:12232/static/images/6693852c64b011ed94ba0242ac110003/cafeId3_img_001.jpg", imageCategory: "", imageProductSize: ""))
                }
            }
            favoriteCollectionView.reloadData()
            //TODO: - countLabel의 text에 개수를 업데이트 해야함
        }
        tabBarController?.tabBar.isHidden = false
    }
    
    func setNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.grayscale1]
        appearance.shadowColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        let myFavorite = UIBarButtonItem(image: UIImage(named: "MyFavorite")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        myFavorite.isEnabled = false
        self.navigationItem.leftBarButtonItem = myFavorite
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.mainPurple1
    }
    
    func setup() {
        view.addSubview(countLabel)
        view.addSubview(linkButton)
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            countLabel.widthAnchor.constraint(equalToConstant: 80),
            countLabel.heightAnchor.constraint(equalToConstant: 17),
            
            linkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            linkButton.centerYAnchor.constraint(equalTo: countLabel.centerYAnchor),
            linkButton.widthAnchor.constraint(equalToConstant: 40),
            linkButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
    }
    
    func setCollectionView() {
        view.addSubview(favoriteCollectionView)
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: .padding.startHierarchyPadding-4),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    
    @objc func linkButtonTapped() {
        let addCafeURLViewController = AddCafeURLViewController()
        addCafeURLViewController.getDataFromModalDelegate = self
        self.present(addCafeURLViewController, animated: true)
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfFavoriteCafe
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row < favoriteURLCafeInfos.count {
            cell.configure(with: favoriteURLCafeInfos[indexPath.row])
        } else {
            // TODO: 빠르게 탭 왔다갔다하면 index error 생김
            print(indexPath.row, favoriteURLCafeInfos.count, indexPath.row - favoriteURLCafeInfos.count, favoriteCafes.count)
            cell.configure(with: favoriteCafes[indexPath.row - favoriteURLCafeInfos.count], imageURL: thumbnailImageInfos[indexPath.row - favoriteURLCafeInfos.count].cafeImageUrl)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        if indexPath.row < favoriteURLCafeInfos.count {
            let urlCafeDetailViewController = URLCafeDetailView()
            urlCafeDetailViewController.urlCafeData = favoriteURLCafeInfos[indexPath.row]
            self.navigationController?.pushViewController(urlCafeDetailViewController, animated: true)
        } else {
            let cafeDetailViewController = CafeDetailViewController()
            cafeDetailViewController.cafeData = favoriteCafes[indexPath.row - favoriteURLCafeInfos.count]
            self.navigationController?.pushViewController(cafeDetailViewController, animated: true)
        }
    }
}

// AddCafeURLView에서 값을 불러오는 방법 1. local에 저장(realm) 2.해당 프로토콜 사용
extension FavoriteViewController: GetDataFromModalDelegate {
    func getData(data: Data) {
        print(data)
    }
}
