//
//  Extensions.swift
//  Mandelbrot
//
//  Created by Jay Firke on 08/06/24.
//

import SwiftUI

extension MandelbrotView {
    func drawMandelbrot(in context: GraphicsContext, size: CGSize) {
        let maxIterations = 1000
        let minX: CGFloat = reversed ? 1.0 : -2.0
        let maxX: CGFloat = reversed ? -2.0 : 1.0
        let minY: CGFloat = reversed ? 1.5 : -1.5
        let maxY: CGFloat = reversed ? -1.5 : 1.5
        
        for x in 0..<Int(size.width) {
            for y in 0..<Int(size.height) {
                let real = map(value: CGFloat(x), inMin: 0, inMax: size.width, outMin: minX, outMax: maxX)
                let imag = map(value: CGFloat(y), inMin: 0, inMax: size.height, outMin: minY, outMax: maxY)
                let color = mandelbrotColor(real: real, imag: imag, maxIterations: maxIterations)
                context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(color))
            }
        }
    }
    private func mandelbrotColor(real: CGFloat, imag: CGFloat, maxIterations: Int) -> Color {
        var zReal = real
        var zImag = imag
        var iteration = 0
        
        while zReal * zReal + zImag * zImag <= 4 && iteration < maxIterations {
            let temp = zReal * zReal - zImag * zImag + real
            zImag = 2 * zReal * zImag + imag
            zReal = temp
            iteration += 1
        }
        
        if iteration == maxIterations {
            return .black
        } else {
            guard !colors.isEmpty else {
                return .white
            }
            return colors[iteration % colors.count]
        }
    }
    
    private func map(value: CGFloat, inMin: CGFloat, inMax: CGFloat, outMin: CGFloat, outMax: CGFloat) -> CGFloat {
        return (value - inMin) / (inMax - inMin) * (outMax - outMin) + outMin
    }
    
    func generateRandomColors() {
        colors = (0..<1000).map { _ in
            Color(hue: Double.random(in: 0...1), saturation: 1.0, brightness: 1.0)
        }
    }
}
