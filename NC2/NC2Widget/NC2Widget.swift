//
//  NC2Widget.swift
//  NC2Widget
//
//  Created by 이정동 on 6/16/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            word: "Hello",
            meaning: "안녕하세요."
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            word: "Hello",
            meaning: "안녕하세요."
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            
            if let widgetData = UserDefaults.group?.getWidgetData() {
                let entry = SimpleEntry(
                    date: Date(),
                    word: widgetData.word,
                    meaning: widgetData.meaning
                )
                entries.append(entry)
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let word: String
    let meaning: String
}

struct NC2WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SystemSmallView(entry: entry)
        case .accessoryRectangular:
            AccessoryRectangularView(entry: entry)
        default:
            VStack {}
        }
    }
}

struct NC2Widget: Widget {
    let kind: String = "NC2Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                NC2WidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                NC2WidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .accessoryRectangular])
    }
}

// MARK: - View
struct AccessoryRectangularView: View {
    var entry: Provider.Entry
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Label("오늘의 영어단어", systemImage: "character.book.closed.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 5)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                
                Text(entry.word)
                    .font(.system(size: 18, weight: .black))
                
                Text(entry.meaning)
                    .font(.system(size: 12, weight: .bold))
            }
            
            Spacer()
        }
    }
}

struct SystemSmallView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview(as: .accessoryRectangular) {
    NC2Widget()
} timeline: {
    SimpleEntry(
        date: Date(),
        word: "Hello",
        meaning: "안녕"
    )
    SimpleEntry(
        date: Date(),
        word: "Hello",
        meaning: "안녕"
    )
}
