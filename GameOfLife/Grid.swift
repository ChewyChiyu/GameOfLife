//
//  Grid.swift
//  GameOfLife
//
//  Created by Evan Chen on 6/21/17.
//  Copyright © 2017 Evan Chen. All rights reserved.
//

import Foundation
import SpriteKit

class Grid: SKSpriteNode {
    let gridS = 38
    static let gridRows = 8
    static let gridCols = 10
    
    static var run = Timer()
    
    
    static var gridData = [[Creature]]()
    
    static var generation:Int = 0
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        super.isUserInteractionEnabled = true
        
        voidGrid()
        
        
        Grid.run.invalidate() //stops timer
        
    }
    func voidGrid(){
        for row in 0...Grid.gridRows-1{
            var gridLeg = [Creature]()
            for col in 0...Grid.gridCols-1{
                let creature = Creature(x:(Int(self.position.x-self.size.width/2)+(col*gridS)),y:Int(self.position.y)+(row)*gridS) //for some reason 
                gridLeg.append(creature)
                addChild(creature)
            }
            Grid.gridData.append(gridLeg)
        }
       
    }
    //just for testing
    func printGrid(){
        for row in 0..<Grid.gridData.count{
            for col in 0..<Grid.gridData[row].count{
                print(Grid.gridData[row][col].alpha , " ", terminator: "")
            }
            print("\n")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //seak out grid
        //10x8 grid
        if(Grid.run.isValid){
            return
        }
        for touch in touches{
            let recentTouch = touch.location(in: self)
            //seak for 2D array location
            let row = Int(Int(recentTouch.y) / gridS)
            let col = Int(Int(recentTouch.x) / gridS)
            
            if(Grid.gridData[row][col].alpha == 0){
            Grid.gridData[row][col].alpha = 1
            }else{
                Grid.gridData[row][col].alpha = 0
            }
           // printGrid()
        }
        
        
    }
    static func life(){
        //do life here
        
        
        
        //make a tempBoard
        print("life")
        var tempData = [[Bool]]()
        for row in 0...gridRows-1{
            var gridLeg = [Bool]()
            for col in 0...gridCols-1{
                if(gridData[row][col].alpha == 1){
                    gridLeg.append(true)
                }else{
                    gridLeg.append(false)
                }
            }
            tempData.append(gridLeg)
        }
        
        
        
        for row in 0..<gridData.count{
            for col in 0..<gridData.count{
                if row == 0 || col == 0 || row == gridRows-1 || col == gridCols-1 {
                    continue //break this iteration
                }
                
                    var neighbors:Int = 0
                    
                    if(gridData[row+1][col].alpha==1){
                        neighbors+=1
                    }
                    if(gridData[row-1][col].alpha==1){
                        neighbors+=1
                    }
                    if(gridData[row][col+1].alpha==1){
                        neighbors+=1
                    }
                    if(gridData[row][col-1].alpha==1){
                        neighbors+=1
                    }
                    if(gridData[row+1][col+1].alpha==1){
                        neighbors+=1
                    }
                    if(gridData[row-1][col-1].alpha==1){
                        neighbors+=1
                    }
                    if(gridData[row-1][col+1].alpha==1){
                        neighbors+=1
                    }
                    if(gridData[row+1][col-1].alpha==1){
                        neighbors+=1
                    }
                
                
                if(gridData[row][col].alpha == 1){ //check for survival
                    if (!(neighbors==3  ||  neighbors==2)) {
                        tempData[row][col] = false
                    }
                }else{
                    if(neighbors==3){  //check for birth
                        tempData[row][col] = true
                    }

                }
               
            }
            
        }
        
        //translate tempData to gridData
        for row in 0...gridRows-1{
            for col in 0...gridCols-1{
                if(tempData[row][col]){
                    gridData[row][col].alpha = 1
                    print("+",terminator: "")
                }else{
                    gridData[row][col].alpha = 0
                    print("-",terminator: "")
                }
            }
            print("\n")

        }
        
        generation+=1
        GameScene.generationNode.text = String(generation)

        
    }
    static func stop(){
        run.invalidate()
        for row in 0...gridRows-1{
            for col in 0...gridCols-1{
                gridData[row][col].alpha = 0
            }

        }
        
        generation = 0
    }
    static func start(){
        if(!run.isValid){
        run = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(life), userInfo: nil, repeats: true)
        }
    }
  
}
