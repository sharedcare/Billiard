//
//  About.swift
//  Billiard
//
//  Created by uics3 on 10/20/17.
//  Copyright © 2017 Yizhen Chen. All rights reserved.
//

import SpriteKit

class About: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let nodesAtTouch = self.nodes(at: touch.location(in: self))
            if nodesAtTouch.count > 0 {
                let nodeAtTouch = nodesAtTouch[0]
                if nodeAtTouch.name == "Back1" {
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
                if nodeAtTouch.name == "Back1" {
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

}
