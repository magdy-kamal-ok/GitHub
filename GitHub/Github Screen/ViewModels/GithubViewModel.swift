//
//  GithubViewModel.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class GithubViewModel: BaseNetworkConnectionViewModel {

    let disposeBag = DisposeBag()
    var githubRepo : GithubRepository?
    public private(set) var offset: Int = 1
    public private(set) var userName: String = ""
    private var reposList = [RepoItemModel]()
    public private(set) var isLoadingMore = false
    private var subjectGithubRepoList = PublishSubject<[RepoItemModel]>()

    public var observableGithubRepoList: Observable<[RepoItemModel]> {
        return subjectGithubRepoList.asObservable()
    }

    override init() {
        super.init()
        do {
            let realm = try Realm()
            githubRepo = GithubRepository(requestManager: AlamofireRequestClass(), daoManager: RealmDao(realm: realm))
        }
        catch{
            assertionFailure("error creating realm object")
        }
        initializeSubscribers()
    }

    private func initializeSubscribers()
    {
        githubRepo?.objObservableLocal.distinctUntilChanged().subscribe(onNext: { (cachedRepoModel) in
            if !self.isNetworkConnected()
            {
                self.handleLoadedRepos(reposList: cachedRepoModel.getReposArray())
            }
        }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            }).disposed(by: disposeBag)

        githubRepo?.objObservableRemoteData.subscribe(onNext: { (reposList) in
            if self.isNetworkConnected()
            {
                self.handleLoadedRepos(reposList: reposList)
            }
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            }).disposed(by: disposeBag)

        githubRepo?.objObservableErrorModel.subscribe(onNext: { (errorModel) in
            self.handleErrorModel(errorModel: errorModel)
        }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            }).disposed(by: disposeBag)

    }

    func handleLoadedRepos(reposList: [RepoItemModel])
    {
        
        if reposList.count != 0
        {
            if isLoadingMore
            {
                isLoadingMore = !isLoadingMore
            }
            self.reposList.append(contentsOf: reposList)
        }
        else
        {
            if self.offset == 1
            {
                self.resetDataSource()
            }
            if self.isNetworkConnected() && self.offset == 1
            {
                showInfoMessage(msg: Constants.noUsersWithName.localized)
            }
        }
        self.subjectGithubRepoList.onNext(self.reposList)
        self.hideProgressLoaderIndicator()
    }


    private func getRepoList()
    {
        self.showProgressLoaderIndicator()
        self.githubRepo?.getRepoList(userName: self.userName, offset: self.offset)
    }

    func getReposWith(text: String)
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
    private func resetDataSource()
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

    func showInfoMessage(msg: String)
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

    private func handleErrorModel(errorModel: ErrorModel)
    {

        self.hideProgressLoaderIndicator()
        if errorModel.code == ErrorCodes.noCached.rawValue
        {
            if !self.isNetworkConnected()
            {
                self.handleLoadedRepos(reposList: [])
                showInfoMessage(msg: errorModel.desc)
            }
        }
        else
        {
            showInfoMessage(msg: errorModel.desc)

        }
    }

}
