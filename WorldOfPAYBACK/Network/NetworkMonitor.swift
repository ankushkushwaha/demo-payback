//
//  NetworkMonitor.swift
//  WorldOfPAYBACK
//
//  Created by ankush kushwaha
//

import Foundation
import Reachability

class NetworkMonitor: ObservableObject {
    @Published var isOnline: Bool = true
    
    private var reachability: Reachability?
    
    init() {
        setupNetworkObservers()
    }
    
    private func setupNetworkObservers() {
        do {
            reachability = try? Reachability()
            
            reachability?.whenReachable = { [weak self] reachability in
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                self?.isOnline = true
            }
            
            reachability?.whenUnreachable = { [weak self] _ in
                print("Not reachable")
                self?.isOnline = false
            }
            
            try reachability?.startNotifier()
            
        } catch {
            print("Reachability Could not initiate")
        }
    }
    
    deinit {
        reachability?.stopNotifier()
    }
}
