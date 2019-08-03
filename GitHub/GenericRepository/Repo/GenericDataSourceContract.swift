//
//  GenericDataSourceContract.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift



typealias GenericDataSourceContract = GenericDataRemoteSource & GenericDataLocalSource

protocol GenericDataLocalSource {
    
    func fetch<L:Storable>(predicate: NSPredicate?, type: L.Type) -> L?
    
    func insert<L:Storable>(genericDataModel: L)
    
}
protocol GenericDataRemoteSource {
    
    
    func callApi<R:RemoteMappable>(apiComponents:ApiHeadersParametesUrlProtocol) -> Observable<[R]>?
    
}
