//
//  ScoreBoard.swift
//  Billiard
//
//  Created by uics3 on 10/19/17.
//  Copyright © 2017 Yizhen Chen. All rights reserved.
//

import SpriteKit

class ScoreBoard: SKScene {
    
    
    override func sceneDidLoad() {
        var index = 0
        for UserScore in ScoreClass.global.getHighest() {
            index += 1
            if let nameLabel = self.childNode(withName: "nameLabel" + String(index)) as! SKLabelNode! {
                nameLabel.text = UserScore[0] as? String
                
            }
            if let scoreLabel = self.childNode(withName: "scoreLabel" + String(index)) as! SKLabelNode! {
                scoreLabel.text = String(UserScore[1] as! Int)
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let nodesAtTouch = self.nodes(at: touch.location(in: self))
            if nodesAtTouch.count > 0 {
                let nodeAtTouch = nodesAtTouch[0]
                if nodeAtTouch.name == "Back" {
                    nodeAtTouch.alpha = 0.5
                    
                }
            }
            
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let nodesAtTouch = self.nodes(at: touch.location(in: self))
            if nodesAtTouch.count > 0 {
                let nodeAtTouch = nodesAtTouch[0]
                if nodeAtTouch.name == "Back" {
                    nodeAtTouch.alpha = 1.0
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "MainMenu") {
                            scene.scaleMode = .aspectFit
                            view.presentScene(scene, transition: SKTransition.doorsCloseVertical(withDuration: 1.0))
                        }
                    }
                }
            }
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }

}
