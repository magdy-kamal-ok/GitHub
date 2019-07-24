//
//  TagTableViewCell.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import UIKit



class GithubTableViewCell: UITableViewCell {

    @IBOutlet weak var repoOwnerImageView: UIImageView!
    @IBOutlet weak var repoTitleLbl: UILabel!
    @IBOutlet weak var repoCreationDateLbl: UILabel!
    @IBOutlet weak var repoLanguageLbl: UILabel!
    @IBOutlet weak var repoForksCountLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(repoItemModel: RepoItemModel)
    {
        
        GlobalUtilities.downloadImage(path: repoItemModel.owner?.photoUrl, placeholder: UIImage.init(named: Constants.imagePlaceHolderName), into: self.repoOwnerImageView, indicator: nil)
        self.repoTitleLbl.text = repoItemModel.repoTitle
        self.repoCreationDateLbl.text = repoItemModel.creationDate
        self.repoForksCountLbl.text = "# Of Forks: \(repoItemModel.forkCount)"
        self.repoLanguageLbl.text = "Language: \(repoItemModel.language)"
        self.repoDescLbl.text = repoItemModel.repoDesc
        DispatchQueue.main.async {
            self.repoOwnerImageView.layer.cornerRadius = self.repoOwnerImageView.frame.width/2
            self.repoOwnerImageView.layer.masksToBounds = true
        }

    }
}
