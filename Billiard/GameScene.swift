//
//  GameScene.swift
//  Billiard
//
//  Created by uics3 on 10/12/17.
//  Copyright © 2017 Yizhen Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
    //let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
    //let waiting = SKAction.wait(forDuration: 1.0)
    let fadeInAndOut = SKAction.sequence([.fadeAlpha(to: 1.0, duration: 0.5),
                                          .wait(forDuration: 1.0),
                                          .fadeAlpha(to: 0, duration: 0.5)])
    var actionCount = 0
    
    var moves = 0
    
    var ball = SKSpriteNode()
    
    var hitballs:[SKSpriteNode] = []
    var holes:[SKSpriteNode] = []
    
    var MoveLabel = SKLabelNode()
    var ScoreLabel = SKLabelNode()
    var hitball1 = SKSpriteNode()
    var hitball2 = SKSpriteNode()
    var hitball3 = SKSpriteNode()
    var hitball4 = SKSpriteNode()
    var hitball5 = SKSpriteNode()
    var hitball6 = SKSpriteNode()
    var hitball7 = SKSpriteNode()
    var hitball8 = SKSpriteNode()
    var hitball9 = SKSpriteNode()
    var hitball10 = SKSpriteNode()
    var hole1 = SKSpriteNode()
    var hole2 = SKSpriteNode()
    var hole3 = SKSpriteNode()
    var hole4 = SKSpriteNode()
    var moveAllow = true {
        didSet {
            
        }
    }
    var score:Int = 0 {
        didSet {
            ScoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        //fadeInAndOut = SKAction.sequence([fadeIn, waiting, fadeOut])
        ball = self.childNode(withName: "ball") as! SKSpriteNode
    
        hitball1 = self.childNode(withName: "hitball1") as! SKSpriteNode
        hitball2 = self.childNode(withName: "hitball2") as! SKSpriteNode
        hitball3 = self.childNode(withName: "hitball3") as! SKSpriteNode
        hitball4 = self.childNode(withName: "hitball4") as! SKSpriteNode
        hitball5 = self.childNode(withName: "hitball5") as! SKSpriteNode
        hitball6 = self.childNode(withName: "hitball6") as! SKSpriteNode
        hitball7 = self.childNode(withName: "hitball7") as! SKSpriteNode
        hitball8 = self.childNode(withName: "hitball8") as! SKSpriteNode
        hitball9 = self.childNode(withName: "hitball9") as! SKSpriteNode
        hitball10 = self.childNode(withName: "hitball10") as! SKSpriteNode
        
        hitballs = [hitball1, hitball2, hitball3, hitball4, hitball5, hitball6, hitball7, hitball8, hitball9, hitball10]
        
        hole1 = self.childNode(withName: "hole1") as! SKSpriteNode
        hole2 = self.childNode(withName: "hole2") as! SKSpriteNode
        hole3 = self.childNode(withName: "hole3") as! SKSpriteNode
        hole4 = self.childNode(withName: "hole4") as! SKSpriteNode
        
        holes = [hole1, hole2, hole3, hole4]
        
        self.physicsWorld.contactDelegate = self
        MoveLabel = self.childNode(withName: "moveLabel") as! SKLabelNode
        MoveLabel.alpha = 0.0
        ScoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        score = 0
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0.3
        border.restitution = 0.7
        
        self.physicsBody = border
        
        
    }
    
    var location_began: [CGPoint] = []
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            location_began.append(location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location2 = touch.location(in: self)
            let location1: CGPoint = location_began.popLast()!
            if moveAllow {
                ball.physicsBody?.applyImpulse(CGVector(dx: location2.x - location1.x, dy: location2.y - location1.y))
                moves += 1
                if moves == 3 {
                    moves = 0
                    score -= 1
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    func ballDidHitHole(ballNode:SKSpriteNode) {
        if ballNode.name == "ball"  {
            let explosion = SKEmitterNode(fileNamed: "BallParticle")!
            explosion.position = ballNode.position
            self.addChild(explosion)
            
            self.run(SKAction.wait(forDuration: 2)) {
                explosion.removeFromParent()
            }
            ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
            ball.position = CGPoint(x: 0, y: -240)
            score -= 10
            
        } else {
            let explosion = SKEmitterNode(fileNamed: "BallParticle")!
            explosion.position = ballNode.position
            self.addChild(explosion)
            
            ballNode.removeFromParent()
            self.run(SKAction.wait(forDuration: 2)) {
                explosion.removeFromParent()
            }
            score += 10
            
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func checkIfHit(hitball:SKSpriteNode, hole:SKSpriteNode) {
        let contactBodies:[SKPhysicsBody] = (hitball.physicsBody?.allContactedBodies())!
        for contactBody in contactBodies {
            if contactBody == hole.physicsBody {
                ballDidHitHole(ballNode: hitball)
            }
        }
    }
    override func sceneDidLoad() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ((ball.physicsBody?.velocity.dx)! < CGFloat(0.1)) && ((ball.physicsBody?.velocity.dy)! < CGFloat(0.1)) {
            if actionCount == 0{
                actionCount = 1
                MoveLabel.run(fadeInAndOut)
            }
            moveAllow = true
            
        } else {
            actionCount = 0
            moveAllow = false
        }
        for node1 in holes {
            for node2 in hitballs {
                checkIfHit(hitball:node2, hole:node1)
            }
            checkIfHit(hitball: ball, hole: node1)
        }
        if self.children.count <= 7 {
            ScoreClass.global.score = self.score
            ScoreClass.global.setHighest(self.score)
            if let view = self.view {
                if let scene = SKScene(fileNamed: "Final") {
                    scene.scaleMode = .aspectFit
                    view.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
                }
            }
        }
    }
    
}
