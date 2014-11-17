//
//  JSCanvas.swift
//
//  Created by Yuhang Ge on 14/9/28.
//

import UIKit

class JSCanvas {
    private var js_context : JSContext?
    private var js_view : UIView!
    
    private var _bounds : CGRect
    
    init(view : UIView) {
        self.js_view = view
        self._bounds = view.bounds
    }
    
    var width : CGFloat {
        get {
            return _bounds.width
        }
        set(width) {
            js_view.bounds = CGRect(origin: _bounds.origin, size: CGSize(width: width, height: _bounds.width))
            _bounds = js_view.bounds
        }
    }
    var height : CGFloat {
        get {
            return _bounds.height
        }
        set(height) {
            js_view.bounds = CGRect(origin: _bounds.origin, size: CGSize(width: _bounds.width, height: height))
            _bounds = js_view.bounds
        }
    }
    
    var size : CGSize {
        get {
            return _bounds.size
        }
        set(size) {
            js_view.bounds = CGRect(origin: _bounds.origin, size: size)
            _bounds = js_view.bounds
        }
    }
    
    func getContext(contextType : String) -> JSContext {
        if(js_context == nil) {
            js_context = JSContext(js_canvas: self)
        }
        return js_context!
    }
}