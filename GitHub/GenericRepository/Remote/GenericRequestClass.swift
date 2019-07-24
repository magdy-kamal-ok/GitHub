//
//  GenericRequestClass.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Alamofire

class GenericRequestClass<U:Mappable>: GenericDataRemoteSource {

    func callApi(url: String, params: Parameters?, headers: HTTPHeaders?) -> Observable<[U]>? {
        return Observable.create {
            observer in
            Alamofire.request(url,
                method: .get,
                parameters: params, encoding: JSONEncoding.default, headers: headers
            )
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        guard let value = json as? [[String: Any]]
                            else {
                                return
                        }
                        var responseList:[U] = [U]()
                        for item in value
                        {
                            responseList.append(U(JSON: item)!)
                        }
                        observer.onNext(responseList)
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create {
            }
        }
    }
}
