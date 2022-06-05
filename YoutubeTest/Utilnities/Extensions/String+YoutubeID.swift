//
//  String+YoutubeID.swift
//  YoutubeTest
//
//  Created by Anh Nguyen on 05/06/2022.
//

import Foundation

extension String {
    func extractYoutubeIds() -> [String]? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
            let all = NSRange(location: 0, length: count)
            var matches = [String]()
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
                (result : NSTextCheckingResult?, _, _) in
                  if let r = result {
                        let nsstr = self as NSString
                        let result = nsstr.substring(with: r.range) as String
                        matches.append(result)
                  }
            }
            return matches
        } catch {
            return nil
        }
    }
    
    func extractVideosFromHTML() -> [Youtube]? {
        return extractYoutubeIds()?.map({ Youtube(id: $0) })
    }
}
