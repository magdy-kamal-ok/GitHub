//
//  AlamofireRequestClass.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


class AlamofireRequestClass : GenericDataRemoteSource {
    func callApi<R>(apiComponents:ApiHeadersParametesUrlProtocol) -> Observable<[R]>? where R : RemoteMappable {
        
        let url = apiComponents.getApiUrl()
        let params = apiComponents.getParameters()
        let headers = apiComponents.getHeaders() as? HTTPHeaders
        var parameterEncoding:Alamofire.ParameterEncoding = JSONEncoding.default
        switch apiComponents.getParameterEncodeing() {
        case .json:
            parameterEncoding =  JSONEncoding.default
        }
        let method = HTTPMethod.init(rawValue: apiComponents.getHttpMethod()) ?? .get
        return Observable.create {
            observer in
            Alamofire.request(url,
                              method: method,
                              parameters: params, encoding: parameterEncoding, headers: headers
                )
                .responseJSON { response in
                    switch response.result {
                    case .success(let json):
                        guard let value = json as? [[String: Any]]
                            else {
                                return
                        }
                        var responseList: [R] = [R]()
                        for item in value
                        {
                            let itemObject = R(dict: item)!
                            responseList.append(itemObject)
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
