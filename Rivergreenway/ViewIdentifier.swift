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
    case ACTIVITY_HISTORY_VIEW = "ActivityHistoryView"
    case ACHIEVEMENT_VIEW = "AchievementView"
    case TRAIL_MAP_VIEW = "TrailMapView"
    
    case TRAIL_ACTIVITY_NAV_CONTROLLER = "TrailActivityNavController"
    case CREATE_ACCOUNT_NAV_CONTROLLER = "CreateAccountNavController"
    case ACTIVITY_HISTORY_NAV_CONTROLLER = "ActivityHistoryNavController"
    case ACHIEVEMENT_NAV_CONTROLLER = "AchievementNavController"
    case TRAIL_MAP_NAV_CONTROLLER = "TrailMapNavController"
}