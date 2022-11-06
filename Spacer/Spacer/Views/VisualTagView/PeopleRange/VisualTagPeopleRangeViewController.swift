//
//  VisualTagPeopleRangeView.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/16.
//

import UIKit

let ranges = ["20명 이하", "20~40명", "40~60명","60~80명","80명 이상","상관없음"]
var rangeItemArray: [Bool] = Array<Bool>(repeating: false, count: ranges.count)

class VisualTagPeopleRangeViewController: UIViewController {
    //insets size for collection View
    let sectionInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 25/255, green: 0, blue: 80/255, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.numberOfLines = 2
        label.text = "원하는 카페의 인원 수용 규모를 \n선택해주세요."
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = NextButton()
        button.setView(title: "완료", titleColor: .white, backgroundColor: UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1), target: VisualTagPeopleRangeViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = CancelButton()
        button.setView(foreground: .black, image: UIImage(systemName: "multiply"), target: VisualTagPeopleRangeViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = BackButton()
        button.setView(title: "이전으로 돌아가기", titleColor: UIColor(red: 119/255, green: 89/255, blue: 240/255, alpha: 1), target: VisualTagPeopleRangeViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var peopleRangeCollectionView: UICollectionView = {
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
        view.addSubview(self.peopleRangeCollectionView)
        peopleRangeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            peopleRangeCollectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -32),
            peopleRangeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            peopleRangeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            peopleRangeCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any){
        if let button = sender as? UIButton{
            switch button.tag{
            case 1:
                super.dismiss(animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: false)
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


extension VisualTagPeopleRangeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        return ranges.count
    }
    
    //cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as! GridCollectionViewCell
        cell.configure(ranges[indexPath.item], categoryImages[indexPath.item])
        return cell
    }
    
    //cell selection handling delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //상관없음 버튼을 눌렀을 때
        if indexPath.item == 5 {
            for visibleCell in collectionView.indexPathsForVisibleItems{
                collectionView.selectItem(at: visibleCell, animated: false, scrollPosition: [])
                rangeItemArray[visibleCell.item] = true
            }
        }else{
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            rangeItemArray[indexPath.item] = true
        }
        
        //상관없음 버튼을 제외한 나머지 버튼들이 활성화가 되어 있다면 전국 버튼 활성화
        let selection: [Bool] = Array(rangeItemArray[..<5])
        if(selection.contains(false)) {return}
        else{
            collectionView.selectItem(at: [0,5], animated: false, scrollPosition: [])
            rangeItemArray[5] = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.item == 5{
            for visibleCell in collectionView.indexPathsForVisibleItems{
                collectionView.deselectItem(at: visibleCell, animated: false)
                rangeItemArray[visibleCell.item] = false
            }
        }
        else if indexPath.item != 5 && rangeItemArray[5] == true{
            collectionView.deselectItem(at: [0,5], animated: false)
            collectionView.deselectItem(at: indexPath, animated: false)
            rangeItemArray[indexPath.item] = false
            rangeItemArray[5] = false
        }
        else{
            collectionView.deselectItem(at: indexPath, animated: false)
            rangeItemArray[indexPath.item] = false
        }
    }
}
