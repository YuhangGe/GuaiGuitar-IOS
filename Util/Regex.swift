import UIKit;

class Regex {
    
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)!
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, countElements(input)))
        return matches.count > 0
    }
    
    func exec(input: String) -> [String]?{
        let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, countElements(input)))
        if matches.count == 0 {
            return nil
        }
        
        let ma = matches[0] as NSTextCheckingResult
        let mn = ma.numberOfRanges
        
        var rtn : Array<String> = Array<String>()
        let nstr = input as NSString
        
        for var i=0;i<mn;i++ {
            let r = ma.rangeAtIndex(i)
            rtn.append(nstr.substringWithRange(r))
        }
        
        return rtn
    }
}


