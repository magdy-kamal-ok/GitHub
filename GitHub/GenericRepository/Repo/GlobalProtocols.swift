//
//  GlobalProtocols.swift
//  GitHub
//
//  Created by mac on 8/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import ObjectMapper

// this protocol for generic savinf and fetching method
// for Local DB like CoreData, Realm and, ObjectBox
// just Conform to it for the required DB
public protocol Storable
{
    
}
// conform to this protocol so as can be used in case
// of using objectmapper or in case Codable
protocol RemoteMappable
{
    init?(dict: [String:Any])
}

// this enum to get encoding required
enum ParameterEncoding {
    case json
}

// this protocol for All requirment for calling Api
protocol ApiHeadersParametesUrlProtocol {
    func getHeaders()->[String:Any]?
    func getParameters()->[String:Any]?
    func getApiUrl()->String
    func getParameterEncodeing()->ParameterEncoding
    func getHttpMethod()->String
}
