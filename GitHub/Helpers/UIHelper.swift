//
//  UIHelper.swift
//  GitHub
//
//  Created by mac on 7/24/19.
//  Copyright © 2019 OwnProjects. All rights reserved.
//

import Foundation
import SVProgressHUD
import TWMessageBarManager

class UIHelper {

    class func showInfoMessage(_ infoMessage: String?, title: String?) {
        if !TWMessageBarManager.sharedInstance().isMessageVisible {

            TWMessageBarManager.sharedInstance().showMessage(withTitle: title, description: infoMessage, type: .info, statusBarStyle: UIStatusBarStyle.lightContent, callback: nil)
        }
    }
    class func showSuccessMessage(_ message: String?, title: String?) {
        if !TWMessageBarManager.sharedInstance().isMessageVisible {
            TWMessageBarManager.sharedInstance().showMessage(withTitle: title, description: message, type: .success, statusBarStyle: UIStatusBarStyle.lightContent, callback: nil)
        }
    }
    class func showProgressBarWithDimView() {
        SVProgressHUD().defaultMaskType = .black
        SVProgressHUD().defaultAnimationType = .flat
        SVProgressHUD.setForegroundColor(UIColor(rgb: 10, green: 180, blue: 228, alpha: 1.0))
        SVProgressHUD.show()
    }
    class func dissmissProgressBar() {
        SVProgressHUD.dismiss()
    }


}



