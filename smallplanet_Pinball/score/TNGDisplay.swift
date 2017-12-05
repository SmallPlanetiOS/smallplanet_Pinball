//
//  TNGDisplay.swift
//  smallplanet_Pinball
//
//  Created by Quinn McHenry on 12/1/17.
//  Copyright © 2017 Rocco Bowling. All rights reserved.
//

import Foundation

struct Display {

    enum Screen: String {
        case gameOver
        
        var displayScreen: DisplayScreen {
            switch self {
            case .gameOver: return Display.gameOver
            }
        }
    }
    
    static func calibrationAccuracy(bits: [UInt8]) -> Double {
        guard bits.count == calibration.count else { return .nan }
        let diff = bits.enumerated().map { (offset, element) in
            return element == calibration[offset] ? 0 : 1
        }
        let wrong = diff.reduce(0, +)
        return Double(bits.count - wrong)/Double(bits.count)
    }
    
    
    static let calibration: [UInt8] = [
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1,1,
        ]
    
//    let digitsBold: [[UInt32]] = [
//        [0x9000803e, 0x9004007f, 0x90040041, 0x97fc007f, 0x97fc103e], // 0
//        [0x07fc8000, 0x07b80006, 0xf000007f, 0xf000007f, 0x90000000], // 1
//        [0x90000062, 0x90000073, 0x90000059, 0x9000004f, 0x90400046], // 2
//        [0x90000022, 0x9000006b, 0x90000049, 0x9000487f, 0x90000036], // 3
//        [0x0000001e, 0x07fc001e, 0xf7fd0010, 0xf034007f, 0x97fc007f], // 4
//        [0x9010002f, 0x97fc006f, 0x97fc0045, 0x9400007d, 0x94000039], // 5
//        [0x9000003e, 0x9000407f, 0x90010045, 0x9000007d, 0x94000039], // 6
//        [0x00000003, 0x00000063, 0xf0000079, 0xf000101f, 0x90010007], // 7
//        [0x90000036, 0x9000007f, 0x90000049, 0x9000007f, 0x90000036], // 8
//        [0x90000026, 0x93f8006f, 0x97fc0049, 0x9404007f, 0xf7dc003e], // 9
//    ]

    static func findDigits(cols: [UInt32], pixelsDown: Int, font: DisplayFont) -> (Int?, Double) {
        
        let mask = (UInt32(1 << font.height) - 1) << pixelsDown
        
        func findDigit(col: Int) -> (Int?, Double) {
            guard col + font.width < cols.count else { return (nil, 0) }
            var matches = UInt(0)
            var bestMatch: (Int?, Double) = (nil, 0.0)
            let totalBits = font.width * font.height
            for digit in 0..<font.pixels.count {
                let digitBytes = font.pixels[digit]
                matches = 0
                digitBytes.enumerated().forEach { (arg) in
                    let (offset, element) = arg
                    let col8 = UInt32(cols[col + offset]) & mask
                    matches += UInt32(element << pixelsDown ^ col8).bitCount
//                    print("\(String(element << pixelsDown, radix: 2)) \(String(col8, radix: 2))")
                }
                let wrongBits = totalBits - Int(matches)
                let accuracy = Double(wrongBits)/Double(totalBits)
//                if accuracy > 0.85 {
//                    print("match: \(digit) \(accuracy*100.0)%  \(accuracy > 0.70 ? "*" : "")\(accuracy > 0.80 ? "*" : "")\(accuracy > 0.90 ? "*" : "")\(accuracy > 0.95 ? "*" : "")")
//                }
                if accuracy > 0.93 && bestMatch.1 < accuracy {
                    bestMatch = (digit, accuracy)
                }
            }
//            print("bestMatch: \(bestMatch)")
            return bestMatch
        }
        
        var col = 0
        var value = 0
        var wrongBits = 0
        var lastCol = -1
        var foundDigits = 0
        let fontSize = Double(font.width * font.height) // pixels per character
        
        while col < cols.count - font.width {
            let (digit, wrongs) = findDigit(col: col)
            if let digit = digit, (lastCol < 0 || lastCol + font.width < col) {
                wrongBits += Int((1.0-wrongs) * fontSize)
                value = value * 10 + digit
                lastCol = col
                col += 1
                foundDigits += 1
            } else {
                col += 1
            }
        }
        return foundDigits > 0 ? (value, (fontSize-Double(wrongBits))/fontSize) : (nil, 0.0)
    }
    
    static func findDigits(cols: [UInt32]) -> (Int?, Double) {
        // TODO: make this look for long gaps in reading numbers (like 1st & 2nd player scores) and stop reading
        // eventually make it aware of multiple player's scores
        let results = [
            findDigits(cols: cols, pixelsDown: 0, font: digits4x7),
            findDigits(cols: cols, pixelsDown: 0, font: digits5x7Bold),
            findDigits(cols: cols, pixelsDown: 0, font: digits6x7Bold),
            findDigits(cols: cols, pixelsDown: 3, font: digits9x20),
            findDigits(cols: Array(cols[30..<cols.count]), pixelsDown: 11, font: digits7x13), // simulation. left side can misread
            findDigits(cols: Array(cols[20..<111]), pixelsDown: 22, font: digits5x9), // shuttle simulation
        ]

        // Because a smaller font's 3 or 4 may match the next size up font's character exactly, it will
        // return a single digit of a matched number's value with 100% accuracy while the real number is matched
        // with a realistic, lower accuracy. This line favors longer results over smaller, more accurate ones
        let best = results.sorted { $0.1 > $1.1 }.sorted { ($0.0 ?? -1) > ($1.0 ?? -1) }
        return best.first ?? (nil, .nan)
    }
    

    typealias DisplayFont = (width: Int, height: Int, pixels: [[UInt32]])
    typealias DisplayScreen = (offset: Int, height: Int, pixelCols: [UInt32])
    
    static let digits4x7: DisplayFont = (width: 4, height: 7, pixels: [
        [0x3E, 0x41, 0x41, 0x3E], // 0
        [0x00, 0x02, 0x7F, 0x00], // 1
        [0x62, 0x51, 0x49, 0x46], // 2
        [0x22, 0x49, 0x49, 0x36], // 3
        [0x1E, 0x10, 0x7F, 0x10], // 4
        [0x2F, 0x45, 0x45, 0x39], // 5
        [0x3E, 0x45, 0x45, 0x39], // 6
        [0x03, 0x61, 0x19, 0x07], // 7
        [0x36, 0x49, 0x49, 0x36], // 8
        [0x26, 0x49, 0x49, 0x3F], // 9
    ])
    
    // 5x7 pixel bold font used in top-line score display (and elsewhere?)
    static let digits5x7Bold: DisplayFont = (width: 5, height: 7, pixels: [
        [0x3e, 0x7f, 0x41, 0x7f, 0x3e], // 0
        [0x00, 0x06, 0x7f, 0x7f, 0x00], // 1
        [0x62, 0x73, 0x59, 0x4f, 0x46], // 2
        [0x22, 0x6b, 0x49, 0x7f, 0x36], // 3
        [0x1e, 0x1e, 0x10, 0x7f, 0x7f], // 4
        [0x2f, 0x6f, 0x45, 0x7d, 0x39], // 5
        [0x3e, 0x7f, 0x45, 0x7d, 0x39], // 6
        [0x03, 0x63, 0x79, 0x1f, 0x07], // 7
        [0x36, 0x7f, 0x49, 0x7f, 0x36], // 8
        [0x26, 0x6f, 0x49, 0x7f, 0x3e], // 9
    ])
    
    // 6x7 pixel heavy font used in top-line score display (rare)
    static let digits6x7Bold: DisplayFont = (width: 6, height: 7, pixels: [
        [0x3E, 0x7F, 0x41, 0x41, 0x7F, 0x3E,], // 0
        [0x00, 0x00, 0x06, 0x7F, 0x7F, 0x00,], // 1 - Guess
        [0x62, 0x73, 0x59, 0x49, 0x4F, 0x46,], // 2
        [0xfeed], // 3
        [0x1E, 0x1E, 0x10, 0x7F, 0x7F, 0x10,], // 4
        [0x2F, 0x6F, 0x45, 0x45, 0x7D, 0x39,], // 5
        [0xfeed], // 6
        [0xfeed], // 7
        [0x36, 0x7F, 0x49, 0x49, 0x7F, 0x36],  // 8
        [0x26, 0x6F, 0x49, 0x49, 0x7F, 0x36,], // 9 - Guess
    ])
    
    // 5x9 pixel font used for score display in asteroid mode
    static let digits5x9: DisplayFont = (width: 5, height: 9, pixels: [
        [0x00FE,    0x01FF,    0x0101,    0x01FF,    0x00FE], // 0
        [0x0000,    0x0006,    0x01FF,    0x01FF,    0x0000], // 1
        [0x01C6,    0x01E7,    0x01B1,    0x019F,    0x018E], // 2
        [0x0082,    0x0183,    0x0111,    0x01FF,    0x00EE], // 3
        [0x003C,    0x003C,    0x0020,    0x01FF,    0x01FF], // 4
        [0x009F,    0x019F,    0x0109,    0x01F9,    0x00F1], // 5
        [0x00EE,    0x01FF,    0x0111,    0x01F3,    0x00E2], // 6
        [0x0007,    0x0187,    0x01E1,    0x007F,    0x001F], // 7
        [0x00EE,    0x01FF,    0x0111,    0x01FF,    0x00EE], // 8 - Guess
        [0x008E,    0x019F,    0x0111,    0x01FF,    0x00FE], // 9
    ])
    
    // 9x20 pixel font used for score during play
    static let digits9x20: DisplayFont = (width: 9, height: 20, pixels: [
        [0x03FFFC, 0x07FFFE, 0x0FFFFF, 0x0FFFFF, 0x0C0003, 0x0FFFFF, 0x0FFFFF, 0x07FFFE, 0x03FFFC], // 0
        [0x000000, 0x000000, 0x00003E, 0x0FFFFF, 0x0FFFFF, 0x0FFFFF, 0x0FFFFF, 0x000000, 0x000000], // 1
        [0x0F003C, 0x0FC03E, 0x0FF03F, 0x0FFC3F, 0x0EFF03, 0x0E3FFF, 0x0E0FFF, 0x0E03FE, 0x0E00FC], // 2
        [0x03C03C, 0x07C03E, 0x0FC03F, 0x0FC73F, 0x0C0703, 0x0FFFFF, 0x0FFFFF, 0x07FFFE, 0x03F8FC], // 3
        [0x0007FC, 0x0007FC, 0x0007FC, 0x000700, 0x0FFFFF, 0x0FFFFF, 0x0FFFFF, 0x0FFFFF, 0x000700], // 4
        [0x03C3FF, 0x07C3FF, 0x0FC3FF, 0x0FC3FF, 0x0C00C7, 0x0FFFC7, 0x0FFFC7, 0x07FF87, 0x03FF07], // 5
        [0x03FFFC, 0x07FFFE, 0x0FFFFF, 0x0FFFFF, 0x0C0303, 0x0FFF1F, 0x0FFF1F, 0x07FE1E, 0x03FC1C], // 6
        [0x0F001F, 0x0FC01F, 0x0FF01F, 0x0FFC1F, 0x00FF0F, 0x003FFF, 0x000FFF, 0x0003FF, 0x0000FF], // 7
        [0x03FC7C, 0x07FEFE, 0x0FFFFF, 0x0FFFFF, 0x0C0303, 0x0FFFFF, 0x0FFFFF, 0x07FEFE, 0x03FC7C], // 8
        [0x03C0FC, 0x07C1FE, 0x0FC3FF, 0x0FC3FF, 0x0C0303, 0x0FFFFF, 0x0FFFFF, 0x07FFFE, 0x03FFFC], // 9
    ])
    
    // 7x13 pixel font used for score display during search mission
    static let digits7x13: DisplayFont = (width: 7, height: 13, pixels: [
        [0x0FFE,    0x1FFF,    0x1FFF,    0x1803,    0x1FFF,    0x1FFF,    0x0FFE], // 0
        [0x0000,    0x000E,    0x1FFF,    0x1FFF,    0x1FFF,    0x0000,    0x0000], // 1
        [0x1E06,    0x1F87,    0x1FC7,    0x19E3,    0x187F,    0x183F,    0x181E], // 2
        [0x0E06,    0x1E07,    0x1E67,    0x1063,    0x1FFF,    0x1FDF,    0x0F8E], // 3
        [0x007C,    0x007C,    0x0060,    0x1FFF,    0x1FFF,    0x1FFF,    0x0060], // 4
        [0x0CFF,    0x1CFF,    0x1CFF,    0x1863,    0x1FE3,    0x1FE3,    0x0FC3], // 5
        [0x0FFE,    0x1FFF,    0x1FFF,    0x1863,    0x1FE7,    0x1FE7,    0x0FC6], // 6
        [0x0007,    0x0007,    0x1E07,    0x1FE3,    0x1FFF,    0x01FF,    0x001F], // 7
        [0x0F1E,    0x1FBF,    0x1FFF,    0x18E3,    0x1FFF,    0x1FBF,    0x0F1E], // 8
        [0x0C3E,    0x1C7F,    0x1C7F,    0x1863,    0x1FFF,    0x1FFF,    0x0FFE], // 9
    ])
    
    static func find(screen: DisplayScreen, cols: [UInt32]) -> Double {
        guard screen.pixelCols.count <= cols.count else { return 0.0 }
        let totalBits = screen.pixelCols.count * screen.height
        var matches = UInt(0)
        for col in 0..<screen.pixelCols.count {
            matches += UInt(screen.height) - UInt32(cols[col + screen.offset] ^ screen.pixelCols[col]).bitCount
        }
        return Double(matches) / Double(totalBits)
    }
    
    static func findScreen(cols: [UInt32]) -> (Screen, Double)? {
        let screens: [Screen] = [.gameOver]
        let results = screens.map{ ($0, find(screen: $0.displayScreen, cols: cols)) }
        return results.filter{ $0.1 > 0.9 }.sorted{ $0.1 > $1.1 }.first
    }

    static let gameOver: DisplayScreen = (offset: 30, height: 32, pixelCols: [
        0x1ffff80, 0x3ffffc0, 0x3ffffc0, 0x30000c0, 0x30f87c0, 0x3ff87c0, 0x3ff8780, 0x0, 0x3ffff80, 0x3ffffc0, 0x3ffffc0, 0x70c0, 0x3ffffc0, 0x3ffffc0, 0x3ffff80, 0x1000, 0x3ffffc0, 0x3ffffc0, 0x3ffffc0, 0x3ff00, 0x7ff800, 0x3fe00, 0x83ffffc0, 0xc3ffffc0, 0x83ffffc0, 0x0, 0x3ffffc0, 0x3ffffc0, 0x3ffffc0, 0x30060c0, 0x30260c0, 0x4010000, 0x0, 0x4200, 0x100000, 0x0, 0x2000, 0x1ffff80, 0x3ffffc0, 0x3ffffc0, 0x434020c0, 0x3ffffc0, 0x3ffffc0, 0x1ffffa0, 0x0, 0x81fc0, 0x1ffc0, 0x5fffc0, 0xfff000, 0x3fc0000, 0xfff000, 0x1fffc0, 0x1ffc0, 0x201fe0, 0x0, 0x13ffffc0, 0x13ffffc0, 0x3ffffc0, 0x300e0c0, 0x30060c0, 0x0, 0x3ffffc0, 0x3ffffc0, 0x3ffffc0, 0xe0c0, 0x3ffffc0, 0x3ffbfc0, 0x3ff1f80
        ])
    
    
}

extension UInt32 {
    
    public var bitCount: UInt {
        var c: UInt32 = self - ((self >> 1) & 0x55555555)
        c = ((c >> 2) & 0x33333333) + (c & 0x33333333)
        c = ((c >> 4) + c) & 0x0F0F0F0F
        c = ((c >> 8) + c) & 0x00FF00FF
        c = ((c >> 16) + c) & 0x0000FFFF
        return UInt(c)
    }
    
}
