import Foundation
import ActivityKit

struct DeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var deliveryStatus: DeliveryStatus
        var productName: String
        var estimatedArrivalDate: String
    }
}
