//
//  JSContext.swift
//
//  Created by Yuhang Ge on 14/9/28.
//

import UIKit

private let GlobalCompositeOperationTable : Dictionary<String, CGBlendMode> = [
    "source-over" : kCGBlendModeNormal,
    "source-in" : kCGBlendModeSourceIn,
    "source-out" : kCGBlendModeSourceOut,
    "source-atop" : kCGBlendModeSourceAtop,
    "xor" : kCGBlendModeXOR,
    "copy" : kCGBlendModeCopy,
    "lighter" : kCGBlendModePlusLighter,
    "destination-atop" : kCGBlendModeDestinationAtop,
    "destination-over" : kCGBlendModeDestinationOver,
    "destination-in" : kCGBlendModeDestinationIn,
    "destination-out" : kCGBlendModeDestinationOut
]

private let DEFAULT_FONT_SIZE : CGFloat = 12.0
private let DEFAULT_LINE_WIDTH : CGFloat = 1.0
private let DEFAULT_FONT_NAME : String = "Arial"

class JSContext {
    private var cg_context : CGContextRef!
    let canvas : JSCanvas
    
    private var _cgfont : CGFont = CGFontCreateWithFontName(DEFAULT_FONT_NAME)
    private var _uifont : UIFont!
    
    init(js_canvas : JSCanvas) {
        self.canvas = js_canvas
        
        let f = UIFont(name: DEFAULT_FONT_NAME, size: DEFAULT_FONT_SIZE)
        if f == nil {
            fatalError("could not init JSContext")
        }
        self._uifont = f!
        self._font = String("\(DEFAULT_FONT_SIZE)px \(DEFAULT_FONT_NAME)")

        self._fontAttrs[NSFontAttributeName] = self._uifont
        self._fontAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        
        self._fontStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        self._fontStyle.alignment = NSTextAlignment.Left
        
        self._fontAttrs[NSParagraphStyleAttributeName] = self._fontStyle
        
    }
    
    private func _drawText(text : String, x: CGFloat, y:CGFloat, mode: CGTextDrawingMode, maxWidth: CGFloat = 0) {
        if maxWidth <= 0 {
            
        } else {
            //todo deal with maxWIdth
        }
        
        //todo deal with textAlign
        
        CGContextSetTextDrawingMode(self.cg_context, mode)
        
        let tt = text as NSString
        //        let size = tt.sizeWithAttributes(attrs)
        
        tt.drawAtPoint(CGPoint(x: x, y: y), withAttributes: self._fontAttrs)
        
    }

    
    func setPaintContext(ctx : CGContextRef) {
        self.cg_context = ctx
        CGContextSetShouldAntialias(self.cg_context, true)
        CGContextSetShouldSmoothFonts(self.cg_context, true)
        CGContextSetLineWidth(self.cg_context, self.lineWidth)
    }
    
    private var _antialas : Bool = true
    var antilas : Bool {
        get {
            return _antialas
        }
        set(anitalas) {
            self._antialas = antilas
            CGContextSetShouldAntialias(self.cg_context, true)
        }
    }
    
    private var _smoothFonts : Bool = true
    var smoothFonts : Bool {
        get {
            return _smoothFonts
        }
        set(smoothFonts) {
            self._smoothFonts = smoothFonts
            CGContextSetShouldSmoothFonts(self.cg_context, smoothFonts)
        }
    }
    
    private var _fillColor : UIColor = UIColor.blackColor()
    private var _fillStyle : String = "black"
    //todo deal with gradient and pattern
    var fillStyle : String {
        get {
            return self._fillStyle
        }
        set(fillStyle) {
            var color = str2color(fillStyle)
            if(color != nil) {
                self._fillStyle = fillStyle
                self._fillColor = color!
                CGContextSetFillColorWithColor(self.cg_context, self._fillColor.CGColor)
            }
        }
    }
    
    private var _fontStyle : NSMutableParagraphStyle
    
    private var _fontFamily: String = DEFAULT_FONT_NAME
    var fontFamily : String {
        get {
            return self._fontFamily
        }
        set(fontFamily) {
            if fontFamily == self._fontFamily {
                return
            }
            let f = UIFont(name: fontFamily, size: self._fontSize)
            if f == nil {
                return
            }
            self._fontFamily = fontFamily
            self._uifont = f!
            self._fontAttrs[NSFontAttributeName] = self._uifont
            self._font = String("\(self._fontSize)px \(self._fontFamily)")
            
        }
    }
    
    private var _fontSize : CGFloat = DEFAULT_FONT_SIZE
    var fontSize : CGFloat {
        get {
            return self._fontSize
        }
        set(fontSize) {
            if fontSize <= 0 || fontSize == self._fontStyle {
                return
            }
            let f = UIFont(name: self._fontFamily, size: fontSize)
            if f == nil {
                return
            }
            self._fontSize = fontSize
            self._uifont = f!
            self._fontAttrs[NSFontAttributeName] = self._uifont
            self._font = String("\(self._fontSize)px \(self._fontFamily)")
        }
    }
    
    private var _fontAttrs : Dictionary<NSObject, AnyObject> = Dictionary<NSObject, AnyObject>()
    
    private var _font : String = String()
    var font : String {
        get {
            return _font
        }
        set(font) {
            //todo deal with css font string
        }
    }

    private var _strokeStyle : String = "black"
    private var _strokeColor : UIColor = UIColor.blackColor()
    //todo deal with gradient and pattern
    var strokeStyle : String {
        get {
            return self._strokeStyle
        }
        set(strokeStyle) {
            var color = str2color(strokeStyle)
            if(color != nil) {
                self._strokeStyle = strokeStyle
                self._strokeColor = color!
                CGContextSetStrokeColorWithColor(self.cg_context, self._strokeColor.CGColor)
            }
        }
    }
    
    private var _shadowColor : String = ""
    var shadowColor : String {
        get {
            return _shadowColor
        }
        set(shadowColor) {
            //todo
        }
    }
    
    private var _shadowBlur : String = ""
    var shadowBlur : String {
        get {
            return _shadowBlur
        }
        set(shadowBlur) {
            //todo
        }
    }
    
    private var _shadowOffsetY : String = ""
    var shadowOffsetY : String {
        get {
            return _shadowOffsetY
        }
        set(shadowOffsetY) {
            //todo
        }
    }
    
    private var _shadowOffsetX : String = ""
    var shadowOffsetX : String {
        get {
            return _shadowOffsetX
        }
        set(shadowOffsetX) {
            //todo
        }
    }
    
    private var _lineWidth : CGFloat = DEFAULT_LINE_WIDTH
    var lineWidth : CGFloat {
        get {
            return self._lineWidth
        }
        set(lineWidth) {
            self._lineWidth = lineWidth
            CGContextSetLineWidth(self.cg_context, lineWidth)
        }
    }
    
    private var _lineCap : String = "butt"
    var lineCap : String {
        get {
            return self._lineCap
        }
        set(lineCap) {
            let lcs = lineCap.lowercaseString
            var lc : CGLineCap?
            if lcs == "butt" {
                lc = kCGLineCapButt
            } else if lcs == "round" {
                lc = kCGLineCapRound
            } else if lcs == "square" {
                lc = kCGLineCapSquare
            } else {
                return
            }
            CGContextSetLineCap(self.cg_context, lc!)
            self._lineCap = lcs
        }
    }
    
    private var _lineJoin : String = "miter"
    var lineJoin : String {
        get {
            return self._lineJoin
        }
        set(lineJoin) {
            let ljs = lineJoin.lowercaseString
            var lj : CGLineJoin?
            if ljs == "miter" {
                lj = kCGLineJoinMiter
            } else if ljs == "round" {
                lj = kCGLineJoinRound
            } else if ljs == "bevel" {
                lj = kCGLineJoinBevel
            } else {
                return
            }
            CGContextSetLineJoin(self.cg_context, lj!)
            self._lineJoin = ljs
        }
    }
    
    private var _miterLimit: CGFloat = 1.0
    var miterLimit : CGFloat {
        get {
            return _miterLimit
        }
        set(miterLimit) {
            CGContextSetMiterLimit(self.cg_context, miterLimit)
            self._miterLimit = miterLimit
        }
    }
    
    private var _globalAlpha : CGFloat = 1.0
    var globalAlpha : CGFloat {
        get {
            return _globalAlpha
        }
        set(globalAlpha) {
            if globalAlpha >= 0 && globalAlpha <= 1.0 {
                self._globalAlpha = globalAlpha
                CGContextSetAlpha(self.cg_context, globalAlpha)
            }
        }
    }
    
    private var _globalCompositeOperation : String = "source-over"
    var globalCompositeOperation : String {
        get {
            return _globalCompositeOperation
        }
        set(globalCompositeOperation) {
            let gc = globalCompositeOperation.lowercaseString
            let gco = GlobalCompositeOperationTable[gc]
            if gco != nil {
                CGContextSetBlendMode(self.cg_context, gco!)
                self._globalCompositeOperation = gc
            }
        }
    }
    
    func save() {
        CGContextSaveGState(self.cg_context)
    }
    
    func restore() {
        CGContextRestoreGState(self.cg_context)
    }
    
    func beginPath() {
        CGContextBeginPath(self.cg_context)
    }
    
    func closePath() {
        CGContextClosePath(self.cg_context)
    }
    
    func moveTo(x : CGFloat, y: CGFloat) {
        CGContextMoveToPoint(self.cg_context, x, y)
    }
    
    func moveTo(point: CGPoint) {
        CGContextMoveToPoint(self.cg_context, point.x, point.y)
    }
    
    func lineTo(x : CGFloat, y: CGFloat) {
        CGContextAddLineToPoint(self.cg_context, x, y)
    }
    
    func lineTo(point: CGPoint) {
        CGContextAddLineToPoint(self.cg_context, point.x, point.y)
    }
    
    func arcTo(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2:CGFloat, radius:CGFloat) {
        CGContextAddArcToPoint(self.cg_context, x1, y1, x2, y2, radius)
    }
    func arcTo(point1: CGPoint , point2:CGPoint, radius:CGFloat) {
        CGContextAddArcToPoint(self.cg_context, point1.x, point1.y, point2.x, point2.y, radius)
    }
    
    func arc(centerX: CGFloat, centerY:CGFloat, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, counterclockwise: Bool = false) {
        CGContextAddArc(self.cg_context, centerX, centerY, radius, startAngle, endAngle, counterclockwise ? 0 : 1)
    }
    
    func quadraticCurveTo(cpx: CGFloat, cpy:CGFloat, x:CGFloat, y:CGFloat) {
        CGContextAddQuadCurveToPoint(self.cg_context, cpx, cpy, x, y)
    }
    func quadraticCurveTo(controlPoint:CGPoint, endPoint: CGPoint) {
        CGContextAddQuadCurveToPoint(self.cg_context, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y)
    }
    func bezierCurveTo(cp1x: CGFloat, cp1y:CGFloat, cp2x:CGFloat, cp2y:CGFloat, x:CGFloat, y:CGFloat) {
        CGContextAddCurveToPoint(self.cg_context, cp1x, cp1y, cp2x, cp2y, x, y)
    }
    func bezierCurveTo(controlPoint1:CGPoint, controlPoint2:CGPoint, endPoint: CGPoint) {
        CGContextAddCurveToPoint(self.cg_context, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y)
    }
    
    func curveTo(cp1x: CGFloat, cp1y:CGFloat, cp2x:CGFloat, cp2y:CGFloat, x:CGFloat, y:CGFloat) {
        CGContextAddCurveToPoint(self.cg_context, cp1x, cp1y, cp2x, cp2y, x, y)
    }
    func curveTo(controlPoint1:CGPoint, controlPoint2:CGPoint, endPoint: CGPoint) {
        CGContextAddCurveToPoint(self.cg_context, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y)
    }
    
    func isPointInPath(x: CGFloat, y: CGFloat) -> Bool {
        return CGContextPathContainsPoint(self.cg_context, CGPoint(x: x, y: y), kCGPathFill)
    }
    
    func clip() {
        CGContextClip(self.cg_context)
    }
    
    func fill() {
        CGContextFillPath(self.cg_context)
    }
    
    func stroke() {
        CGContextStrokePath(self.cg_context)
    }
    
    func rect(left: CGFloat, top: CGFloat, width:CGFloat, height:CGFloat) {
        let rect = CGRect(x: left, y: top, width: width, height: height)
        CGContextAddRect(self.cg_context, rect)
    }
    
    func fillRect(left:CGFloat, top:CGFloat, width:CGFloat,height:CGFloat) {
        let rect = CGRect(x: left, y: top, width: width, height: height)
        CGContextFillRect(self.cg_context, rect)
    }
    
    func strokeRect(left:CGFloat, top:CGFloat, width:CGFloat,height:CGFloat) {
        let rect = CGRect(x: left, y: top, width: width, height: height)
        CGContextStrokeRect(self.cg_context, rect)
    }
    
    func fillEllipse(centerX : CGFloat, centerY : CGFloat, radiusA : CGFloat, radiusB : CGFloat) {
        let rect = CGRect(x: centerX - radiusA, y: centerY - radiusB, width: radiusA * 2, height: radiusB * 2)
        CGContextFillEllipseInRect(self.cg_context, rect)
    }
    
    func fillEllipse(left:CGFloat, top:CGFloat, width:CGFloat,height:CGFloat) {
        let rect = CGRect(x: left, y: top, width: width, height: height)
        CGContextFillEllipseInRect(self.cg_context, rect)
    }
    
    func strokeEllipse(centerX : CGFloat, centerY : CGFloat, radiusA : CGFloat, radiusB : CGFloat) {
        let rect = CGRect(x: centerX - radiusA, y: centerY - radiusB, width: radiusA * 2, height: radiusB * 2)
        CGContextStrokeEllipseInRect(self.cg_context, rect)
    }
    
    func strokeEllipse(left:CGFloat, top:CGFloat, width:CGFloat,height:CGFloat) {
        let rect = CGRect(x: left, y: top, width: width, height: height)
        CGContextStrokeEllipseInRect(self.cg_context, rect)
    }
    
    func fillCircle(centerX: CGFloat, centerY: CGFloat, radius: CGFloat) {
        let rect = CGRect(x: centerX-radius, y: centerY - radius, width: radius * 2, height: radius * 2)
        CGContextFillEllipseInRect(self.cg_context, rect)
    }
    func strokeCircle(centerX: CGFloat, centerY: CGFloat, radius: CGFloat) {
        let rect = CGRect(x: centerX-radius, y: centerY - radius, width: radius * 2, height: radius * 2)
        CGContextStrokeEllipseInRect(self.cg_context, rect)
    }
    
    
    func setTransform(matrix: CGAffineTransform) {
        //apple do not apply function to direct set/reset transform
        //so we have to do it by hack.
        //see http://stackoverflow.com/questions/469505/how-to-reset-to-identity-the-current-transformation-matrix-with-some-cgcontext
        //由于ios没有提供直接地重置matrix的方法，所以cgContext没有html5的setTransform的等价函数
        //所以我们只能自己在matrix上进行计算处理。
        //这里会存在精度和性能的问题，但也没有办法，除非以后提供这个函数。坑爹的苹果。。。
        let m = self.getCurrentTransform()
        let im = CGAffineTransformInvert(m)
        CGContextConcatCTM(self.cg_context, im)
        CGContextConcatCTM(self.cg_context, matrix)
    }
    
    func setTransform(a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, tx: CGFloat, ty:CGFloat) {
        /*
         *
        
        IOS CGAffineTransform Fields:
        
        a : The entry at position [1,1] in the matrix.
        b : The entry at position [1,2] in the matrix.
        c : The entry at position [2,1] in the matrix.
        d : The entry at position [2,2] in the matrix.
        tx : The entry at position [3,1] in the matrix.
        ty : The entry at position [3,2] in the matrix.
        
        The matrix is like:
       
        [ a  b  0 ]
        [ c  d  0 ]
        [ tx ty 1 ]
        
        and:
                                     [ a  b  0 ]
        [ x' y' 1 ] = [ x y 1 ]  x   [ c  d  0 ]
                                     [ tx ty 1 ]
        x' = x*a + y*c + tx
        y' = x*b + y*d + ty
        
        HTML5(Javascript) Canvas Transform Fileds:
        a	Scales the drawings horizontally
        b	Skews the drawings horizontally
        c	Skews the drawings vertically
        d	Scales the drawings vertically
        tx	Moves the the drawings horizontally
        ty	Moves the the drawings vertically
        
        Matrix is like:
        
        [ a  c  tx ]
        [ b  d  ty ]
        [ 0  0    1  ]
        
        and:
        
        -                           -
        x'      [ a  c  tx ]        x
        y'  =   [ b  d  ty ]  x     y
        1       [ 0  0  1  ]        1
        -                           -
        
        x' = a*x + c*y + tx
        y' = b*x + d*y + ty
        
        So, actually, they are same.
        
         */
        let m = CGAffineTransform(a: a, b: b, c: c, d: d, tx: tx, ty: ty)
        self.setTransform(m)
    }
    
    func getCurrentTransform() -> CGAffineTransform {
        return CGContextGetCTM(self.cg_context)
    }
    
    var currentTransform : CGAffineTransform {
        get {
            return self.getCurrentTransform()
        }
        set(matrix) {
            self.setTransform(matrix)
        }
    }
    
    func transform(matrix: CGAffineTransform) {
        CGContextConcatCTM(self.cg_context, matrix)
    }
    
    func transform(a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, tx: CGFloat, ty:CGFloat) {
        let m = CGAffineTransform(a: a, b: b, c: c, d: d, tx: tx, ty: ty)
        self.transform(m)
    }
    
    func translate(x: CGFloat, y : CGFloat) {
        CGContextTranslateCTM(self.cg_context, x, y)
    }
    
    func scale(xScale : CGFloat, yScale: CGFloat) {
        CGContextScaleCTM(self.cg_context, xScale, yScale)
    }
    
    func rotate(angle: CGFloat) {
        CGContextRotateCTM(self.cg_context, angle)
    }
   
    func clearRect(left:CGFloat, top:CGFloat, width:CGFloat, height:CGFloat) {
        let rect = CGRect(x: left, y: top, width: width, height: height)
        CGContextClearRect(self.cg_context, rect)
    }
    
    func drawImage(img: CGImage, x: Int, y: Int) {
        //todo 这个地方图片绘制可能颠倒
        //see
        self.drawImage(img, x: x, y: y, width: CGImageGetWidth(img), height: CGImageGetHeight(img))
    }
    
    func drawImage(img:CGImage, x: Int, y: Int, width: UInt, height: UInt) {
        let rect = CGRect(x: x, y: y, width: Int(width), height: Int(height))
        CGContextDrawImage(self.cg_context, rect, img)
    }
    
    func drawImage(img : CGImage,sx :Int,sy:Int,swidth:UInt,sheight:UInt,x:Int,y:Int,width:UInt,height:UInt) {
        let src_rect = CGRect(x: sx, y: sy, width: Int(swidth), height: Int(sheight))
        let dst_img = CGImageCreateWithImageInRect(img, src_rect)
        self.drawImage(dst_img, x: x, y: y, width: width, height: height)
    }
    
    
    func fillText(text : String, x: CGFloat, y:CGFloat, maxWidth: CGFloat = 0) {
        self._fontAttrs[NSForegroundColorAttributeName] = self._fillColor
        self._drawText(text, x: x, y: y, mode: kCGTextFill, maxWidth: maxWidth)
    }
    
    func strokeText(text : String, x: CGFloat, y:CGFloat, maxWidth: CGFloat = 0) {
        self._fontAttrs[NSForegroundColorAttributeName] = self._strokeColor
        self._drawText(text, x: x, y: y, mode: kCGTextStroke, maxWidth: maxWidth)
    }
    
    func fillAndStrokeText(text : String, x: CGFloat, y:CGFloat, maxWidth: CGFloat = 0) {
        self._fontAttrs[NSForegroundColorAttributeName] = self._fillColor
        self._drawText(text, x: x, y: y, mode: kCGTextFillStroke, maxWidth: maxWidth)
    }
    
    func measureText(text: String) -> CGFloat {
        //todo
        return 0.0
    }
    
    private var _textAlign : String = "start"
    var textAlign : String {
        get {
            return _textAlign
        }
        set(textAlign) {
            let ta = textAlign.lowercaseString
            switch ta {
                case "start":
                    self._fontStyle.alignment = NSTextAlignment.Left
                    break
                case "end":
                    self._fontStyle.alignment = NSTextAlignment.Right
                    break
                case "left":
                    self._fontStyle.alignment = NSTextAlignment.Left
                    break
                case "right":
                    self._fontStyle.alignment = NSTextAlignment.Right
                    break
                case "center":
                    self._fontStyle.alignment = NSTextAlignment.Center
                    break
            default:
                return
            }
            
            self._textAlign = ta
        }
    }
    
}