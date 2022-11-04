//
//  ContentView.swift
//  TapTapTap
//
//  Created by Anshul Kanwar on 02/11/22.
//

import SwiftUI

struct MainView: View {
    @State var viewHeight = 0.0
    @State var fraction = 0.5
    @State var isOver = false
    @State var winner = ""
    
    @State var isStart = false
    @State var countdown = 3
    
    var redHeight: Double {
        fraction * viewHeight
    }
    
    var blueHeight: Double {
        (1 - fraction) * viewHeight
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Rectangle()
                        .fill(.red)
                        .frame(height: redHeight)
                        .onTapGesture {
                            fraction += 0.01
                            if fraction >= 0.95 {
                                isOver = true
                                winner = "Red"
                            }
                        }
                    Rectangle()
                        .fill(.blue)
                        .frame(height: blueHeight)
                        .onTapGesture {
                            fraction -= 0.01
                            if fraction <= 0.05 {
                                isOver = true
                                winner = "Blue"
                            }
                        }
                }
                .onAppear {
                    viewHeight = geo.size.height
                }
                
                if !isStart {
                    CountdownView(countdown: $countdown, isStart: $isStart)
                }
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $isOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("\(winner) won"),
                dismissButton: .default(Text("Play Again"), action: {
                    isOver = false
                    fraction = 0.5
                    winner = ""
                    isStart = false
                    countdown = 3
                })
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
