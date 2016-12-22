/*
 * QRCodeReader.swift
 *
 * Copyright 2014-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit

/// Overlay over the camera view to display the area (a square) where to scan the code.
public final class ReaderOverlayView: UIView {
    private var overlay: CAShapeLayer = {
        var overlay             = CAShapeLayer()
        overlay.backgroundColor = UIColor.clear.cgColor
        overlay.fillColor       = UIColor.clear.cgColor
        overlay.strokeColor     = UIColor.white.cgColor
        overlay.lineWidth       = 2
        overlay.lineDashPattern = [5.0, 6.0] //线段分割模式:表示先绘制3个点，再跳过3个点，如此反复
        overlay.lineDashPhase   = 0 //线条样式:表示在第一个虚线绘制的时候跳过多少个点
        
        return overlay
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupOverlay()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupOverlay()
    }
    
    private func setupOverlay() {
        layer.addSublayer(overlay)
    }
    
    public override func draw(_ rect: CGRect) {
        var innerRect = rect.insetBy(dx: 80, dy: 80)
        let minSize   = min(innerRect.width, innerRect.height)
        
        if innerRect.width != minSize {
            innerRect.origin.x   += (innerRect.width - minSize) / 2
            innerRect.size.width = minSize
        }
        else if innerRect.height != minSize {
            innerRect.origin.y    += (innerRect.height - minSize) / 2
            innerRect.size.height = minSize
        }
        
        let offsetRect = innerRect.offsetBy(dx: 0, dy: 0) //innerRect位置偏移
        
        overlay.path  = UIBezierPath(roundedRect: offsetRect, cornerRadius: 0).cgPath
    }
}

/// Overlay over the Reader Overlay View to display Animation when scan start.
public final class ReaderLineView: UIView {
    private var scanline: CAShapeLayer = {
        var line             = CAShapeLayer()
        line.backgroundColor = UIColor.clear.cgColor
        line.fillColor       = UIColor.clear.cgColor
        line.strokeColor     = UIColor.white.cgColor
        line.lineWidth       = 1
        line.lineDashPattern = [2.0, 4.0]
        line.lineDashPhase   = 0
        
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupOverlay()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupOverlay()
    }
    
    private func setupOverlay() {
        layer.addSublayer(scanline)
    }
    
    func drawLines() {
        //1 The Graphic Context is your graphic destination. If you want to draw on a view, the view is your Graphic Context. We need to get a reference to the Graphics Context.
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        //2 A path is a set of lines, arcs and curves you can draw on the current graphic context to build complex objects. Here we draw some lines and set the line width to 5.
        ctx.beginPath()
        ctx.move(to: CGPoint(x: 20.0, y: 20.0))
        ctx.addLine(to: CGPoint(x: 250.0, y: 100.0))
        ctx.setLineWidth(5)
        
        //3 The path is closed and drawn to the graphics context.
        ctx.closePath()
        ctx.strokePath()
    }
    
    func strokeLine() {
        let path = UIBezierPath()
        path.lineWidth = 2
        path.lineCapStyle = CGLineCap.round
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint.zero)
        path.stroke()
    }
    
    public override func draw(_ rect: CGRect) {
        var innerRect = rect.insetBy(dx: 100, dy: 100)
        let minSize   = min(innerRect.width, innerRect.height)
        
        if innerRect.width != minSize {
            innerRect.origin.x   += (innerRect.width - minSize) / 2
            innerRect.size.width = minSize
        }
        else if innerRect.height != minSize {
            innerRect.origin.y    += (innerRect.height - minSize) / 2
            innerRect.size.height = minSize
        }
        
        let offsetRect = innerRect.offsetBy(dx: 0, dy: 40)
        
        scanline.path  = UIBezierPath(roundedRect: offsetRect, cornerRadius: 5).cgPath
    }
}

