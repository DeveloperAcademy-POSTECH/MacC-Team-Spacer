//
//  SearchListViewController.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/17.
//

import UIKit

class SearchListViewController: UIViewController {
    
    var isFiltering = false
    
    public var tempCafeArray: [CafeInfo] = [CafeInfo]()
    public var filteredArr: [CafeInfo] = [CafeInfo]()
    
    let categories = ["컵홀더", "현수막", "액자", "배너", "전시공간", "보틀음료", "맞춤 디저트", "맞춤 영수증", "등신대", "포토 카드", "포토존", "영상 상영"]
    let regions = ["서울","부산"]
    
    // 데이터를 받을 곳
    var startDate: String? = UserDefaults.standard.string(forKey: "firstDate")
    var endDate: String? = UserDefaults.standard.string(forKey: "lastDate")
    var tempRegion: String? = UserDefaults.standard.string(forKey: "map")
    var tempCategory: [Bool]? = UserDefaults.standard.array(forKey: "categories") as? [Bool]
    
    let searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.searchBarStyle = .minimal
        search.placeholder = "카페 이름을 입력해주세요"
        // 텍스트 필드 내 좌측 돋보기 삭제
        search.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        // 텍스트 필드 내 우측 x 삭제
        search.setImage(UIImage(), for: .clear, state: .normal)
        search.showsCancelButton = false
        if let textfield = search.value(forKey: "searchField") as? UITextField {
            textfield.borderStyle = .none
        }
        return search
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: 67, height: 39)
        return scrollView
    }()
    
    
    let dateButton = CustomButtonView(frame: .zero)
    let regionButton = CustomButtonView(frame: .zero)
    let categoryButton = CustomButtonView(frame: .zero)
    
    
    // 검색 결과 컬렉션 뷰
    var resultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 173, height: 193)
        layout.minimumLineSpacing = .padding.betweenContentsPadding
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: .padding.margin, bottom: .padding.betweenContentsPadding, right: .padding.margin)
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // 검색 결과가 없을 경우 뜨는 뷰
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.font = .systemFont(for: .body1)
        label.textColor = .grayscale3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        view.backgroundColor = .white
        
        self.navigationItem.titleView = searchBar
        
        setButton()
        setCollectionView()
        setSearchBar()
        setCafeData()
        
        // 모든 경우에서 키보드를 내리기 위해서 터치인식 적용
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        emptyLabel.isUserInteractionEnabled = true
        emptyLabel.addGestureRecognizer(tap)
        resultCollectionView.isUserInteractionEnabled = true
        resultCollectionView.addGestureRecognizer(tap)
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        // 네비게이션 바 밑줄
        appearance.shadowColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        // 스크롤 뷰 오직 가로로만 움직이게 하기
        scrollView.delegate = self
        
        searchBar.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.topAnchor.constraint(equalTo: searchBar.bottomAnchor , constant: -10),
            bottomLine.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor,constant: 60),
            bottomLine.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -55),
            bottomLine.heightAnchor.constraint(equalToConstant: 3),
        ])
    }
    
    func setButton() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(dateButton)
        scrollView.addSubview(regionButton)
        scrollView.addSubview(categoryButton)
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .padding.underTitlePadding),
            scrollView.heightAnchor.constraint(equalToConstant: 39),
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        let mydateButtonConstraints = [
            dateButton.heightAnchor.constraint(equalToConstant: 39),
            dateButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            dateButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
        ]
        let myregionButtonConstraints = [
            regionButton.heightAnchor.constraint(equalToConstant: 39),
            regionButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            regionButton.leadingAnchor.constraint(equalTo: dateButton.trailingAnchor, constant: 8),
        ]
        let mycategoryButtonConstraints = [
            categoryButton.heightAnchor.constraint(equalToConstant: 39),
            categoryButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: regionButton.trailingAnchor, constant: 8),
        ]
        
        NSLayoutConstraint.activate(mydateButtonConstraints)
        NSLayoutConstraint.activate(myregionButtonConstraints)
        NSLayoutConstraint.activate(mycategoryButtonConstraints)
        
        dateButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        regionButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        
        // 받아온 값을 버튼에 적용하기
        var dateTitle: AttributedString
        var regionTitle: AttributedString
        var categoryTitle: AttributedString
        
        // 날짜
        if let startDate = startDate, let endDate = endDate {
            dateTitle = AttributedString.init("\(startDate) - \(endDate)")
            dateTitle.foregroundColor = .grayscale6
            dateButton.configuration?.baseBackgroundColor = .mainPurple3
            dateButton.configuration?.baseForegroundColor = .grayscale5
        } else {
            dateTitle = AttributedString.init("날짜")
            dateTitle.foregroundColor = .mainPurple2
        }
        dateButton.configuration?.attributedTitle = dateTitle
        
        // 지역
        if let tempRegion = tempRegion {
            regionTitle = AttributedString.init(regions[Int(tempRegion)!])
            regionTitle.foregroundColor = .grayscale6
            regionButton.configuration?.baseBackgroundColor = .mainPurple3
            regionButton.configuration?.baseForegroundColor = .grayscale5
        } else {
            regionTitle = AttributedString.init("지역")
            regionTitle.foregroundColor = .mainPurple2
        }
        regionButton.configuration?.attributedTitle = regionTitle
        
        // 카테고리
        if let tempCategory = tempCategory {
            // 1개 이상 true일 경우
            var firstCategory = ""
            var countTrue = 0
            if tempCategory.contains(true) {
                for i in tempCategory.indices {
                    if tempCategory[i] == true {
                        countTrue += 1
                        // 첫 true가 나온 카테고리
                        if countTrue == 1 {
                            firstCategory = categories[i]
                        }
                    }
                }
                // true가 2개 이상일 경우 '외 ㅁ개' 표현, true가 1개 일 경우는 카테고리만 나옴
                if countTrue >= 2 {
                    categoryTitle = AttributedString.init("\(firstCategory) 외 \(countTrue-1)개")
                } else {
                    categoryTitle = AttributedString.init("\(firstCategory)")
                }
                
                categoryTitle.foregroundColor = .grayscale6
                categoryButton.configuration?.baseBackgroundColor = .mainPurple3
                categoryButton.configuration?.baseForegroundColor = .grayscale5
            } else {
                // 전부 false일 때
                categoryTitle = AttributedString.init("카테고리")
                categoryTitle.foregroundColor = .mainPurple2
            }
        } else {
            // 맞춤형 추천이 아닌 기본 상태
            categoryTitle = AttributedString.init("카테고리")
            categoryTitle.foregroundColor = .mainPurple2
        }
        categoryButton.configuration?.attributedTitle = categoryTitle
    }
    
    func setCollectionView() {
        view.addSubview(resultCollectionView)
        
        let resultCollectionViewConstraints = [
            resultCollectionView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            resultCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resultCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultCollectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: .padding.startHierarchyPadding)
        ]
        
        NSLayoutConstraint.activate(resultCollectionViewConstraints)
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
    }
    
    func setSearchBar() {
        let searchIcon = UIBarButtonItem(systemItem: .search, primaryAction: UIAction(handler: { _ in
            self.searchBar.endEditing(true)
            DispatchQueue.main.async {
                self.resultCollectionView.reloadData()
            }
        }))
        
        let backIcon = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(backButtonTapped))
        if let textfield = self.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .clear
            // 플레이스홀더 색
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
            // 텍스트 색
            textfield.textColor = UIColor.gray
        }
        self.navigationItem.leftBarButtonItem = backIcon
        self.navigationItem.rightBarButtonItem = searchIcon
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        searchBar.delegate = self
    }
    
    func setCafeData() {
        // CafeInfo는 받아온 개별 카페
        self.filteredArr = MockManager.shared.getMockData().filter({ CafeInfo in
            if let tempRegion = tempRegion, let tempCategory = tempCategory {
                isFiltering = true
                //TODO: - 지역으로 분류는 가능하지만 카테고리를 포함한 값을 내는걸 알아내야함
                return CafeInfo.locationID == Int(tempRegion)!
            } else {
                return true
            }
        })
    }
    
    // 화면 터치하여 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = .grayscale4
        self.resultCollectionView.reloadData()
    }
    
    // 화면 스크롤할 경우도 키보드 내리기
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = .grayscale4
        self.resultCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.removeObject(forKey: "categories")
        UserDefaults.standard.removeObject(forKey: "map")
        UserDefaults.standard.removeObject(forKey: "firstDate")
        UserDefaults.standard.removeObject(forKey: "lastDate")
        super.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bottomLine.backgroundColor = .grayscale4
        
        self.scrollView.contentSize = CGSize(
            width: categoryButton.bounds.width+dateButton.bounds.width+regionButton.bounds.width,
            height: view.bounds.height*0.055
        )
    }
    
    // 키보드 내리기 함수
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = .grayscale4
    }
    
    // 뒤로 가기 함수
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 다음뷰로 이동하는 함수
    @objc func moveTo() {
        let birthdayCafeViewController = BirthdayCafeViewController()
        show(birthdayCafeViewController, sender: nil)
        
    }
}

extension SearchListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering && filteredArr.count == 0 { // 화면 바로 가자마자 문구가 필요하다면 "|| tempCafeArray.count == 0" 부분추가
            view.addSubview(emptyLabel)
            emptyLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
            emptyLabel.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            self.emptyLabel.removeFromSuperview()
        }
        return isFiltering ? filteredArr.count : tempCafeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = resultCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        isFiltering ? cell.configure(with: filteredArr[indexPath.row]) : cell.configure(with: tempCafeArray[indexPath.row])
        return cell
    }
}

// 스크롤뷰 vertical 고정
extension SearchListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollView.contentOffset.y = 0
    }
}
// RED는 검색중, blue는 일반
extension SearchListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        bottomLine.backgroundColor = .mainPurple3
        self.isFiltering = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        self.filteredArr = self.tempCafeArray.filter({ CafeInfo in
            return CafeInfo.name.localizedCaseInsensitiveContains(text)
        })
        if text == "" {
            self.isFiltering = false
        } else {
            self.isFiltering = true
        }
        // 바로바로 업데이트 되게 만들기
        // self.resultCollectionView.reloadData()
        // bottomLine.backgroundColor = UIColor.red.cgColor
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines){
            if text == "" {
                self.isFiltering = false
            } else {
                self.isFiltering = true
            }
        }
        self.resultCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.resultCollectionView.reloadData()
        bottomLine.backgroundColor = .mainPurple3
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.isFiltering = false
        self.resultCollectionView.reloadData()
    }
}



