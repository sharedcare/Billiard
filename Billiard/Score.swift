//
//  Score.swift
//  Billiard
//
//  Created by uics3 on 10/20/17.
//  Copyright © 2017 Yizhen Chen. All rights reserved.
//

import Foundation

class ScoreClass {
    
    static var global = ScoreClass()
    
    var score = Int()
    var userName = String()
    
    let defaults = UserDefaults.standard
    
    func getHighest() -> Array<Array<Any>> {
        if defaults.object(forKey: "Users") != nil {
            return defaults.object(forKey: "Users") as! Array<Array<Any>>
        } else {
            return [["", 0], ["", 0], ["", 0], ["", 0], ["", 0]]
        }
    }
    
    func setHighest(_ userScore: Int) {
        var highest = getHighest()
        
        if userScore > (highest[4][1] as! Int) {
            highest.popLast()
            highest.append([userName, userScore])
            highest = highest.sorted {
                return ($0[1] as! Int) > ($1[1] as! Int)
            }
        }
        
        defaults.set(highest, forKey: "Users")
        
    }
    
}
