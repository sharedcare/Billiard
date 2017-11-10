//
//  MainMenu.swift
//  Billiard
//
//  Created by uics3 on 10/18/17.
//  Copyright © 2017 Yizhen Chen. All rights reserved.
//

import SpriteKit
import UIKit

class MainMenu: SKScene, UITextFieldDelegate{
    let textField = UITextField()
    var NodeEnabled = true
    //var TextNode = SKLabelNode()
        
    override func sceneDidLoad() {
        self.textField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view?.endEditing(true)
        return true
        
    }
    
    override func didMove(to view: SKView) {
        //TextNode = self.childNode(withName: "TextNode") as! SKLabelNode
        textField.frame = CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 100, width: 100, height: 40)
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.textColor = UIColor.black
        textField.font = UIFont(name: "helvetica", size: 16)
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.default
        
        //UIView.beginAnimations(<#T##animationID: String?##String?#>, context: <#T##UnsafeMutableRawPointer?#>)
        self.view?.addSubview(textField)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let nodesAtTouch = self.nodes(at: touch.location(in: self))
            if nodesAtTouch.count > 0 {
                let nodeAtTouch = nodesAtTouch[0]
                if nodeAtTouch.name == "New" {
                    nodeAtTouch.alpha = 0.5
                    
                } else if nodeAtTouch.name == "Score" {
                    nodeAtTouch.alpha = 0.5
                } else if nodeAtTouch.name == "About" {
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
                if nodeAtTouch.name == "New" && NodeEnabled {
                    ScoreClass.global.userName = textField.text!
                    nodeAtTouch.alpha = 1.0
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "GameScene") {
                            scene.scaleMode = .aspectFit
                            view.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 1.0))
                        }
                    }
                    self.textField.removeFromSuperview()
                } else if nodeAtTouch.name == "Score" {
                    nodeAtTouch.alpha = 1.0
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "ScoreBoard") {
                            scene.scaleMode = .aspectFit
                            view.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 1.0))
                        }
                    }
                    self.textField.removeFromSuperview()
                } else if nodeAtTouch.name == "About" {
                    nodeAtTouch.alpha = 1.0
                    if let view = self.view {
                        if let scene = SKScene(fileNamed: "About") {
                            scene.scaleMode = .aspectFit
                            view.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 1.0))
                        }
                    }
                    self.textField.removeFromSuperview()
                }
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if textField.text == "" {
            NodeEnabled = false
            self.childNode(withName: "New")?.alpha = 0.5
        } else {
            NodeEnabled = true
            self.childNode(withName: "New")?.alpha = 1.0
        }
    }
    

    
}

