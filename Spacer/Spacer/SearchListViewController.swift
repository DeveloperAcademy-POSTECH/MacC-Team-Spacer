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
    public var filterredArr: [CafeInfo] = [CafeInfo]()
    
    // 데이터를 받을 곳
    var startDate: String? = "10/16"
    var endDate: String? = "10/18"
    var tempDate: String?
    var tempRegion: String?
    var tempTarget: [String?] = ["아이돌","배우","캐릭터"]
    var tempPeople: String?
    
    let searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.searchBarStyle = .minimal
        search.placeholder = "카페 이름을 입력해주세요"
        // 텍스트 필드 내 좌측 돋보기 삭제
        search.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        // 텍스트 필드 내 우측 x 삭제
        search.setImage(UIImage(), for: .clear, state: .normal)
        search.showsCancelButton = false
        search.sizeToFit()
        return search
    }()
    
    let bottomLine = CALayer()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    
    let dateButton = CustomButtonView(frame: .zero)
    let regionButton = CustomButtonView(frame: .zero)
    let targetButton = CustomButtonView(frame: .zero)
    let peopleButton = CustomButtonView(frame: .zero)
    
    // 검색 결과 컬렉션 뷰
    var resultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 164, height: 194)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // 검색 결과가 없을 경우 뜨는 뷰
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.layer.opacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchBar
        setCollectionView()
        setSearchBar()
        setButton()
        
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
        
        
    }
    
    func setButton() {
        view.addSubview(scrollView)
        scrollView.addSubview(dateButton)
        scrollView.addSubview(regionButton)
        scrollView.addSubview(targetButton)
        scrollView.addSubview(peopleButton)
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: resultCollectionView.topAnchor,constant: view.bounds.height*0.005),
            scrollView.heightAnchor.constraint(equalToConstant: view.bounds.height*0.055),
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        let mydateButtonConstraints = [
            dateButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.045),
            dateButton.bottomAnchor.constraint(equalTo: resultCollectionView.topAnchor, constant: 0),
            dateButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 8),
        ]
        let myregionButtonConstraints = [
            regionButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.045),
            regionButton.bottomAnchor.constraint(equalTo: resultCollectionView.topAnchor, constant: 0),
            regionButton.leadingAnchor.constraint(equalTo: dateButton.trailingAnchor, constant: 8),
        ]
        let mytargetButtonConstraints = [
            targetButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.045),
            targetButton.bottomAnchor.constraint(equalTo: resultCollectionView.topAnchor, constant: 0),
            targetButton.leadingAnchor.constraint(equalTo: regionButton.trailingAnchor, constant: 8),
        ]
        let mypeopleButtonConstraints = [
            peopleButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.045),
            peopleButton.bottomAnchor.constraint(equalTo: resultCollectionView.topAnchor, constant: 0),
            peopleButton.leadingAnchor.constraint(equalTo: targetButton.trailingAnchor, constant: 8),
        ]
        
        NSLayoutConstraint.activate(mydateButtonConstraints)
        NSLayoutConstraint.activate(myregionButtonConstraints)
        NSLayoutConstraint.activate(mytargetButtonConstraints)
        NSLayoutConstraint.activate(mypeopleButtonConstraints)
        
        dateButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        regionButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        targetButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        peopleButton.addTarget(self, action: #selector(moveTo), for: .touchUpInside)
        
        // 받아온 값을 버튼에 적용하기
        var dateTitle: AttributedString
        var regionTitle: AttributedString
        var targetTitle: AttributedString
        var peopleTitle: AttributedString
        
        if let startDate = startDate, let endDate = endDate {
            tempDate = "\(startDate) ~ \(endDate)"
        }
        
        if let tempDate = tempDate {
            dateTitle = AttributedString.init(tempDate)
            dateTitle.foregroundColor = .white
            dateButton.configuration?.baseBackgroundColor = UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1.0)
            dateButton.configuration?.baseForegroundColor = .white
        } else {
            dateTitle = AttributedString.init("날짜")
            dateTitle.foregroundColor = UIColor(red: 79/255, green: 50/255, blue: 194/255, alpha: 1.0)
        }
        dateButton.configuration?.attributedTitle = dateTitle
        
        if let tempRegion = tempRegion {
            regionTitle = AttributedString.init(tempRegion)
            regionTitle.foregroundColor = .white//UIColor(red: 79/255, green: 50/255, blue: 194/255, alpha: 1.0)
            regionButton.configuration?.baseBackgroundColor = UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1.0)
            regionButton.configuration?.baseForegroundColor = .white
        } else {
            regionTitle = AttributedString.init("지역")
            regionTitle.foregroundColor = UIColor(red: 79/255, green: 50/255, blue: 194/255, alpha: 1.0)
        }
        regionButton.configuration?.attributedTitle = regionTitle
        
        
        // 중복된 코드 정리가 필요함
        switch tempTarget.count {
        case 0:
            targetTitle = AttributedString.init("대상")
            targetTitle.foregroundColor = UIColor(red: 79/255, green: 50/255, blue: 194/255, alpha: 1.0)
            targetButton.configuration?.attributedTitle = targetTitle
        case 1:
            if let firstTarget = tempTarget[0] {
                targetTitle = AttributedString.init(firstTarget)
                targetTitle.foregroundColor = .white
                targetButton.configuration?.baseBackgroundColor = UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1.0)
                targetButton.configuration?.baseForegroundColor = .white
                targetButton.configuration?.attributedTitle = targetTitle
            }
        default:
            if let firstTarget = tempTarget[0] {
                targetTitle = AttributedString.init(firstTarget + " 외 \(tempTarget.count - 1)")
                targetTitle.foregroundColor = .white
                targetButton.configuration?.baseBackgroundColor = UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1.0)
                targetButton.configuration?.baseForegroundColor = .white
                targetButton.configuration?.attributedTitle = targetTitle
            }
        }
        
        
        if let tempPeople = tempPeople {
            peopleTitle = AttributedString.init(tempPeople)
            peopleTitle.foregroundColor = .white//UIColor(red: 79/255, green: 50/255, blue: 194/255, alpha: 1.0)
            peopleButton.configuration?.baseBackgroundColor = UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1.0)
            peopleButton.configuration?.baseForegroundColor = .white
        } else {
            peopleTitle = AttributedString.init("대상")
            peopleTitle.foregroundColor = UIColor(red: 79/255, green: 50/255, blue: 194/255, alpha: 1.0)
        }
        peopleButton.configuration?.attributedTitle = peopleTitle
    }
    
    func setCollectionView() {
        view.addSubview(resultCollectionView)
        let resultCollectionViewConstraints = [
            resultCollectionView.widthAnchor.constraint(equalToConstant: view.bounds.width-32),
            resultCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.height-55),
            resultCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ]
        NSLayoutConstraint.activate(resultCollectionViewConstraints)
        
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
    }
    func setSearchBar() {
        let searchIcon = UIBarButtonItem(systemItem: .search, primaryAction: UIAction(handler: { _ in
            print("searchIcon")
            self.searchBar.endEditing(true)
            self.tempCafeArray.append(contentsOf: MockManager.shared.getMockData())
            DispatchQueue.main.async {
                self.resultCollectionView.reloadData()
            }
        }))
        
        let backIcon = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(moveTo))
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
    
    // 화면 터치하여 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = UIColor.blue.cgColor
        self.resultCollectionView.reloadData()
    }
    // 화면 스크롤할 경우도 키보드 내리기
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = UIColor.blue.cgColor
        self.resultCollectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bottomLine.backgroundColor = UIColor.blue.cgColor
        // 서치바 밑줄
        if let textfield = self.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.borderStyle = .none
            bottomLine.frame = CGRect(x: 0, y: textfield.bounds.height, width: textfield.bounds.width, height: 1)
            textfield.layer.addSublayer(bottomLine)
        }
        self.scrollView.contentSize = CGSize(width: targetButton.bounds.width+dateButton.bounds.width+regionButton.bounds.width+peopleButton.bounds.width+8*6, height: view.bounds.height*0.055)
    }
    
    // 키보드 내리기 함수
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        self.searchBar.endEditing(true)
        bottomLine.backgroundColor = UIColor.blue.cgColor
        print("tap working")
    }
    // 다음뷰로 이동하는 함수
    @objc func moveTo() {
        let nextVC = BirthdayCafeViewController()
        show(nextVC, sender: nil)
        
    }
    
    
}

extension SearchListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering && filterredArr.count == 0 { // 화면 바로 가자마자 문구가 필요하다면 "|| tempCafeArray.count == 0" 부분추가
            view.addSubview(emptyLabel)
            emptyLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
            emptyLabel.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        } else {
            self.emptyLabel.removeFromSuperview()
        }
        return isFiltering ? filterredArr.count : tempCafeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = resultCollectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        isFiltering ? cell.configure(with: filterredArr[indexPath.row]) : cell.configure(with: tempCafeArray[indexPath.row])
        return cell
    }
}
// RED는 검색중, blue는 일반
extension SearchListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        bottomLine.backgroundColor = UIColor.red.cgColor
        self.isFiltering = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.lowercased() else { return }
        self.filterredArr = self.tempCafeArray.filter({ CafeInfo in
            return CafeInfo.cafe_name.localizedCaseInsensitiveContains(text)
        })
        if text == "" {
            self.isFiltering = false
        } else {
            self.isFiltering = true
        }
        // 바로바로 업데이트 되게 만들기
        //        self.resultCollectionView.reloadData()
        //        bottomLine.backgroundColor = UIColor.red.cgColor
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
        bottomLine.backgroundColor = UIColor.red.cgColor
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.isFiltering = false
        self.resultCollectionView.reloadData()
    }
}


