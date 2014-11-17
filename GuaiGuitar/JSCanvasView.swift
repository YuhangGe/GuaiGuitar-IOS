//
//  CDView.swift
//
//  Created by 葛羽航 on 14/9/28.
//

import UIKit

class JSCanvasView: UIView {
    
    var canvas : JSCanvas!
    var ctx : JSContext!
    
    private var _text : String = "Hello World! I love Guai!"
    var text : String {
        get {
            return _text
        }
        set(text) {
            _text = text
            self.setNeedsDisplay()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.canvas = JSCanvas(view: self)
        self.ctx = self.canvas.getContext("2d")
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canvas = JSCanvas(view: self)
        self.ctx = self.canvas.getContext("2d")
    }

    
    var _bg : String = "red"
    var background : String {
        get {
            return _bg
        }
        set(bg) {
            _bg = bg
        }
    }
    
    var fontSize : CGFloat {
        get {
            return ctx.fontSize
        }
        set {
            ctx.fontSize = 25
        }
    }
    
    func paint() {
        self.setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        ctx.setPaintContext(UIGraphicsGetCurrentContext())
        
        //draw with ctx. just like javascript.
        ctx.save()
        
        ctx.fillStyle = self._bg
        ctx.strokeStyle = self._bg
        
        ctx.fillRect(10, top: 10, width: 100, height: 100)
        ctx.strokeText(self._text, x: 10, y: 150)
        
        ctx.strokeCircle(100, centerY: 200, radius: 46)
        
        ctx.restore()
    }
    
    

}
