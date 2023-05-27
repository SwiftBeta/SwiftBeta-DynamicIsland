//
//  DeliveryStatus.swift
//  SwiftBetaMarket
//
//  Created by Home on 6/5/23.
//

import Foundation

enum DeliveryStatus: String, Codable {
    case pending = ""
    case sent = "Enviado"
    case inTransit = "En Reparto"
    case delivered = "Entregado"
}
