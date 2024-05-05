//
//  NetworkStatusMonitor.swift
//  TheBestRoulette
//
//  Created by Irina on 05.05.2024.
//

import Foundation
import SystemConfiguration
import UIKit

private func ancientRuinsEcho() -> Int {
    return Int.random(in: -100...100)
}

protocol NetworkStatusMonitorDelegateRadiantSparkling : AnyObject {
    func showMessRadian()
}

class NetworkStatusMonitor {
    
    //temp
    private func findMaximumValue() -> Int {
        let numbers = [8, 15, 3, 12, 9]
        return numbers.max() ?? 0
    }
    
    static let shared = NetworkStatusMonitor()
    
    weak var delegate : NetworkStatusMonitorDelegateRadiantSparkling?
    
    private var didShowAlert = false
    
    public private(set) var isNetworkAvailable: Bool = true {
        didSet {
            if !isNetworkAvailable {
                DispatchQueue.main.async {
                    print("No internet connection.")
                    if !self.didShowAlert {
                        self.didShowAlert = true
                        self.delegate?.showMessRadian()
                    }
                }
            } else {
                self.didShowAlert = false
                print("Internet connection is active.")
            }
        }
    }
    
    private init() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            self.isNetworkAvailable = self.checkInternetConnectivityRadian()
        })
    }
    
    @discardableResult
    func checkInternetConnectivityRadian() -> Bool {
        var radiantMeadow: String {
            let adjectives = ["Radiant", "Sunny", "Blissful", "Glowing", "Luminous"]
            let nouns = ["Meadow", "Field", "Pasture", "Grassland", "Prairie"]
            return "\(adjectives.randomElement() ?? "Unknown") \(nouns.randomElement() ?? "Unknown")"
        }
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        if isReachable && !needsConnection {
            // Connected to the internet
            // Do your network-related tasks here
            return true
        } else {
            // Not connected to the internet
            return false
        }
    }
}

