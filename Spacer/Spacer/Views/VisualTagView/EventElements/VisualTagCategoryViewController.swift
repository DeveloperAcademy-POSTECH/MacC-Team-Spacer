//
//  VisualTagPeopleTargetView.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit

let eventElements = ["컵홀더", "현수막", "액자", "배너", "전시공간", "보틀음료", "맞춤\n디저트", "맞춤\n영수증", "등신대", "포토 카드", "포토존", "영상 상영"]

let eventElementsImages = ["visualCategoryCupHolder","visualCategoryHBanner","visualCategoryFrame","visualCategoryXBanner","visualCategoryExhibitionArea","visualCategoryBottle","visualCategoryCustomCookie","visualCategoryCustomReceipt","visualCategoryCutout","visualCategoryPhotoCard","visualCategoryPhotoZone","visualCategoryVideoShow"]
var eventElementsItemArray: [Bool] = Array<Bool>(repeating: false, count: eventElements.count)


class VisualTagEventElementsViewController: UIViewController {
    let sectionInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .mainPurple1
        label.font = .systemFont(for: .header2)
        label.numberOfLines = 2
        label.text = "반드시 하고 싶은 데코레이션을 모두 \n선택해주세요."
        return label
    }()
    
    let titleUnderLine: UIView = {
        let line = UIView()
        line.backgroundColor = .subYellow1
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    lazy var nextButton: UIButton = {
        let button = NextButton()
        button.setView(title: "완료", titleColor: .white, backgroundColor: .mainPurple3, target: VisualTagEventElementsViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = CancelButton()
        button.setView(foreground: .mainPurple1, image: UIImage(systemName: "multiply"), target: VisualTagEventElementsViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = BackButton()
        button.setView(title: "이전으로 돌아가기", titleColor: .grayscale3, target: VisualTagEventElementsViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var eventElementsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: GridCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //cancel button autolayout
        self.view.addSubview(self.cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
            cancelButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        // headerTitle autolayout
        view.addSubview(titleUnderLine)
        view.addSubview(headerTitle)
        titleUnderLine.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleUnderLine.leadingAnchor.constraint(equalTo: headerTitle.leadingAnchor, constant: 160),
            titleUnderLine.topAnchor.constraint(equalTo: headerTitle.topAnchor, constant: 18),
            titleUnderLine.widthAnchor.constraint(equalToConstant: 127),
            titleUnderLine.heightAnchor.constraint(equalToConstant: 13)
        ])
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            headerTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 8),
            headerTitle.widthAnchor.constraint(equalToConstant: view.bounds.width/10*9)
        ])
        
        // back button autolayout
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.padding.underTitlePadding),
            backButton.widthAnchor.constraint(equalToConstant: view.bounds.width),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //next button autolayout
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -.padding.underTitlePadding),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            nextButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        //collectionview autolayout
        view.addSubview(self.eventElementsCollectionView)
        eventElementsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventElementsCollectionView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: .padding.differentHierarchyPadding),
            eventElementsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventElementsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventElementsCollectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 선택되었던 eventElementsItemArray를 다시 false로 바꿔서 여러번 맞춤형 카페 검색을 진행하였을 경우 이전에 선택한 eventElements값들이 여전히 남아있는 이슈 해결
        eventElementsItemArray =  Array<Bool>(repeating: false, count: eventElements.count)
    }
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any) {
        if let button = sender as? UIButton{
            switch button.tag {
            case 1:
                UserDefaults.standard.set(eventElementsItemArray, forKey: "eventElements")
                // goToSearchListView란 이름의 노티피케이션센터 동작 명령
                NotificationCenter.default.post(name: NSNotification.Name("goToSearchListView"), object: nil)
                
                super.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: false)
            case 2:
                UserDefaults.standard.removeObject(forKey: "eventElements")
                UserDefaults.standard.removeObject(forKey: "region")
                UserDefaults.standard.removeObject(forKey: "firstDate")
                UserDefaults.standard.removeObject(forKey: "lastDate")
                
                super.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: false)
            case 3:
                self.navigationController?.popViewController(animated: true)
                UserDefaults.standard.removeObject(forKey: "eventElements")
            default:
                print("Error")
            }
        }
    }
}

extension VisualTagEventElementsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //collectionViewLayout sectionInsets configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    //size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 114
        let cellHeight: CGFloat =  88
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //return number of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventElements.count
    }
    
    //cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as! GridCollectionViewCell
        cell.configure(eventElements[indexPath.item], eventElementsImages[indexPath.item])
        return cell
    }
    
    //cell selection handling delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //상관없음 버튼을 눌렀을 때
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        eventElementsItemArray[indexPath.item] = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        eventElementsItemArray[indexPath.item] = false
    }
}
