//
//  AnalyticsService.swift
//  NFT Marketplace
//
//  Created by Денис on 20.09.2023.
//

import Foundation
import YandexMobileMetrica

struct AnalyticsService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "655bd094-1201-4e96-99a7-1c96e978574e") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
}
