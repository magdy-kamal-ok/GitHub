//
//  GithubTableViewCell.swift
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
    
    var imageTapGesture = UITapGestureRecognizer()
    var zoomImageView: UIImageView?
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    
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
        let formattedStrDate = HelperDateFormatter.formatDate(date: HelperDateFormatter.getDateFromString(dateString: repoItemModel.creationDate, format: Constants.yearMonthDayFormat), format: Constants.shortMonthDayYearFormat)
        self.repoCreationDateLbl.text = formattedStrDate
        self.repoForksCountLbl.text = "# Of Forks: \(repoItemModel.forkCount)"
        self.repoLanguageLbl.text = "Language: \(repoItemModel.language)"
        self.repoDescLbl.text = repoItemModel.repoDesc
        DispatchQueue.main.async {
            self.repoOwnerImageView.layer.cornerRadius = self.repoOwnerImageView.frame.width/2
            self.repoOwnerImageView.layer.masksToBounds = true
        }
        setImageControl()
    }
    private func setImageViewsAccessibility()
    {
        self.repoOwnerImageView.accessibilityIdentifier = Constants.repoOwnerImageIdentifier
        self.repoOwnerImageView.isAccessibilityElement = true
        self.repoTitleLbl.accessibilityIdentifier = Constants.repoTitleIdentifier
        self.repoTitleLbl.isAccessibilityElement = true
        self.repoDescLbl.accessibilityIdentifier = Constants.repoDescIdentifier
        self.repoDescLbl.isAccessibilityElement = true
        self.repoLanguageLbl.accessibilityIdentifier = Constants.repoLanguageIdentifier
        self.repoLanguageLbl.isAccessibilityElement = true
        self.repoForksCountLbl.accessibilityIdentifier = Constants.repoForksIdentifier
        self.repoForksCountLbl.isAccessibilityElement = true
        self.repoCreationDateLbl.accessibilityIdentifier = Constants.repoDateIdentifier
        self.repoCreationDateLbl.isAccessibilityElement = true
    }
    
    fileprivate func setImageControl() {
        
        self.repoOwnerImageView.isUserInteractionEnabled = true
        self.imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleZoomTap(_:)))
        self.repoOwnerImageView.addGestureRecognizer(self.imageTapGesture)
        self.setImageViewsAccessibility()
    }
    
    @objc func handleZoomTap(_ sender: UITapGestureRecognizer)
    {
        
        if let imageView = imageTapGesture.view as? UIImageView
        {
            self.performZoomInForStartingImageView(startingImageView: imageView)
        }
    }
    func performZoomInForStartingImageView(startingImageView: UIImageView)
    {
        self.zoomImageView = startingImageView
        
        
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.accessibilityIdentifier = Constants.repoOwnerZoomedInImageIdentifier
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOutTap)))
        if let keyWindow = UIApplication.shared.keyWindow
        {
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.alpha = 0
            blackBackgroundView?.backgroundColor = UIColor.black
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                let height = (self.startingFrame?.height)! / (self.startingFrame?.width)! * keyWindow.frame.width
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomingImageView.center = keyWindow.center
                
            }, completion: nil)
            
        }
    }
    
    @objc func handleZoomOutTap(tapGesture: UITapGestureRecognizer)
    {
        if let zoomOutImageView = tapGesture.view as? UIImageView {
            zoomOutImageView.layer.cornerRadius = 16
            zoomOutImageView.layer.masksToBounds = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
            }, completion: { (completed: Bool) in
                zoomOutImageView.removeFromSuperview()
            })
            
        }
    }
}
