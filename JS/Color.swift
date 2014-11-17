//
//  JSColor.swift
//
//  Created by Yuhang Ge on 14/11/14.
//

import UIKit

private let colorRegex1 = Regex("^#[a-fA-F0-9]{3}$")
private let colorRegex2 = Regex("^#[a-fA-F0-9]{6}$")
private let colorRegex3 = Regex("^\\s*rgb\\s*\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*\\)\\s*$")
private let colorRegex4 = Regex("^\\s*rgba\\s*\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d*(\\.\\d*)?)\\s*\\)\\s*$")
private let colorTable : Dictionary<String, UIColor> = [
    "aliceblue" : hex2color("#f0f8ff", false),
    "antiquewhite" : hex2color("#faebd7", false),
    "aqua" : hex2color("#00ffff", false),
    "aquamarine" : hex2color("#7fffd4", false),
    "azure" : hex2color("#f0ffff", false),
    "beige" : hex2color("#f5f5dc", false),
    "bisque" : hex2color("#ffe4c4", false),
    "black" : hex2color("#000000", false),
    "blanchedalmond" : hex2color("#ffebcd", false),
    "blue" : hex2color("#0000ff", false),
    "blueviolet" : hex2color("#8a2be2", false),
    "brown" : hex2color("#a52a2a", false),
    "burlywood" : hex2color("#deb887", false),
    "cadetblue" : hex2color("#5f9ea0", false),
    "chartreuse" : hex2color("#7fff00", false),
    "chocolate" : hex2color("#d2691e", false),
    "coral" : hex2color("#ff7f50", false),
    "cornflowerblue" : hex2color("#6495ed", false),
    "cornsilk" : hex2color("#fff8dc", false),
    "crimson" : hex2color("#dc143c", false),
    "cyan" : hex2color("#00ffff", false),
    "darkblue" : hex2color("#00008b", false),
    "darkcyan" : hex2color("#008b8b", false),
    "darkgoldenrod" : hex2color("#b8860b", false),
    "darkgray" : hex2color("#a9a9a9", false),
    "darkgrey" : hex2color("#a9a9a9", false),
    "darkgreen" : hex2color("#006400", false),
    "darkkhaki" : hex2color("#bdb76b", false),
    "darkmagenta" : hex2color("#8b008b", false),
    "darkolivegreen" : hex2color("#556b2f", false),
    "darkorange" : hex2color("#ff8c00", false),
    "darkorchid" : hex2color("#9932cc", false),
    "darkred" : hex2color("#8b0000", false),
    "darksalmon" : hex2color("#e9967a", false),
    "darkseagreen" : hex2color("#8fbc8f", false),
    "darkslateblue" : hex2color("#483d8b", false),
    "darkslategray" : hex2color("#2f4f4f", false),
    "darkslategrey" : hex2color("#2f4f4f", false),
    "darkturquoise" : hex2color("#00ced1", false),
    "darkviolet" : hex2color("#9400d3", false),
    "deeppink" : hex2color("#ff1493", false),
    "deepskyblue" : hex2color("#00bfff", false),
    "dimgray" : hex2color("#696969", false),
    "dimgrey" : hex2color("#696969", false),
    "dodgerblue" : hex2color("#1e90ff", false),
    "firebrick" : hex2color("#b22222", false),
    "floralwhite" : hex2color("#fffaf0", false),
    "forestgreen" : hex2color("#228b22", false),
    "fuchsia" : hex2color("#ff00ff", false),
    "gainsboro" : hex2color("#dcdcdc", false),
    "ghostwhite" : hex2color("#f8f8ff", false),
    "gold" : hex2color("#ffd700", false),
    "goldenrod" : hex2color("#daa520", false),
    "gray" : hex2color("#808080", false),
    "grey" : hex2color("#808080", false),
    "green" : hex2color("#008000", false),
    "greenyellow" : hex2color("#adff2f", false),
    "honeydew" : hex2color("#f0fff0", false),
    "hotpink" : hex2color("#ff69b4", false),
    "indianred" : hex2color("#cd5c5c", false),
    "indigo" : hex2color("#4b0082", false),
    "ivory" : hex2color("#fffff0", false),
    "khaki" : hex2color("#f0e68c", false),
    "lavender" : hex2color("#e6e6fa", false),
    "lavenderblush" : hex2color("#fff0f5", false),
    "lawngreen" : hex2color("#7cfc00", false),
    "lemonchiffon" : hex2color("#fffacd", false),
    "lightblue" : hex2color("#add8e6", false),
    "lightcoral" : hex2color("#f08080", false),
    "lightcyan" : hex2color("#e0ffff", false),
    "lightgoldenrodyellow" : hex2color("#fafad2", false),
    "lightgray" : hex2color("#d3d3d3", false),
    "lightgrey" : hex2color("#d3d3d3", false),
    "lightgreen" : hex2color("#90ee90", false),
    "lightpink" : hex2color("#ffb6c1", false),
    "lightsalmon" : hex2color("#ffa07a", false),
    "lightseagreen" : hex2color("#20b2aa", false),
    "lightskyblue" : hex2color("#87cefa", false),
    "lightslategray" : hex2color("#778899", false),
    "lightslategrey" : hex2color("#778899", false),
    "lightsteelblue" : hex2color("#b0c4de", false),
    "lightyellow" : hex2color("#ffffe0", false),
    "lime" : hex2color("#00ff00", false),
    "limegreen" : hex2color("#32cd32", false),
    "linen" : hex2color("#faf0e6", false),
    "magenta" : hex2color("#ff00ff", false),
    "maroon" : hex2color("#800000", false),
    "mediumaquamarine" : hex2color("#66cdaa", false),
    "mediumblue" : hex2color("#0000cd", false),
    "mediumorchid" : hex2color("#ba55d3", false),
    "mediumpurple" : hex2color("#9370db", false),
    "mediumseagreen" : hex2color("#3cb371", false),
    "mediumslateblue" : hex2color("#7b68ee", false),
    "mediumspringgreen" : hex2color("#00fa9a", false),
    "mediumturquoise" : hex2color("#48d1cc", false),
    "mediumvioletred" : hex2color("#c71585", false),
    "midnightblue" : hex2color("#191970", false),
    "mintcream" : hex2color("#f5fffa", false),
    "mistyrose" : hex2color("#ffe4e1", false),
    "moccasin" : hex2color("#ffe4b5", false),
    "navajowhite" : hex2color("#ffdead", false),
    "navy" : hex2color("#000080", false),
    "oldlace" : hex2color("#fdf5e6", false),
    "olive" : hex2color("#808000", false),
    "olivedrab" : hex2color("#6b8e23", false),
    "orange" : hex2color("#ffa500", false),
    "orangered" : hex2color("#ff4500", false),
    "orchid" : hex2color("#da70d6", false),
    "palegoldenrod" : hex2color("#eee8aa", false),
    "palegreen" : hex2color("#98fb98", false),
    "paleturquoise" : hex2color("#afeeee", false),
    "palevioletred" : hex2color("#db7093", false),
    "papayawhip" : hex2color("#ffefd5", false),
    "peachpuff" : hex2color("#ffdab9", false),
    "peru" : hex2color("#cd853f", false),
    "pink" : hex2color("#ffc0cb", false),
    "plum" : hex2color("#dda0dd", false),
    "powderblue" : hex2color("#b0e0e6", false),
    "purple" : hex2color("#800080", false),
    "red" : hex2color("#ff0000", false),
    "rosybrown" : hex2color("#bc8f8f", false),
    "royalblue" : hex2color("#4169e1", false),
    "saddlebrown" : hex2color("#8b4513", false),
    "salmon" : hex2color("#fa8072", false),
    "sandybrown" : hex2color("#f4a460", false),
    "seagreen" : hex2color("#2e8b57", false),
    "seashell" : hex2color("#fff5ee", false),
    "sienna" : hex2color("#a0522d", false),
    "silver" : hex2color("#c0c0c0", false),
    "skyblue" : hex2color("#87ceeb", false),
    "slateblue" : hex2color("#6a5acd", false),
    "slategray" : hex2color("#708090", false),
    "slategrey" : hex2color("#708090", false),
    "snow" : hex2color("#fffafa", false),
    "springgreen" : hex2color("#00ff7f", false),
    "steelblue" : hex2color("#4682b4", false),
    "tan" : hex2color("#d2b48c", false),
    "teal" : hex2color("#008080", false),
    "thistle" : hex2color("#d8bfd8", false),
    "tomato" : hex2color("#ff6347", false),
    "turquoise" : hex2color("#40e0d0", false),
    "violet" : hex2color("#ee82ee", false),
    "wheat" : hex2color("#f5deb3", false),
    "white" : hex2color("#ffffff", false),
    "whitesmoke" : hex2color("#f5f5f5", false),
    "yellow" : hex2color("#ffff00", false),
    "yellowgreen" : hex2color("#9acd32", false)
]

private func hex2value(hex: String, start : Int, single: Bool) -> CGFloat {
    let nstr = hex as NSString
    var sum : CGFloat = 0
    func _v(idx: Int) -> CGFloat{
        let c = nstr.characterAtIndex(idx)
        if (c >= 65 && c <= 70) {
            return (CGFloat)(c - 55)
        } else if (c >= 97 && c <= 102) {
            return (CGFloat)(c - 87)
        } else if (c >= 48 && c <= 57) {
            return (CGFloat)(c - 48)
        } else {
            return 0.0
        }
    }
    
    sum = _v(start)
    
    if(single) {
        sum = sum * 16.0 + sum
    } else {
        sum = sum * 16.0 + _v(start+1)
    }
    return sum / 255.0
}

private func hex2color(hex: String, single : Bool) -> UIColor {
    let r = hex2value(hex, 1, single)
    let g = hex2value(hex, single ? 2 : 3, single)
    let b = hex2value(hex, single ? 3 : 5, single)
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}

private func arr2color(arr: [String]!, alpha : Bool) -> UIColor {
    let r = arr[1] as NSString
    let g = arr[2] as NSString
    let b = arr[3] as NSString
    var fr = CGFloat(r.doubleValue)
    var gr = CGFloat(g.doubleValue)
    var br = CGFloat(b.doubleValue)
    fr = (fr > 255 ? 255 : (fr < 0 ? 0 : fr)) / 255
    gr = (gr > 255 ? 255 : (gr < 0 ? 0 : gr)) / 255
    br = (br > 255 ? 255 : (br < 0 ? 0 : br)) / 255
    
    if alpha {
        let a = arr[4] as NSString
        var da = CGFloat(a.doubleValue)
        da = da > 1 ? 1 : (da < 0 ? 0 : da)
        
        return UIColor(red:fr, green: gr, blue: br, alpha: da)
    } else {
        return UIColor(red:fr, green: gr, blue: br, alpha: 1.0)
    }
    
}

func str2color(str:String)->UIColor? {
    if(colorTable[str] != nil) {
        return colorTable[str]
    } else if(colorRegex2.test(str)) {
        return hex2color(str, false)
    } else if(colorRegex1.test(str)) {
        return hex2color(str, true)
    }
    
    var m = colorRegex4.exec(str)
    if(m != nil) {
        return arr2color(m!, true)
    }
    m = colorRegex3.exec(str)
    if(m != nil) {
        return arr2color(m!, false)
    }
    
    return nil
}