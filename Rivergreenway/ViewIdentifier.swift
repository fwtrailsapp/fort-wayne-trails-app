//
//  ViewIdentifier.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

enum ViewIdentifier: String {
    case MAIN_STORYBOARD = "Main"
    
    case LOGIN_VIEW = "LoginView"
    case CREATE_ACCOUNT_VIEW = "CreateAccountView"
    case TRAIL_ACTIVITY_VIEW = "TrailActivityView"
    case NAV_DRAWER_VIEW = "NavDrawerView"
    
    case MAIN_NAV_CONTROLLER = "MainNavController"
    case CREATE_ACCOUNT_NAV_CONTROLLER = "CreateAccountNavController"
}