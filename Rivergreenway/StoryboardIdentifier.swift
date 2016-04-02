//
//  ViewIdentifier.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

// MARK: - View Identifiers
enum ViewIdentifier: String {
    case MAIN_STORYBOARD = "Main"
    
    // MARK: - Views
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
    
    // MARK: - Nav Controllers
    case RecordActivityNavController = "RecordActivityNavController"
    case CreateAccountNavController = "CreateAccountNavController"
    case ActivityHistoryNavController = "ActivityHistoryNavController"
    case AchievementNavController = "AchievementNavController"
    case TrailMapNavController = "TrailMapNavController"
    case AccountDetailsNavController = "AccountDetailsNavController"
    case AccountStatisticsNavController = "AccountStatisticsNavController"
    case AboutNavController = "AboutNavController"
    
    // MARK: - Segues
    case StartPauseSegue = "StartPauseSegue"
    case ResumeFinishSegue = "ResumeFinishSegue"
}

// MARK: - Nav Drawer Cell Identifiers
enum CellIdentifier: String {
    case RecordActivityCell = "RecordActivityCell"
    case ActivityHistoryCell = "ActivityHistoryCell"
    case AchievementsCell = "AchievementsCell"
    case TrailMapCell = "TrailMapCell"
    case AccountStatisticsCell = "AccountStatisticsCell"
    case AccountDetailsCell = "AccountDetailsCell"
    case AboutCell = "AboutCell"
    case ExitCell = "ExitCell"
}
