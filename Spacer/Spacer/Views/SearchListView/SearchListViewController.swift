//
//  SearchListViewController.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/17.
//

import UIKit

class SearchListViewController: UIViewController {
    
    // 첫번째 검색인지 확인
    var isFirstFiltering = false
    // 태그로 들어온지 확인
    var isTagged = false
    // 태그로 들어와서 서치바를 사용한지 확인
    var usingTagText = false
    
    public var tempCafeArray: [CafeInfo] = [CafeInfo]()
    public var filteredArr: [CafeInfo] = [CafeInfo]()
    // 태그 검색중에서 텍스트로 또 검색하였을 경우 filteredArr를 수정하지 않고 다른 배열로 받아서 보여줌
    public var filteredTagTextArr: [CafeInfo] = [CafeInfo]()
    
    let eventElements = ["컵홀더", "현수막", "액자", "배너", "전시공간", "보틀음료", "맞춤 디저트", "맞춤 영수증", "등신대", "포토 카드", "포토존", "영상 상영"]
    let regions = ["서울","부산"]
    
    // 데이터를 받을 곳
    var startDate: String? = UserDefaults.standard.string(forKey: "firstDate")
    var endDate: String? = UserDefaults.standard.string(forKey: "lastDate")
    var selectedRegion: String? = UserDefaults.standard.string(forKey: "region")
    var selectedEventElement: [Bool]? = UserDefaults.standard.array(forKey: "eventElements") as? [Bool]
    
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
    let eventElementButton = CustomButtonView(frame: .zero)
    
    
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
        scrollView.addSubview(eventElementButton)
        
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
        let myeventElementButtonConstraints = [
            eventElementButton.heightAnchor.constraint(equalToConstant: 39),
            eventElementButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            eventElementButton.leadingAnchor.constraint(equalTo: regionButton.trailingAnchor, constant: 8),
        ]
        
        NSLayoutConstraint.activate(mydateButtonConstraints)
        NSLayoutConstraint.activate(myregionButtonConstraints)
        NSLayoutConstraint.activate(myeventElementButtonConstraints)
        
        dateButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        regionButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        eventElementButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        
        // 받아온 값을 버튼에 적용하기
        var dateTitle: AttributedString
        var regionTitle: AttributedString
        var eventElementTitle: AttributedString
        
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
        if let selectedRegion = selectedRegion {
            regionTitle = AttributedString.init(regions[Int(selectedRegion)!])
            regionTitle.foregroundColor = .grayscale6
            regionButton.configuration?.baseBackgroundColor = .mainPurple3
            regionButton.configuration?.baseForegroundColor = .grayscale5
        } else {
            regionTitle = AttributedString.init("지역")
            regionTitle.foregroundColor = .mainPurple2
        }
        regionButton.configuration?.attributedTitle = regionTitle
        
        // 카테고리
        if let selectedEventElement = selectedEventElement {
            // 1개 이상 true일 경우
            var firsteventElement = ""
            var countTrue = 0
            
            for i in selectedEventElement.indices {
                if selectedEventElement[i] == true {
                    countTrue += 1
                    // 첫 true가 나온 카테고리
                    if countTrue == 1 {
                        firsteventElement = eventElements[i]
                    }
                }
            }
            // true가 2개 이상일 경우 '외 ㅁ개' 표현, true가 1개 일 경우는 eventElement만 나옴, 전부 false인 경우 카테고리
            if countTrue >= 2 {
                eventElementTitle = AttributedString.init("\(firsteventElement) 외 \(countTrue-1)개")
                eventElementTitle.foregroundColor = .grayscale6
                eventElementButton.configuration?.baseBackgroundColor = .mainPurple3
                eventElementButton.configuration?.baseForegroundColor = .grayscale5
            } else if countTrue == 1{
                eventElementTitle = AttributedString.init("\(firsteventElement)")
                eventElementTitle.foregroundColor = .grayscale6
                eventElementButton.configuration?.baseBackgroundColor = .mainPurple3
                eventElementButton.configuration?.baseForegroundColor = .grayscale5
            } else {
                eventElementTitle = AttributedString.init("카테고리")
                eventElementTitle.foregroundColor = .mainPurple2
            }
        } else {
            // 맞춤형 추천이 아닌 기본 상태
            eventElementTitle = AttributedString.init("카테고리")
            eventElementTitle.foregroundColor = .mainPurple2
        }
        eventElementButton.configuration?.attributedTitle = eventElementTitle
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
        if let selectedRegion = selectedRegion, let selectedEventElement = selectedEventElement {
            isTagged = true
            isFirstFiltering = true
            self.filteredArr = MockManager.shared.getMockData().filter({ CafeInfo in
                var iseventElementEnough: Bool = true
                for i in eventElements.indices {
                    // VisualTagView에서 선택한 카테고리 중 카페의 eventElement가 false일 경우 false반환
                    if selectedEventElement[i] {
                        if !CafeInfo.eventElement[i] {
                            iseventElementEnough = false
                        }
                    }
                }
                return CafeInfo.locationID == Int(selectedRegion)! && iseventElementEnough
            })
        } else {
            // 태그로 받아온것이 아니면 tempCafeArray에서 모든 카페 정보를 받아둠
            tempCafeArray = MockManager.shared.getMockData()
        }
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
        UserDefaults.standard.removeObject(forKey: "eventElements")
        UserDefaults.standard.removeObject(forKey: "region")
        UserDefaults.standard.removeObject(forKey: "firstDate")
        UserDefaults.standard.removeObject(forKey: "lastDate")
        isFirstFiltering = false
        super.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bottomLine.backgroundColor = .grayscale4
        
        self.scrollView.contentSize = CGSize(
            width: eventElementButton.bounds.width+dateButton.bounds.width+regionButton.bounds.width,
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
        if isFirstFiltering && filteredArr.count == 0 || usingTagText && filteredTagTextArr.count == 0{
            view.addSubview(emptyLabel)
            emptyLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
            emptyLabel.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            self.emptyLabel.removeFromSuperview()
        }
        return usingTagText ? filteredTagTextArr.count : filteredArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = resultCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        usingTagText ? cell.configure(with: filteredTagTextArr[indexPath.row]) : cell.configure(with: filteredArr[indexPath.row])
        return cell
    }
}

// 스크롤뷰 vertical 고정
extension SearchListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollView.contentOffset.y = 0
    }
}

extension SearchListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        bottomLine.backgroundColor = .mainPurple3
        isFirstFiltering = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        
        if isTagged {
            usingTagText = true
            self.filteredTagTextArr = self.filteredArr.filter({ CafeInfo in
                return CafeInfo.name.localizedCaseInsensitiveContains(text)
            })
        } else {
            self.filteredArr = self.tempCafeArray.filter({ CafeInfo in
                return CafeInfo.name.localizedCaseInsensitiveContains(text)
            })
        }
        // 바로바로 업데이트 되게 만들기
        // self.resultCollectionView.reloadData()
        // bottomLine.backgroundColor = UIColor.red.cgColor
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines){
            if isTagged {
                if text == "" {
                    self.usingTagText = false
                } else {
                    usingTagText = true
                }
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
        self.resultCollectionView.reloadData()
    }
}



