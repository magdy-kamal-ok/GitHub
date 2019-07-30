//
//  GenericDataSourceContract.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import RealmSwift
import Alamofire

typealias GenericDataSourceContract = GenericDataRemoteSource & GenericDataLocalSource


protocol GenericDataRemoteSource {

    associatedtype T: Mappable

    func callApi(url: String, params: Parameters?, headers: HTTPHeaders?) -> Observable<[T]>?

}


protocol GenericDataLocalSource {

    associatedtype U: Object

    func fetch(predicate: NSPredicate?) -> U?

    func insert(genericDataModel: U)

    func delete()
}
