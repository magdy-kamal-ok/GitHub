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

public protocol Storable
{
    
}
extension Object: Storable
{
    
}


typealias GenericDataSourceContract = GenericDataRemoteSource & GenericDataLocalSource

protocol GenericDataLocalSource {
    
    func fetch<L:Storable>(predicate: NSPredicate?, type: L.Type) -> L?
    
    func insert<L:Storable>(genericDataModel: L)
    
}
protocol GenericDataRemoteSource {
    
    
    func callApi<R:BaseModel>(apiComponents:ApiHeaders_Parametes_Url_Protocol) -> Observable<[R]>?
    
}
enum ParameterEncoding {
    case json
}
protocol ApiHeaders_Parametes_Url_Protocol {
    func getHeaders()->[String:Any]?
    func getParameters()->[String:Any]?
    func getApiUrl()->String
    func getParameterEncodeing()->ParameterEncoding
}
