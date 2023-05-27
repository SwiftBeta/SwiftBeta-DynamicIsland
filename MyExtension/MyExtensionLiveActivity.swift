//
//  MyExtensionLiveActivity.swift
//  MyExtension
//
//  Created by Home on 6/5/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct MyExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliveryAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Image(systemName: "box.truck.badge.clock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.indigo)
                    .padding(.leading, 12)
                VStack(alignment: .leading) {
                    Text(context.state.productName)
                        .bold()
                    + Text(" está ")
                    + Text(context.state.deliveryStatus.rawValue)
                        .bold()
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Hora de entrega")
                    Text(context.state.estimatedArrivalDate)
                        .bold()
                }
                .padding(.trailing, 12)
            }

        } dynamicIsland: { context in
            DynamicIsland {
                Text("")
            } compactLeading: {
                Text("")
            } compactTrailing: {
                Text("")
            } minimal: {
                Text("")
            }
        }
    }
}

struct MyExtensionLiveActivity_Previews: PreviewProvider {
    static let attributes = DeliveryAttributes()
    static let contentState = DeliveryAttributes.ContentState(deliveryStatus: .sent, productName: "Camiseta 20€", estimatedArrivalDate: "21:00")

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
