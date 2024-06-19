//
//  ContentView.swift
//  NC2
//
//  Created by 이정동 on 6/16/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) private var homeViewModel
    
    var body: some View {
        @Bindable var homeViewModel = homeViewModel
        VStack {
            ContainerView(homeViewModel: homeViewModel)
        }
        .padding()
        .alert(
            "새로운 영단어를 불러오시겠습니까?",
            isPresented: $homeViewModel.isAlert) {
                Button {
                    EngWordManager.shared.setRandomWord()
                } label: {
                    Text("확인")
                }

                Button(role: .cancel) {
                } label: {
                    Text("취소")
                }
            }
    }
}

fileprivate struct ContainerView: View {
    private var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("오늘의 영어단어")
                    .font(.system(size: 30, weight: .bold))
                Spacer()
            }
            
            EnglishWordView(homeViewModel: homeViewModel)
            
            Spacer().frame(height: 40)
            
            ExampleSentence(homeViewModel: homeViewModel)
            
            Spacer()
            
            Button(action: {
                homeViewModel.isAlert = true
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
    private var homeViewModel: HomeViewModel
    private var engWordManager = EngWordManager.shared
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(engWordManager.currentWord?.word ?? "None")")
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
            
            Text("\(engWordManager.currentWord?.meaning ?? "None")")
                .font(.system(size: 18, weight: .medium))
        }
        .padding()
        .background(Color(hex: "EAE8E8"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
            
    }
}

fileprivate struct ExampleSentence: View {
    private var homeViewModel: HomeViewModel
    private var engWordManager = EngWordManager.shared
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    fileprivate var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("예문")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
            }
            
            ForEach(engWordManager.currentWord?.examples ?? [], id: \.self) { example in
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(example.english)")
                            .font(.system(size: 16, weight: .medium))
                        Text("\(example.korean)")
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
        .environment(HomeViewModel())
}
