//
//  RealmManager.swift
//  Spacer
//
//  Created by 허다솔 on 2022/11/19.
//

import Foundation
import RealmSwift

class FavoriteCafe: Object {
    @Persisted var cafeName: String = ""
    
    convenience init(cafeName: String) {
        self.init()
        self.cafeName = cafeName
    }
}

class FavoriteURLCafe: Object {
    @Persisted var cafeName: String = ""
    @Persisted var cafeAddress: String = ""
    @Persisted var memo: String = ""
    @Persisted var cafeURL: String = ""
    
    convenience init(cafeName: String, cafeAddress: String, memo: String, cafeURL: String) {
        self.init()
        self.cafeName = cafeName
        self.cafeAddress = cafeAddress
        self.memo = memo
        self.cafeURL = cafeURL
    }
}
