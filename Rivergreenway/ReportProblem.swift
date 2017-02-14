//
//  ReportProblem.swift
//  Rivergreenway
//
//  Created by Neil Rawlins on 2/7/17.
//  Copyright © 2017 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

class ReportProblem : DictionarySerializable {

    var problem: String

    init(problem: String) {
        self.problem = problem
    }
    
    init(_ decoder: JSONDecoder) throws {
        self.problem = try decoder["problem"].getString()
    }

    func toDictionary() -> [String: NSObject] {
        return [
                "problem" : problem
               ]
    }
}
