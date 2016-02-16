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
    case RECORD_ACTIVITY_VIEW = "RecordActivityView"
    case NAV_DRAWER_VIEW = "NavDrawerView"
    case ACTIVITY_HISTORY_VIEW = "ActivityHistoryView"
    case ACHIEVEMENT_VIEW = "AchievementView"
    case TRAIL_MAP_VIEW = "TrailMapView"
    case ACCOUNT_DETAILS_VIEW = "AccountDetailsView"
    case ACCOUNT_STATISTICS_VIEW = "AccountStatisticsView"
    case ABOUT_VIEW = "AboutView"
    
    case RECORD_ACTIVITY_NAV_CONTROLLER = "RecordActivityNavController"
    case CREATE_ACCOUNT_NAV_CONTROLLER = "CreateAccountNavController"
    case ACTIVITY_HISTORY_NAV_CONTROLLER = "ActivityHistoryNavController"
    case ACHIEVEMENT_NAV_CONTROLLER = "AchievementNavController"
    case TRAIL_MAP_NAV_CONTROLLER = "TrailMapNavController"
    case ACCOUNT_DETAILS_NAV_CONTROLLER = "AccountDetailsNavController"
    case ACCOUNT_STATISTICS_NAV_CONTROLLER = "AccountStatisticsNavController"
    case ABOUT_NAV_CONTROLLER = "AboutNavController"
}