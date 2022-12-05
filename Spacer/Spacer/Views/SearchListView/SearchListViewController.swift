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
    
    // 카페 데이터 및 필터링된 데이터를 저장
    private var cafeDatas: [Cafeinfo] = [Cafeinfo]()
    private var filteredArray: [Cafeinfo] = [Cafeinfo]()
    private var filteredTagTextArray: [Cafeinfo] = [Cafeinfo]()
    
    // 카페 썸네일과 필터링된 카페의 썸네일 이미지 url 저장
    private var thumbnailImageInfos: [CafeThumbnailImage] = [CafeThumbnailImage]()
    private var filteredThumbnailImages: [CafeThumbnailImage] = [CafeThumbnailImage]()
    
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
        collectionView.contentInset = UIEdgeInsets(top: 4, left: .padding.margin, bottom: .padding.betweenContentsPadding-4, right: .padding.margin)
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
        
        title = ""
        view.backgroundColor = .white
        
        self.navigationItem.titleView = searchBar
        
        setButton()
        setCollectionView()
        setSearchBar()
        
        // 모든 경우에서 키보드를 내리기 위해서 터치인식 적용
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        emptyLabel.isUserInteractionEnabled = true
        emptyLabel.addGestureRecognizer(tap)
        
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
    
    private func loadThumbnailImages(cafeDats: [Cafeinfo]) {
        Task {
            for data in cafeDats {
                var thumbnailImageInfo: CafeThumbnailImage
                
                // 각 카페 별 썸네일 이미지 url 요청하고 데이터가 없을 경우 기본 이미지로 썸네일 이미지 대체
                do {
                    thumbnailImageInfo = try await APICaller.requestGetData(url: "/static/getfirstimage/\(data.cafeID)", dataType: CafeThumbnailImage.self) as! CafeThumbnailImage
                    thumbnailImageInfos.append(thumbnailImageInfo)
                } catch {
                    thumbnailImageInfos.append(CafeThumbnailImage(cafeImageUrl: "http://158.247.222.189:12232/static/images/6693852c64b011ed94ba0242ac110003/cafeId3_img_001.jpg", imageCategory: "", imageProductSize: ""))
                }
            }
            
            filteredThumbnailImages = thumbnailImageInfos
            resultCollectionView.reloadData()
        }
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
        
        let dateButtonConstraints = [
            dateButton.heightAnchor.constraint(equalToConstant: 39),
            dateButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            dateButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
        ]
        let regionButtonConstraints = [
            regionButton.heightAnchor.constraint(equalToConstant: 39),
            regionButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            regionButton.leadingAnchor.constraint(equalTo: dateButton.trailingAnchor, constant: 8),
        ]
        let eventElementButtonConstraints = [
            eventElementButton.heightAnchor.constraint(equalToConstant: 39),
            eventElementButton.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            eventElementButton.leadingAnchor.constraint(equalTo: regionButton.trailingAnchor, constant: 8),
        ]
        
        NSLayoutConstraint.activate(dateButtonConstraints)
        NSLayoutConstraint.activate(regionButtonConstraints)
        NSLayoutConstraint.activate(eventElementButtonConstraints)
        
        dateButton.addTarget(self, action: #selector(goToSimpleTagView), for: .touchUpInside)
        regionButton.addTarget(self, action: #selector(goToSimpleTagView), for: .touchUpInside)
        eventElementButton.addTarget(self, action: #selector(goToSimpleTagView), for: .touchUpInside)
    }
    
    func buttonTitleUpdate() {
        startDate = UserDefaults.standard.string(forKey: "firstDate")
        endDate = UserDefaults.standard.string(forKey: "lastDate")
        selectedRegion = UserDefaults.standard.string(forKey: "region")
        selectedEventElement = UserDefaults.standard.array(forKey: "eventElements") as? [Bool]
        // 받아온 값을 버튼에 적용하기
        var dateTitle: AttributedString
        var regionTitle: AttributedString
        var eventElementTitle: AttributedString
        
        // 날짜
        if let startDate = startDate, let endDate = endDate {
            let startDateSlice = startDate.components(separatedBy: ". ")
            let shortStartDate = "\(startDateSlice[1])/\(startDateSlice[2])"
            let endDateSlice = endDate.components(separatedBy: ". ")
            let shortEndDate = "\(endDateSlice[1])/\(endDateSlice[2])"
            dateTitle = AttributedString.init("\(shortStartDate) - \(shortEndDate)")
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
            regionTitle = AttributedString.init(regions[Int(selectedRegion)! - 1])
            regionTitle.foregroundColor = .grayscale7
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
                eventElementTitle.foregroundColor = .grayscale7
                eventElementButton.configuration?.baseBackgroundColor = .mainPurple3
                eventElementButton.configuration?.baseForegroundColor = .grayscale5
            } else if countTrue == 1 {
                eventElementTitle = AttributedString.init("\(firsteventElement)")
                eventElementTitle.foregroundColor = .grayscale7
                eventElementButton.configuration?.baseBackgroundColor = .mainPurple3
                eventElementButton.configuration?.baseForegroundColor = .grayscale5
            } else {
                eventElementTitle = AttributedString.init("카테고리")
                eventElementTitle.foregroundColor = .mainPurple2
                eventElementButton.configuration?.baseBackgroundColor = .mainPurple6
                eventElementButton.configuration?.baseForegroundColor = .mainPurple2
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
            resultCollectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: .padding.startHierarchyPadding-4)
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
        
        let backIcon = UIBarButtonItem(image: UIImage(named: "BackButton"), style: .done, target: self, action: #selector(backButtonTapped))
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
            // 필터 중 지역과 이벤트 요소 가능 여부 두 가지가 선택되었을 경우
            
            isTagged = true
            isFirstFiltering = true
            
            Task {
                let allCafeData = try await APICaller.requestGetData(url: "/cafeinfo/", dataType: [Cafeinfo].self) as! [Cafeinfo]   // 모든 카페 정보 불러와 저장
                var eventElementGroups = [[Bool]]() // 모든 카페의 이벤트 요소 가능 여부를 저장할 배열
                
                // 각 카페의 이벤트 요소 가능 여부를 불러와 eventElementGroups에 추가
                for cafeData in allCafeData {
                    let elementData = try await APICaller.requestGetData(url: "/cafeFeature/\(cafeData.cafeID)", dataType: CafeEventElement.self) as! CafeEventElement
                    var elementsInfo: [Bool] = [Bool]()
                    
                    // 각 이벤트 요소의 가능 여부를 배열로 저장
                    elementsInfo.append(elementData.cupHolder != 0)
                    elementsInfo.append(elementData.standBanner != 0)
                    elementsInfo.append(elementData.photoFrame != 0)
                    elementsInfo.append(elementData.banner != 0)
                    elementsInfo.append(elementData.displaySpace != 0)
                    elementsInfo.append(elementData.bottleDrink != 0)
                    elementsInfo.append(elementData.customDesert != 0)
                    elementsInfo.append(elementData.customReceipt != 0)
                    elementsInfo.append(elementData.cutOut != 0)
                    elementsInfo.append(elementData.displayVideo != 0)
                    elementsInfo.append(elementData.photoCard != 0)
                    elementsInfo.append(elementData.photoZone != 0)
                    
                    eventElementGroups.append(elementsInfo)
                }
                
                // 필터링 된 카페 목록을 filteredArray에 저장
                self.filteredArray = allCafeData.enumerated().filter ({ (index, cafeData) -> Bool in
                    var isEventElementEnough: Bool = true
                    
                    // 각 카페 데이터 중 가능한 이벤트요소가 불일치할 경우 isEventElementEnough에 false 저장 후 for문 나감
                    for i in eventElementGroups[0].indices {
                        if selectedEventElement[i] && !eventElementGroups[index][i] {
                            isEventElementEnough = false
                            break
                        }
                    }
                    
                    return cafeData.cafeLocation == Int(selectedRegion)! && isEventElementEnough
                }).map { (index, cafeData) -> Cafeinfo in
                    // index를 추가해 변환한 배열을 다시 index없이 cafeData만 저장
                    cafeData
                }
                
                loadThumbnailImages(cafeDats: filteredArray)
                
            }
            
        } else if let selectedEventElement = selectedEventElement {
            // 필터 중 이벤트 요소 가능 여부만 선택되었을 경우
            
            isTagged = true
            isFirstFiltering = true
            
            Task {
                let allCafeData = try await APICaller.requestGetData(url: "/cafeinfo/", dataType: [Cafeinfo].self) as! [Cafeinfo]
                var eventElementGroups = [[Bool]]()
                
                for cafeData in allCafeData {
                    let elementData = try await APICaller.requestGetData(url: "/cafeFeature/\(cafeData.cafeID)", dataType: CafeEventElement.self) as! CafeEventElement
                    var elementsInfo: [Bool] = [Bool]()
                    
                    elementsInfo.append(elementData.cupHolder != 0)
                    elementsInfo.append(elementData.standBanner != 0)
                    elementsInfo.append(elementData.photoFrame != 0)
                    elementsInfo.append(elementData.banner != 0)
                    elementsInfo.append(elementData.displaySpace != 0)
                    elementsInfo.append(elementData.bottleDrink != 0)
                    elementsInfo.append(elementData.customDesert != 0)
                    elementsInfo.append(elementData.customReceipt != 0)
                    elementsInfo.append(elementData.cutOut != 0)
                    elementsInfo.append(elementData.displayVideo != 0)
                    elementsInfo.append(elementData.photoCard != 0)
                    elementsInfo.append(elementData.photoZone != 0)
                    
                    eventElementGroups.append(elementsInfo)
                }
                
                self.filteredArray = allCafeData.enumerated().filter ({ (index, cafeData) -> Bool in
                    var isEventElementEnough: Bool = true
                    
                    for i in eventElementGroups[0].indices {
                        if selectedEventElement[i] && !eventElementGroups[index][i] {
                            isEventElementEnough = false
                            break
                        }
                    }
                    return isEventElementEnough
                }).map { (index, cafeData) -> Cafeinfo in
                    cafeData
                }
                
                loadThumbnailImages(cafeDats: filteredArray)
            }
            
        } else {
            // BirthdayCafeView에서 검색 버튼을 눌렀을 때 카페 전체 목록 불러옴
            Task {
                cafeDatas = try await APICaller.requestGetData(url: "/cafeinfo/", dataType: [Cafeinfo].self) as! [Cafeinfo]
                loadThumbnailImages(cafeDats: cafeDatas)
            }
        }
        resultCollectionView.reloadData()
    }
    
    // 화면 터치하여 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = .grayscale4
    }
    
    // 화면 스크롤할 경우도 키보드 내리기
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = .grayscale4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.interactivePopIsEnable(true)
        
        buttonTitleUpdate()
        setCafeData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bottomLine.backgroundColor = .grayscale4
        
        self.scrollView.contentSize = CGSize(
            width: eventElementButton.bounds.width+dateButton.bounds.width+regionButton.bounds.width + 48,
            height: .zero
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
        UserDefaults.standard.removeObject(forKey: "eventElements")
        UserDefaults.standard.removeObject(forKey: "region")
        UserDefaults.standard.removeObject(forKey: "firstDate")
        UserDefaults.standard.removeObject(forKey: "lastDate")
        isFirstFiltering = false
    }
    
    // 다음뷰로 이동하는 함수
    @objc func goToSimpleTagView() {
        let simpleTagViewController = SimpleTagViewController()
        simpleTagViewController.modalPresentationStyle = .fullScreen
        self.present(simpleTagViewController, animated: true, completion: nil)
    }
}

extension SearchListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFirstFiltering && filteredArray.count == 0 || usingTagText && filteredTagTextArray.count == 0 {
            view.addSubview(emptyLabel)
            NSLayoutConstraint.activate([
                emptyLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
                emptyLabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
                emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            self.emptyLabel.removeFromSuperview()
        }
        return usingTagText ? filteredTagTextArray.count : filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = resultCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell()
        }
        usingTagText ? cell.configure(with: filteredTagTextArray[indexPath.row], imageURL: filteredThumbnailImages[indexPath.row].cafeImageUrl) : cell.configure(with: filteredArray[indexPath.row], imageURL: filteredThumbnailImages[indexPath.row].cafeImageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cafeDetailViewController = CafeDetailViewController()
        cafeDetailViewController.cafeData = usingTagText ? filteredTagTextArray[indexPath.row]: filteredArray[indexPath.row]
        self.navigationController?.pushViewController(cafeDetailViewController, animated: true)
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
            
            // filteredArray와 thumbnailImageInfos를 필터링하기 위한 인덱스 및 임시 배열
            var tempfilteredCafeDatas: [Cafeinfo] = [Cafeinfo]()
            var tempfilteredImages: [CafeThumbnailImage] = [CafeThumbnailImage]()
            
            for (index, cafeData) in filteredArray.enumerated() {
                // 서치바로 입력한 텍스트와 일치하는 이름의 카페
                if cafeData.cafeName.localizedCaseInsensitiveContains(text) {
                    tempfilteredCafeDatas.append(cafeData)      // 해당 카페 인덱스의 카페 정보 배열에 추가
                    tempfilteredImages.append(thumbnailImageInfos[index])   // 해당 카페 인덱스의 썸네일 이름 배열에 추가
                }
            }
            
            // 서치바로 필터링된 카페 정보와 썸네일 배열에 저장
            filteredTagTextArray = tempfilteredCafeDatas
            filteredThumbnailImages = tempfilteredImages
        } else {
            var tempfilteredCafeDatas: [Cafeinfo] = [Cafeinfo]()
            var tempfilteredImages: [CafeThumbnailImage] = [CafeThumbnailImage]()
            
            for (index, cafeData) in cafeDatas.enumerated() {
                if cafeData.cafeName.localizedCaseInsensitiveContains(text) {
                    tempfilteredCafeDatas.append(cafeData)
                    tempfilteredImages.append(thumbnailImageInfos[index])
                }
            }
            
            filteredArray = tempfilteredCafeDatas
            filteredThumbnailImages = tempfilteredImages
        }
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.resultCollectionView.reloadData()
        bottomLine.backgroundColor = .mainPurple3
    }
    
}
