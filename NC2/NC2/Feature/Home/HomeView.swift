//
//  ContentView.swift
//  NC2
//
//  Created by 이정동 on 6/16/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
        
            ContainerView()
            
        }
        .padding()
    }
}

fileprivate struct ContainerView: View {
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("오늘의 영어단어")
                    .font(.system(size: 30, weight: .bold))
                Spacer()
            }
            
            EnglishWordView()
            
            Spacer().frame(height: 40)
            
            ExampleSentence()
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                HStack {
                    Spacer()
                    Text("새로운 영어단어 불러오기")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            })
        }
    }
}

fileprivate struct EnglishWordView: View {
    
    fileprivate var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("homeostasis")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(.green)
                
                Spacer()
                
//                Button(action: {
//                    
//                }, label: {
//                    Image(systemName: "speaker.wave.2.fill")
//                        .font(.system(size: 25, weight: .medium))
//                        .tint(.black)
//                })
            }
            
            Spacer().frame(height: 40)
            
            Text("항상성, 생체 항상성, 정상성 동적 평형")
                .font(.system(size: 18, weight: .medium))
        }
        .padding()
        .background(Color(hex: "EAE8E8"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
            
    }
}

fileprivate struct ExampleSentence: View {
    
    fileprivate var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("예문")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
            }
            
            ForEach(0..<3) { int in
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("When we become insulin-resistant, the homeostasis in that balance deviates from this state.")
                            .font(.system(size: 16, weight: .medium))
                        Text("우리가 인슐린 저항성을 갖게 되면, 균형이 무너지면서 항상성을 유지할 수 없게 됩니다.")
                            .font(.system(size: 13, weight: .light))
                    }
                    Spacer()
                }
                .padding()
                .background(Color(hex: "EAE8E8"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        
    }
}

#Preview {
    HomeView()
}
