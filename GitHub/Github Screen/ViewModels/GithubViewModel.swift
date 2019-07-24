//
//  GithubViewModel.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import Reachability

class GithubViewModel: BaseNetworkConnectionViewModel {

    let disposeBag = DisposeBag()
    let githubRepo = GithubRepository()
    public private(set) var offset:Int = 1
    public private(set) var userName:String = ""
    private var reposList = [RepoItemModel]()
    public private(set) var isLoadingMore = false
    private var subjectTagList = PublishSubject<[RepoItemModel]>()
    
    public var observableTagList:Observable<[RepoItemModel]>{
        return subjectTagList.asObservable()
    }
    
    override init() {
        super.init()
        initializeSubscribers()
    }
    
    private func initializeSubscribers()
    {
        githubRepo.objObservableLocal.subscribe(onNext: { (tagsResponseModel) in
            if !self.isNetworkConnected()
            {
                self.handleLoadedRepos(reposList: tagsResponseModel.reposList.toArray())
            }
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        githubRepo.objObservableRemoteData.subscribe(onNext: { (tagsResponseModel) in
            self.handleLoadedRepos(reposList: tagsResponseModel)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
        githubRepo.objObservableErrorModel.subscribe(onNext: { (errorModel) in
            self.handleErrorModel(errorModel: errorModel)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }).disposed(by: disposeBag)
        
    }
    
    func handleLoadedRepos(reposList: [RepoItemModel])
    {
        if isLoadingMore
        {
            isLoadingMore = !isLoadingMore
        }
        self.reposList.append(contentsOf: reposList)
        self.subjectTagList.onNext(self.reposList)
        self.hideProgressLoaderIndicator()
    }
    

    func getRepoList()
    {
        self.showProgressLoaderIndicator()
        self.githubRepo.getTagsList(userName: self.userName, offset: self.offset)
    }
    func getReposWith(text:String)
    {
        resetDataSource()
        self.userName = text
        self.getRepoList()
    }
    
    func loadMoreRepos()
    {
        if !isLoadingMore
        {
            self.isLoadingMore = !self.isLoadingMore
            self.offset += 1
            self.getRepoList()
        }
    }
    func resetDataSource()
    {
        self.reposList.removeAll()
        self.offset = 1
    }
    
    func refreshReposList()
    {
        self.resetDataSource()
        self.getRepoList()
    }
    
    func clearReposList()
    {
        resetDataSource()
        self.userName = ""
    }
    
    func showInfoMessage(msg:String)
    {
        UIHelper.showInfoMessage(msg, title: Constants.appName.localized)
    }
    
    override func handleInternetConnectionReconnected() {
       showInfoMessage(msg: Constants.internertConnectionReconnected.localized)
       self.refreshReposList()
    }
    
    override func handleInternetConnectionDisconnected() {
        showInfoMessage(msg: Constants.internertConnectionDisconnected.localized)
        
    }
    
    func handleErrorModel(errorModel:ErrorModel)
    {

        self.hideProgressLoaderIndicator()
        if errorModel.code == ErrorCodes.noCached.rawValue
        {
            if !self.isNetworkConnected()
            {
                showInfoMessage(msg: errorModel.desc)
            }
        }
        else
        {
          showInfoMessage(msg: errorModel.desc)
            
        }
    }

}
