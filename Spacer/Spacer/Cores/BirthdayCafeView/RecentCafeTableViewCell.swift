//
//  RecentCafeTableViewCell.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/13.
//

import UIKit

// CollectionView를 담을 1개 짜리 테이블 셀
class RecentCafeTableViewCell: UITableViewCell {

    public var tempCafeArray: [CafeInfo] = [CafeInfo]()
    
    static let identifier = "RecentCafeTableViewCell"
    
    //MARK: - 3. 프로토콜 변수 선언
    weak var cellSelectedDelegate: CellSelectedDelegate?
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // 셀 사이의 간격
        layout.minimumLineSpacing = .padding.betweenContentsPadding
        layout.itemSize = CGSize(width: 253, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        // content와 스크롤뷰(컬렉션뷰)와의 간격
        collectionView.contentInset = UIEdgeInsets(top: 0, left: .padding.homeMargin, bottom: 0, right: 0)
        collectionView.register(RecentCafeCollectionViewCell.self, forCellWithReuseIdentifier: RecentCafeCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // 아래에 생기는 인디케이터 삭제
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: [CafeInfo]) {
        self.tempCafeArray = model
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension RecentCafeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempCafeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCafeCollectionViewCell.identifier, for: indexPath) as? RecentCafeCollectionViewCell else { return UICollectionViewCell() }
        
        // MARK: - 1. 셀에 값 넘기기
        
        cell.configure(with: tempCafeArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        //MARK: - 3. 델리게이트의 값을 넘김
        cellSelectedDelegate?.selectionAction(data: tempCafeArray[indexPath.item], indexPath: indexPath)
    }
    
}

//MARK: 3. 프로토콜 선언 - 델리게이트
protocol CellSelectedDelegate: AnyObject {
    func selectionAction(data: CafeInfo?, indexPath: IndexPath)
}
