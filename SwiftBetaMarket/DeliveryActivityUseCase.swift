//
//  DeliveryActivityUseCase.swift
//  SwiftBetaMarket
//
//  Created by Home on 6/5/23.
//

import Foundation
import ActivityKit

final class DeliveryActivityUseCase {
    static func startActivity(deliveryStatus: DeliveryStatus,
                              productName: String,
                              estimatedArrivalDate: String) throws -> String {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return "" }

        let initialState = DeliveryAttributes.ContentState(deliveryStatus: deliveryStatus,
                                                           productName: productName,
                                                           estimatedArrivalDate: estimatedArrivalDate)
        
        // Añadimos 1 hora extra
        let futureDate: Date = .now + 3600
        
        let activityContent = ActivityContent(state: initialState,
                                              staleDate: futureDate)
        let attributes = DeliveryAttributes()
        do {
            let activity = try Activity.request(attributes: attributes,
                                                content: activityContent,
                                                pushType: nil)
            return activity.id
        } catch {
            throw error
        }
    }
    
    static func updateActivity(activityIdentifier: String,
                               newDeliveryStatus: DeliveryStatus,
                               productName: String,
                               estimatedArrivalDate: String) async {
        let updatedContentState = DeliveryAttributes.ContentState(deliveryStatus: newDeliveryStatus,
                                                                  productName: productName,
                                                                  estimatedArrivalDate: estimatedArrivalDate)
        let activity = Activity<DeliveryAttributes>.activities.first(where: { $0.id == activityIdentifier })
        
        let activityContent = ActivityContent(state: updatedContentState,
                                              staleDate: .now + 3600)
        
        await activity?.update(activityContent)
    }
    
    static func endActivity(withActivityIdentifier activityIdentifier: String) async {
        let value = Activity<DeliveryAttributes>.activities.first(where: { $0.id == activityIdentifier })
        await value?.end(nil)
    }
}
