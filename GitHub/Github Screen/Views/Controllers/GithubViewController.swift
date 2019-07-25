//
//  MenuViewController.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift


class GithubViewController: BaseGithubViewController {

    let disposeBag = DisposeBag()
    let githubViewModel = GithubViewModel()
    private var reposList = [RepoItemModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setAttributedTitle()
        setSearchBarDelegate()
        setGithubTitle()
        setupPagination()
        setupSwipeRefresh()
        listenToReposListResponse()


    }

    override func setupCellNibNames()
    {
        self.githubTableView.registerCellNib(cellClass: GithubTableViewCell.self)

    }

    func listenToReposListResponse()
    {
        githubViewModel.observableGithubRepoList.subscribe(onNext: { (reposList) in
            self.reposList = reposList
            self.setTableViewDataSource()

        }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            }).disposed(by: disposeBag)

    }

    func setSearchBarDelegate()
    {
        self.githubSearchBar.delegate = self
    }
    func setGithubTitle()
    {
        self.title = Constants.githubScreenTitle.localized
    }
    func setTableViewDataSource()
    {
        self.checkRefreshControlState()
        self.removeLoadingMoreView()
        self.githubTableView.reloadData()
    }

    override func swipeRefreshTableView() {
        if !self.githubViewModel.userName.isEmpty
        {
            self.githubViewModel.refreshReposList()
        }
        else
        {
            self.checkRefreshControlState()
        }
    }

    override func getCellsCount(with section: Int) -> Int {
        return self.reposList.count
    }

    override func getSectionsCount() -> Int {
        return 1
    }

    override func getCellHeight(indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }

    override func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeue() as GithubTableViewCell
        let repoItem = self.reposList[indexPath.row]
        cell.configureCell(repoItemModel: repoItem)
        return cell

    }
    override func didSelectCellAt(indexPath: IndexPath) {

        let repoItem = self.reposList[indexPath.row]
        guard let url = URL(string: repoItem.repoUrl) else {
            return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

    }
    override func handlePaginationRequest() {

        if !self.githubViewModel.isLoadingMore && self.reposList.count > 0
        {
            self.showLoadingMoreView()
            self.githubViewModel.loadMoreRepos()
        }
    }

}

extension GithubViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.githubSearchBar.becomeFirstResponder()
        self.githubSearchBar.endEditing(true)

        if let searchText = searchBar.text
        {
            self.githubViewModel.getReposWith(text: searchText)
        }
    }

}
