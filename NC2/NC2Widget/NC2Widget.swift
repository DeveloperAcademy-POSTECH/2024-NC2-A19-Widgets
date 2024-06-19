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
            word: "😀",
            meaning: "안녕"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            word: "😀",
            meaning: "안녕"
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(
                date: Date(),
                word: "😀",
                meaning: "안녕"
            )
            entries.append(entry)
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
        case .systemMedium:
            SystemMediumView(entry: entry)
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
                    .containerBackground(for: .widget){
                        LinearGradient(
                            gradient: Gradient(colors: [.white, .green.opacity(0.5)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
            } else {
                NC2WidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

// MARK: - View
struct AccessoryRectangularView: View {
    var entry: Provider.Entry
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Label("오늘의 영단어", systemImage: "character.book.closed.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(3)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                
                Text(entry.word)
                    .font(.system(size: 18, weight: .bold))
                
                Text(entry.meaning)
                    .font(.system(size: 12, weight: .semibold))
            }
            
            Spacer()
        }
    }
}

struct SystemSmallView: View {
    var entry: Provider.Entry
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5) {
                Label("오늘의 영단어", systemImage: "character.book.closed.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(3)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.gray.opacity(0.5), .gray.opacity(0.65)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .foregroundStyle(.white)
                
                
                Text(entry.word)
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundStyle(                        LinearGradient(
                        gradient: Gradient(colors: [.green.opacity(0.65), .green.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    )
                
                Text(entry.meaning)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.52), .black.opacity(0.67)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                    .minimumScaleFactor(entry.meaning.count < 45 ? 1 : 0.80 )
                Spacer()
            }
            Spacer()
        }
    }
}


struct SystemMediumView: View {
    var entry: Provider.Entry
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Label("오늘의 영단어", systemImage: "character.book.closed.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(3)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.gray.opacity(0.5), .gray.opacity(0.65)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text("동사")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(3)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.gray.opacity(0.5), .gray.opacity(0.65)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                
            }
            
            HStack{
                Text(entry.word)
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundStyle(                        LinearGradient(
                        gradient: Gradient(colors: [.green.opacity(0.65), .green.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    )
                
                Spacer()
                Text(entry.meaning)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.52), .black.opacity(0.67)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .lineLimit(1)
            }
            
            Spacer().frame(height: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text("When we become insulin-resistant, the homeostasis in that balance deviates from this state.")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.52), .black.opacity(0.67)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.8)
                
                Text("우리가 인슐린 저항성을 갖게 되면, 균형이 무너지면서 항상성을 유지할 수 없게 됩니다.")
                    .font(.system(size: 11, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.52), .black.opacity(0.67)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.8)
            }
        }
    }
}


#Preview(as: .systemMedium) {
    //#Preview(as: .systemSmall) {
    NC2Widget()
} timeline: {
    SimpleEntry(
        date: Date(),
        word: "indicate",
        meaning: "나타내다, 표시하다\n\nThe study indicates a significant increase in global temperatures."
    )
    
    SimpleEntry(
        date: Date(),
        word: "Helloasdf",
        meaning: "나타내다, 표시하다"
    )
}
