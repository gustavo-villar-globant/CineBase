//
//  Appearance.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/5/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation
import UIKit

/// Define App Colors

let primaryColor = UIColor(hex: "002954")
let textColor = UIColor.white


/// To modify the colors of the app change the 'tintColor' and 'BackButtonColor' constants
func customizeAppearance() {
    
    // Status Bar Appearance
    UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    // Navigation Bar Appearance
    UINavigationBar.appearance().titleTextAttributes=[NSForegroundColorAttributeName:UIColor.white]
    UINavigationBar.appearance().barTintColor = primaryColor
    UINavigationBar.appearance().isTranslucent = false
    // ToolBar Appearance
    UIToolbar.appearance().tintColor = textColor
    UIToolbar.appearance().barTintColor = primaryColor
    // Back Button Appearance
    UINavigationBar.appearance().tintColor = textColor
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:textColor]
    // UITableViewHeader appearance
    UITableViewHeaderFooterView.appearance().tintColor = primaryColor
    // UITabBar appearance
    UITabBar.appearance().tintColor = textColor
    UITabBar.appearance().barTintColor = primaryColor
    
}
