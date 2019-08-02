//
//  GlobalProtocols.swift
//  GitHub
//
//  Created by mac on 8/2/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation

// this protocol for generic savinf and fetching method
// for Local DB like CoreData, Realm and, ObjectBox
// just Conform to it for the required DB
public protocol Storable
{
    
}
enum ParameterEncoding {
    case json
}
// this protocol for All requirment for calling Api
protocol ApiHeaders_Parametes_Url_Protocol {
    func getHeaders()->[String:Any]?
    func getParameters()->[String:Any]?
    func getApiUrl()->String
    func getParameterEncodeing()->ParameterEncoding
}
