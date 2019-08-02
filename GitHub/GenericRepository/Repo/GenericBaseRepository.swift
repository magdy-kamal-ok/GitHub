//
//  GenericBaseRepository.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift

class GenericBaseRepository<REMOTE:BaseModel, LOCAL:BaseModel>:GenericDataSourceContract {
    
    
    
    private let objGenericRequestClass: GenericDataRemoteSource?
    private var objGenericDao: GenericDataLocalSource!
    
    private var objSubjectDao = PublishSubject<LOCAL>()
    private var objSubjectRemote = PublishSubject<[REMOTE]>()
    
    private var objSubjectError = PublishSubject<ErrorModel>()
    
    private var bag = DisposeBag()
    
    public var objObservableLocal: Observable<LOCAL> {
        return objSubjectDao.asObservable()
    }
    
    public var objObservableRemoteData: Observable<[REMOTE]> {
        return objSubjectRemote.asObservable()
    }
    
    public var objObservableErrorModel: Observable<ErrorModel> {
        return objSubjectError.asObservable()
    }
    
    
    init(requestManager:GenericDataRemoteSource, daoManager:GenericDataLocalSource) {
        self.objGenericRequestClass = requestManager
        self.objGenericDao = daoManager
    }
    
    func getGenericData(apiComponents:ApiHeaders_Parametes_Url_Protocol, bool: Bool = true)
    {
        if bool {
            if let cashedData = self.fetch(predicate: self.getPredicate(), type: LOCAL.self)
            {
                if let localCachedData = cashedData as? LOCAL
                {
                    objSubjectDao.onNext(localCachedData)
                }
                self.callBackEndApi(apiComponents:apiComponents)
            }
            else {
                self.objSubjectError.onNext(ErrorModel(desc: Constants.noExisitingCashedData.localized, code: ErrorCodes.noCached.rawValue))
                self.callBackEndApi(apiComponents:apiComponents)
            }
            
        }
        else
        {
            self.callBackEndApi(apiComponents:apiComponents)
        }
    }
    
    
    func handleResponseData(_ responseObj:[BaseModel])
    {
        
    }
    func emitResponseData(_ responseObj: [BaseModel])
    {
        self.objSubjectRemote.onNext(responseObj as! [REMOTE])
    }
    
    func callApi<R>(apiComponents:ApiHeaders_Parametes_Url_Protocol) -> Observable<[R]>? where R : BaseModel {
        
        if let objObserve:Observable<[R]> = objGenericRequestClass?.callApi(apiComponents:apiComponents)
        {
            return objObserve
        }
        return Observable.empty()
    }
    
    func callBackEndApi(apiComponents:ApiHeaders_Parametes_Url_Protocol)
    {
        
        if let objObserve:Observable<[REMOTE]> = self.callApi(apiComponents:apiComponents)
        {
            objObserve.subscribe({ (subObj) in
                
                switch subObj
                {
                case .next(let responseObj):
                    self.handleResponseData(responseObj)
                    self.emitResponseData(responseObj)
                case .error(let error):
                    self.objSubjectError.onNext(ErrorModel(desc: error.localizedDescription, code: ErrorCodes.remoteError.rawValue))
                    
                case .completed:
                    print("Completed")
                }
                
            }).disposed(by: bag)
        }
    }
    
    func getPredicate() -> NSPredicate?
    {
        //        preconditionFailure("You have to Override predicate To get Specified Data")
        return nil
    }
    
    func insertList(remote: [REMOTE])
    {
        // Please override this and call
        // insertDataToLocal(genericDataModel:
    }
    
    func insertDataToLocal(genericDataModel: LOCAL) {
        // override this if needed
        objGenericDao.insert(genericDataModel: genericDataModel)
        
    }
    
}

extension GenericBaseRepository
{
    func fetch<L>(predicate: NSPredicate?, type: L.Type) -> L? where L : Storable {
        return self.objGenericDao.fetch(predicate: predicate, type: type)
    }
    
    
    func insert<L>(genericDataModel: L) {
        self.insertDataToLocal(genericDataModel: genericDataModel as! LOCAL)
    }
    
}



