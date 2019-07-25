//
//  BaseGithubViewController.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//
import UIKit

class BaseGithubViewController: UIViewController {


    // MARK: - Outlets

    @IBOutlet weak var githubTableView: UITableView!
    @IBOutlet weak var githubSearchBar: UISearchBar!

    public var paginationIndicator: UIActivityIndicatorView?
    private var refreshControl: UIRefreshControl?
    private var hasPagination: Bool = false

    // MARK: - Base Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibleIdentifiers()
        setupTableDataSource()
        setupCellNibNames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view

    func setupTableDataSource() -> Void {
        self.githubTableView.delegate = self
        self.githubTableView.dataSource = self
    }


    // MARK: Table view nib name

    public func setupCellNibNames() -> Void {
        // This methode will overridw at sub classes
    }

    public func setAccessibleIdentifiers()
    {
        self.githubTableView.accessibilityIdentifier = Constants.tableViewIdentifier
        self.githubSearchBar.accessibilityIdentifier = Constants.searchBarIdentifier

    }
    func getCellHeight(indexPath: IndexPath) -> CGFloat {
        preconditionFailure("You have to Override getCellHeight Function first to be able to set cell height")
    }

    func getCellsCount(with section: Int) -> Int
    {
        preconditionFailure("You have to Override getCellsCount Function first to be able to set number of cells count")
    }

    func getSectionsCount() -> Int
    {
        preconditionFailure("You have to Override getSectionsCount Function first to be able to set number of sections count")
    }


    // MARK: Refresh cotrol
    func setupSwipeRefresh() -> Void {
        refreshControl = UIRefreshControl()

        refreshControl?.tintColor = UIColor.gray
        refreshControl?.addTarget(self, action: #selector(swipeRefreshTableView), for: .valueChanged)
        self.githubTableView.addSubview(refreshControl!)
    }

    @objc func swipeRefreshTableView() {
        // override this when you need to refresh table data by swipe
    }

    func endRefreshTableView() -> Void {
        self.refreshControl?.endRefreshing()
    }

    func checkRefreshControlState() -> Void {
        DispatchQueue.main.async {
            if (self.refreshControl?.isRefreshing)! {
                self.refreshControl?.endRefreshing()
            }
        }
    }

    //MARK: Pagination
    func setupPagination() -> Void {
        hasPagination = true
    }

    func handlePaginationRequest() {
        // override this when you need to handlePaginationRequest
    }

    func showLoadingMoreView() -> Void {
        paginationIndicator = UIActivityIndicatorView.init()
        paginationIndicator?.color = UIColor.gray
        paginationIndicator?.sizeToFit()
        paginationIndicator?.accessibilityIdentifier = Constants.repoLoadMoreIdentifier
        paginationIndicator?.isAccessibilityElement = true
        paginationIndicator?.startAnimating()
        self.githubTableView.tableFooterView = paginationIndicator
    }

    func removeLoadingMoreView() {
        if paginationIndicator != nil {
            if paginationIndicator!.isDescendant(of: self.view) {
                paginationIndicator?.removeFromSuperview()
                paginationIndicator = nil
            }
        }
    }

}


// MARK: - UITableViewDataSource

extension BaseGithubViewController: UITableViewDataSource {


    // MARK: Height for cell

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight(indexPath: indexPath)
    }

    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getSectionsCount()
    }

    // MARK: Number of rows

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCellsCount(with: section)
    }


    // MARK: Cell for row

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return getCustomCell(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCellAt(indexPath: indexPath)
    }


    @objc func getCustomCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell.init()
    }

    @objc func didSelectCellAt(indexPath: IndexPath) {

    }

}

extension BaseGithubViewController: UITableViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == githubTableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                if (self.hasPagination) {
                    self.handlePaginationRequest()
                }
            }
        }
    }
}
