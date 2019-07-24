//
//  CollectionExtensions.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {

    func itemsResltToArray() -> [Element] {
        var array = [Element]()
        for result in self {
            array.append(result)
        }
        return array
    }
}

extension List {

    func toArray() -> [Element] {
        var array = [Element]()
        for result in self {
            array.append(result)
        }
        return array
    }
}
