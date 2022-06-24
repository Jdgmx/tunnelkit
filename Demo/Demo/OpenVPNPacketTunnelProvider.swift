//
//  OpenVPNPacketTunnelProvider.swift
//  Demo
//
//  Created by Davide De Rosa on 9/15/17.
//  Copyright (c) 2022 Davide De Rosa. All rights reserved.
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

import Foundation
import TunnelKitOpenVPNAppExtension

class PacketTunnelProvider: OpenVPNTunnelProvider
{
	override func startTunnel(options: [String : NSObject]? = nil, completionHandler: @escaping (Error?) -> Void)
	{
		let appVersionNumber = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
		let appBuildNumber = Int(Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String)!

		appVersion = "Dispel \(appVersionNumber) \(appBuildNumber)"
		dnsTimeout = 5000
		logSeparator = "--- EOF ---"
		dataCountInterval = 5000

		super.startTunnel(options: options, completionHandler: completionHandler)
	}
}
