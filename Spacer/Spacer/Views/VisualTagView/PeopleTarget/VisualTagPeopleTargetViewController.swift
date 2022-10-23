//
//  VisualTagPeopleTargetView.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit

let targets = ["아이돌", "배우", "가수", "뮤지컬 배우", "운동선수", "캐릭터", "인플루언서", "래퍼", "성우", "코미디언", "해외 연예인", "기타"]
var targetItemArray: [Bool] = Array<Bool>(repeating: false, count: targets.count)

class VisualTagPeopleTargetViewController: UIViewController {
    let sectionInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 25/255, green: 0, blue: 80/255, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.text = "원하는 대상을 선택해주세요."
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = NextButton()
        button.setView(title: "다음", titleColor: .white, backgroundColor: UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1), target: VisualTagPeopleTargetViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = CancelButton()
        button.setView(foreground: .black, image: UIImage(systemName: "multiply"), target: VisualTagPeopleTargetViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = BackButton()
        button.setView(title: "이전으로 돌아가기", titleColor: UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1), target: VisualTagPeopleTargetViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var peopleTargetCollectionView: UICollectionView = {
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
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width/10)/2 - 15),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        //headerTitle autolayout
        view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.bounds.width/10)/2),
            headerTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 8),
            headerTitle.widthAnchor.constraint(equalToConstant: view.bounds.width/10*9)
        ])
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            backButton.widthAnchor.constraint(equalTo: headerTitle.widthAnchor),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //next button autolayout
        self.view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -8),
            nextButton.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.height/17)
        ])
        
        //collectionview autolayout
        view.addSubview(self.peopleTargetCollectionView)
        peopleTargetCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            peopleTargetCollectionView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 32),
            peopleTargetCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            peopleTargetCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            peopleTargetCollectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any) {
        if let button = sender as? UIButton{
            switch button.tag {
            case 1:
                
                self.navigationController?.pushViewController(VisualTagPeopleRangeViewController(), animated: true)
            case 2:
                super.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: false)
            case 3:
                self.navigationController?.popViewController(animated: true)
            default:
                print("Error")
            }
        }
    }
}


extension VisualTagPeopleTargetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        return targets.count
    }
    
    //cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as! GridCollectionViewCell
        cell.configue(targets[indexPath.item])
        return cell
    }
    
    //cell selection handling delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //전국 버튼을 눌렀을 때
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        targetItemArray[indexPath.item] = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: false)
            targetItemArray[indexPath.item] = false
    }
}
