//
//  ContentView.swift
//  AnimationsLab
//
//  Created by Kevin Bjornberg on 1/29/25.
//

import SwiftUI

struct ContentView: View {
    @State var countDown: String = ""
    @State var size: CGFloat = 1
    @State var fade: Bool = true
    
    func textBig() {
        size = 1
        fade = false
    }
    
    func numAnimate() {
        if size == 1 {
            withAnimation(.bouncy) {
                size = 0.1
            } completion: {
                fade = true
            }
        }
    }
    
    func animateText() {
        countDown = "3"
        textBig()
        numAnimate()
        
        Task { @MainActor in
            try await Task.sleep(for: .seconds(1))
            countDown = "2"
            textBig()
            numAnimate()
            
            Task { @MainActor in
                try await Task.sleep(for: .seconds(1))
                countDown = "1"
                textBig()
                numAnimate()
                
                Task { @MainActor in
                    try await Task.sleep(for: .seconds(1))
                    countDown = "GO!"
                    textBig()
                    numAnimate()
                }
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text(countDown)
                    .font(.system(size: 200, weight: .regular, design: .default))
                    .foregroundColor(.white)
                    .opacity(fade ? 0 : 1)
                    .animation(fade ? .easeIn(duration: 0.2) : .none, value: fade)
                    .scaleEffect(size)
                    
                
                Spacer()
                
                Button(action: {
                    animateText()
                }, label: {
                    Text("Start Game")
                })
            }
        }
    }
}


#Preview {
    ContentView()
}
