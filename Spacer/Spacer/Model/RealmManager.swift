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
