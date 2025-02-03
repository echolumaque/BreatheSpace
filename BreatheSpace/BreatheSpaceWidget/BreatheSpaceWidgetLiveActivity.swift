//
//  BreatheSpaceWidgetLiveActivity.swift
//  BreatheSpaceWidget
//
//  Created by Echo Lumaque on 1/30/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BreatheSpaceWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BreatheSpaceWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BreatheSpaceWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension BreatheSpaceWidgetAttributes {
    fileprivate static var preview: BreatheSpaceWidgetAttributes {
        BreatheSpaceWidgetAttributes(name: "World")
    }
}

extension BreatheSpaceWidgetAttributes.ContentState {
    fileprivate static var smiley: BreatheSpaceWidgetAttributes.ContentState {
        BreatheSpaceWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BreatheSpaceWidgetAttributes.ContentState {
         BreatheSpaceWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BreatheSpaceWidgetAttributes.preview) {
   BreatheSpaceWidgetLiveActivity()
} contentStates: {
    BreatheSpaceWidgetAttributes.ContentState.smiley
    BreatheSpaceWidgetAttributes.ContentState.starEyes
}
