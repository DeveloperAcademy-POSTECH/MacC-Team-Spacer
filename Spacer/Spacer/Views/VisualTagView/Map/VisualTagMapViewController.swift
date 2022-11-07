//
//  VisualTagCalendarViewController.swift
//  Spacer
//
//  Created by Hyung Seo Han on 2022/10/11.
//

import UIKit


let locations = ["전국", "서울", "부산"]
var selectItemArray: [Bool] = Array<Bool>(repeating: false, count: locations.count)

class VisualTagMapViewController: UIViewController {
    //insets size for collection View
    let sectionInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 25/255, green: 0, blue: 80/255, alpha: 1)
        label.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        label.text = "원하는 지역을 선택해주세요."
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = NextButton()
        button.setView(title: "다음", titleColor: .white, backgroundColor: .mainPurple3, target: VisualTagMapViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = CancelButton()
        button.setView(foreground: .black, image: UIImage(systemName: "multiply"), target: VisualTagMapViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = BackButton()
        button.setView(title: "이전으로 돌아가기", titleColor: .grayscale3, target: VisualTagMapViewController(), action: #selector(buttonAction(_:)))
        return button
    }()
    
    lazy var mapCollectionView: UICollectionView = {
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
            headerTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 7),
            headerTitle.widthAnchor.constraint(equalToConstant: view.bounds.width/10*9)
        ])
        
        //backButton autolayout
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            backButton.widthAnchor.constraint(equalTo: headerTitle.widthAnchor),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //next button autolayout
        view.addSubview(self.nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -8),
            nextButton.widthAnchor.constraint(equalToConstant: view.bounds.width/10 * 9),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.height/17)
        ])
        
        //collectionview autolayout
        view.addSubview(self.mapCollectionView)
        mapCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapCollectionView.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 32),
            mapCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapCollectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
    }
    
    //handling action for next, cancel button
    @objc func buttonAction(_ sender: Any) {
        if let button = sender as? UIButton {
            switch button.tag {
            case 1:
                self.navigationController?.pushViewController(VisualTagCategoryViewController(), animated: true)
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

extension VisualTagMapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        return locations.count
    }
    
    //cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as! GridCollectionViewCell
        cell.configure(locations[indexPath.item], categoryImages[indexPath.item])
        return cell
    }
    
    //cell selection handling delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //전국 버튼을 눌렀을 때
        if indexPath.item == 0 {
            for visibleCell in collectionView.indexPathsForVisibleItems{
                collectionView.selectItem(at: visibleCell, animated: false, scrollPosition: [])
                selectItemArray[visibleCell.item] = true
            }
        }else{
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            selectItemArray[indexPath.item] = true
        }
        
        //전국 버튼을 제외한 나머지 버튼들이 활성화가 되어 있다면 전국 버튼 활성화
        let selection: [Bool] = Array(selectItemArray[1...])
        if(selection.contains(false)) {return}
        else{
            collectionView.selectItem(at: [0,0], animated: false, scrollPosition: [])
            selectItemArray[0] = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if indexPath.item == 0{
            for visibleCell in collectionView.indexPathsForVisibleItems{
                collectionView.deselectItem(at: visibleCell, animated: false)
                selectItemArray[visibleCell.item] = false
            }
        }
        else if indexPath.item != 0 && selectItemArray[0] == true{
            collectionView.deselectItem(at: [0,0], animated: false)
            collectionView.deselectItem(at: indexPath, animated: false)
            selectItemArray[indexPath.item] = false
            selectItemArray[0] = false
        }
        else{
            collectionView.deselectItem(at: indexPath, animated: false)
            selectItemArray[indexPath.item] = false
        }
    }
}
