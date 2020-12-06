//
//  MoveUpDownCalculation.swift
//  Rectangle
//
//  Created by Ryan Hanson on 7/26/19.
//  Copyright © 2019 Ryan Hanson. All rights reserved.
//

import Foundation

class MoveUpDownCalculation: WindowCalculation, RepeatedExecutionsCalculation {
    
    override func calculateRect(_ params: RectCalculationParameters) -> RectResult {
        
        let visibleFrameOfScreen = params.visibleFrameOfScreen
        
        var calculatedWindowRect: CGRect
        
        if Defaults.resizeOnDirectionalMove.enabled {
            calculatedWindowRect = calculateRepeatedRect(params).rect
        } else {
            calculatedWindowRect = calculateGenericRect(params).rect
        }
        
        if Defaults.centeredDirectionalMove.enabled != false {
            calculatedWindowRect.origin.x = round((visibleFrameOfScreen.width - calculatedWindowRect.width) / 2.0) + visibleFrameOfScreen.minX
        }
        
        if params.window.rect.width >= visibleFrameOfScreen.width {
            calculatedWindowRect.size.width = visibleFrameOfScreen.width
            calculatedWindowRect.origin.x = visibleFrameOfScreen.minX
        }
        
        return RectResult(calculatedWindowRect)

    }
    
    func calculateFirstRect(_ params: RectCalculationParameters) -> RectResult {
        return calculateGenericRect(params, fraction: 1 / 2.0)
    }
    
    func calculateSecondRect(_ params: RectCalculationParameters) -> RectResult {
        return calculateGenericRect(params, fraction: 2 / 3.0)
    }
    
    func calculateThirdRect(_ params: RectCalculationParameters) -> RectResult {
        return calculateGenericRect(params, fraction: 1 / 3.0)
    }
    
    func calculateGenericRect(_ params: RectCalculationParameters, fraction: Float? = nil) -> RectResult {
        let visibleFrameOfScreen = params.visibleFrameOfScreen
        
        var rect = params.window.rect
        if let requestedFraction = fraction {
            rect.size.height = floor(visibleFrameOfScreen.height * CGFloat(requestedFraction))
        }
        
        if params.action == .moveUp {
            rect.origin.y = visibleFrameOfScreen.maxY - rect.height
        } else {
            rect.origin.y = visibleFrameOfScreen.minY
        }
        
        return RectResult(rect)
    }
    
}

