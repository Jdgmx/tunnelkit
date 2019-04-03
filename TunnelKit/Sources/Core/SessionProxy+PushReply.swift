//
//  SessionProxy+PushReply.swift
//  TunnelKit
//
//  Created by Davide De Rosa on 7/25/18.
//  Copyright (c) 2019 Davide De Rosa. All rights reserved.
//
//  https://github.com/keeshux
//
//  This file is part of TunnelKit.
//
//  TunnelKit is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  TunnelKit is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with TunnelKit.  If not, see <http://www.gnu.org/licenses/>.
//
//  This file incorporates work covered by the following copyright and
//  permission notice:
//
//      Copyright (c) 2018-Present Private Internet Access
//
//      Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//      The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//

import Foundation

/// Groups the parsed reply of a successfully started session.
public protocol SessionReply {

    /// The returned options.
    var options: OptionsBundle { get }
}

extension SessionProxy {

    // XXX: parsing is very optimistic
    
    struct PushReply: SessionReply, CustomStringConvertible {
        private static let prefix = "PUSH_REPLY,"
        
        private let original: String

        let options: OptionsBundle
        
        init?(message: String) throws {
            guard message.hasPrefix(PushReply.prefix) else {
                return nil
            }
            guard let prefixIndex = message.range(of: PushReply.prefix)?.lowerBound else {
                return nil
            }
            original = String(message[prefixIndex...])

            let lines = original.components(separatedBy: ",")
            options = try OptionsBundle(from: lines)
        }
        
        // MARK: CustomStringConvertible
        
        var description: String {
            let stripped = NSMutableString(string: original)
            OptionsBundle.Regex.authToken.replaceMatches(
                in: stripped,
                options: [],
                range: NSMakeRange(0, stripped.length),
                withTemplate: "auth-token"
            )
            return stripped as String
        }
    }
}
