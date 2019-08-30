//
//  GameScene.swift
//  Project11
//
//  Created by Justin Bengtson on 8/28/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    // Challenge 1 Create the list of availiable ball colors
    let ballArray = ["ballCyan", "ballRed", "ballYellow", "ballBlue", "ballPurple", "ballGreen", "ballGrey"]
    var numBallsLabel: SKLabelNode!
    
    var numBalls = 5 {
        didSet {
           numBallsLabel.text = "You have \(numBalls) balls left"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            }
            else {
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        numBallsLabel = SKLabelNode(fontNamed: "Chalkduster")
        numBallsLabel.text = "You have \(numBalls) balls left"
        numBallsLabel.horizontalAlignmentMode = .center
        numBallsLabel.position = CGPoint(x: 980 / 2, y: 700)
        addChild(numBallsLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if objects.contains(editLabel) {
            // Switches boolean value
            editingMode.toggle()
        }
        else {
            if editingMode {
                // Create a box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.name = "box"
                addChild(box)
            }
            else {
                if numBalls > 0 {
                
                // Challenge 1: Choose a random ball color string and set it to the ball variable
                let randomBallColor = ballArray.randomElement()
                let ball = SKSpriteNode(imageNamed: randomBallColor!)
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.restitution = 0.4
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                // Challenge 2: Just made the x location wherever the user touches and made y the top of the screen manually
                ball.position = CGPoint(x: location.x, y: 700)
                ball.name = "ball"
                addChild(ball)
                numBalls -= 1
            }
                
            }
        }
    }
    
    func makeBouncer(at postion: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = postion
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
        // Object won't be moved when colliding with objects
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        }
        else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func destroyBox(box: SKNode) {
        box.removeFromParent()
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            numBalls += 1
        }
        
        else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
        
        // Challenge 3
        else if object.name == "box" {
            destroyBox(box: object)
        }
    }
    
    // Removes the ball from the game
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        }
        else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
        
        // Challenge 3
        else if nodeB.name == "box" {
            collision(between: nodeB, object: nodeA)
        }
 
    }

}
