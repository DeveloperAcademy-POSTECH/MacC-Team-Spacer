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
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 252, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(RecentCafeCollectionViewCell.self, forCellWithReuseIdentifier: RecentCafeCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
    


}
