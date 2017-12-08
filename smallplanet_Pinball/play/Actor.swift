//
//  Actor.swift
//  smallplanet_Pinball
//
//  Created by Quinn McHenry on 12/8/17.
//  Copyright © 2017 Rocco Bowling. All rights reserved.
//

import Foundation
import CoreImage
import CoreML
import Vision

struct Actor {
    
    lazy var model = tng_adam_0000()
    let size = CGSize(width: 128.0, height: 96.0)
    
    enum Action: Int {
        case nop = 0
        case left = 1
        case right = 2
        case plunger = 3
        case upperRight = 4
    }
    
    mutating func chooseAction(state: CIImage) -> Action {
        let buffer = pixelBuffer(ciImage: state)
        let output = try! model.prediction(images: buffer).output1
        let array = (0..<output.count).map { Double(output[$0]) }
        print(array)

        let actionRaw = choice(distribution: array)
        return Action(rawValue: actionRaw)!
    }
    
    let context = CIContext()
    
    func pixelBuffer(ciImage: CIImage) -> CVPixelBuffer {
        let buffer = createPixelBuffer(width: Int(size.width), height: Int(size.height))!
        context.render(ciImage, to: buffer)
        return buffer
    }
    
    let p = PRNG()
    
    func choice(distribution: [Double]) -> Int {
        var rand = Double(p.getRandomNumberf())
        var index = 0
        while rand > 0.0 && index < distribution.count - 1 {
            let diff = rand - distribution[index]
            if diff < 0 {
                return index
            }
            index += 1
            rand = diff
        }
        return index
    }
}
