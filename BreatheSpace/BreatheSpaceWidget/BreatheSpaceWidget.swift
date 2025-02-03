//
//  BreatheSpaceWidget.swift
//  BreatheSpaceWidget
//
//  Created by Echo Lumaque on 1/30/25.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct BreatheSpaceWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.purple.opacity(0.1)
            
            VStack {
                Text("BreatheSpace")
                    .font(.headline)
                    .foregroundStyle(Color.purple)
                
                Text("Take a moment to breathe")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }
}

struct BreatheSpaceWidget: Widget {
    private let supportedFamilies: [WidgetFamily] = [.systemSmall]
    let kind: String = "BreatheSpaceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                BreatheSpaceWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                BreatheSpaceWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("BreatheSpace")
        .description("Stay mindful throughout your day.")
        .supportedFamilies(supportedFamilies)
    }
}

#Preview {
    BreatheSpaceWidgetEntryView(entry: SimpleEntry(date: .now))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
}
