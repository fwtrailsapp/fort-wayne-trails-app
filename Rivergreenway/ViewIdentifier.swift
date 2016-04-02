//
//  ViewIdentifier.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

enum ViewIdentifier: String {
    case MAIN_STORYBOARD = "Main"
    
    case LoginView = "LoginView"
    case CreateAccountView = "CreateAccountView"
    case RecordActivityView = "RecordActivityView"
    case NavDrawerView = "NavDrawerView"
    case ActivityHistoryView = "ActivityHistoryView"
    case AchievementView = "AchievementView"
    case TrailMapView = "TrailMapView"
    case AccountDetailsView = "AccountDetailsView"
    case AccountStatisticsView = "AccountStatisticsView"
    case AboutView = "AboutView"
    
    case RecordActivityNavController = "RecordActivityNavController"
    case CreateAccountNavController = "CreateAccountNavController"
    case ActivityHistoryNavController = "ActivityHistoryNavController"
    case AchievementNavController = "AchievementNavController"
    case TrailMapNavController = "TrailMapNavController"
    case AccountDetailsNavController = "AccountDetailsNavController"
    case AccountStatisticsNavController = "AccountStatisticsNavController"
    case AboutNavController = "AboutNavController"
    
    case StartPauseSegue = "StartPauseSegue"
    case ResumeFinishSegue = "ResumeFinishSegue"
}
