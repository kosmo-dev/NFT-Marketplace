//
//  AppMetrics.swift
//  NFT Marketplace
//
//  Created by Денис on 20.09.2023.
//

import Foundation
import YandexMobileMetrica

protocol AppMetricsProtocol {
    func reportEvent(screen: String, event: AppMetricsParams.Event, item: AppMetricsParams.Item?)
}

class AppMetrics: AppMetricsProtocol {
    func reportEvent(screen: String, event: AppMetricsParams.Event, item: AppMetricsParams.Item?) {
        var paramenters = ["screen" : screen]
        if let item {
            paramenters["item"] = item.rawValue
         }
        print("Event:", event.rawValue, paramenters)
        YMMYandexMetrica.reportEvent(event.rawValue, parameters: paramenters)
    }
    
    
}
