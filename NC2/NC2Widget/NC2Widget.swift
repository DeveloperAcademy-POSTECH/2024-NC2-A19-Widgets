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
            meaning: "안녕하세요.",
            en: "En",
            ko: "Kr",
            partOfSpeech: "동사"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(
            date: Date(),
            word: "Hello",
            meaning: "안녕하세요.",
            en: "En",
            ko: "Kr",
            partOfSpeech: "동사"
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        if let widgetData = UserDefaults.group?.getWidgetData() {
            let entry = SimpleEntry(
                date: Date().test,
                word: widgetData.word,
                meaning: widgetData.meaning,
                en: widgetData.examples[0].english,
                ko: widgetData.examples[0].korean,
                partOfSpeech: widgetData.partOfSpeech
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
    let en: String
    let ko: String
    let partOfSpeech: String
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
                            gradient: Gradient(colors: [.white, .green.opacity(0.15), .green.opacity(0.42)]),
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
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular])
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
                    .font(.system(size: 16, weight: .black))
                    .minimumScaleFactor(0.5)
                
                
                Text(entry.meaning)
                    .font(.system(size: 12, weight: .bold))
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
                Spacer().frame(height: 2)
                
                
                VStack(alignment: .leading, spacing: 5){
                    Text(entry.word)
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.green.opacity(0.65), .green.opacity(0.8)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .minimumScaleFactor(0.8)
                        .lineLimit(1)
                    
                    Spacer().frame(height: 1)
                    
                    Text(entry.partOfSpeech)
                        .font(.system(size: 12, weight: .semibold))
                        .padding(3)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.gray.opacity(0.4), .gray.opacity(0.65)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .foregroundStyle(.white)
                        .lineLimit(3)
                    
                    Text("\(entry.meaning)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.47), .black.opacity(0.62)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
//                        .minimumScaleFactor(0.5)
                        .lineLimit(6)
                    
                }
//                .padding(.bottom)
                
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
                
                Text(entry.partOfSpeech)
                    .font(.system(size: 12, weight: .semibold))
                    .padding(3)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.gray.opacity(0.4), .gray.opacity(0.65)]),
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
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.green.opacity(0.65), .green.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .minimumScaleFactor(0.5)
                
                
                Spacer()
                Text(entry.meaning)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.52), .black.opacity(0.62)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .lineLimit(1)
            }
            
            Spacer().frame(height: 3)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(entry.en)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.47), .black.opacity(0.62)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Text(entry.ko)
                    .font(.system(size: 11, weight: .light))
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.47), .black.opacity(0.62)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .minimumScaleFactor(0.8)
        }
    }
}

#Preview(as: .systemSmall) {
//        #Preview(as: .systemMedium) {
    NC2Widget()
} timeline: {
    SimpleEntry(
        date: Date(),
        word: "comprehensive",
        meaning: "포괄적인, 종합적인",
        en: "The final exam was comprehensive, covering all the topics studied throughout the semester.",
        ko: "기말 시험은 종합적이어서 학기 동안 공부한 모든 주제를 다루었다.",
        partOfSpeech: "형용사"
    )
    
    SimpleEntry(
        date: Date(),
        word: "approach",
        meaning: "접근하다, 접근법",
        en: "We need to find a new approach to solve this problem.",
        ko: "이 문제를 해결하기 위해 새로운 접근법을 찾아야 한다.",
        partOfSpeech: "동사, 명사"
    )
}




