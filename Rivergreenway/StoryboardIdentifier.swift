//
// Copyright (C) 2016 Jared Perry, Jaron Somers, Warren Barnes, Scott Weidenkopf, and Grant Grimm
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
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
