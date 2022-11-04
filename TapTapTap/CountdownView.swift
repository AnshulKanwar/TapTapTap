//
//  Countdown.swift
//  TapTapTap
//
//  Created by Anshul Kanwar on 04/11/22.
//

import SwiftUI

struct CountdownView: View {
    @Binding var countdown: Int
    @Binding var isStart: Bool
    @State var isRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.regularMaterial)
                .ignoresSafeArea()
            
            VStack {
                Text("\(countdown)")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .onReceive(timer) { _ in
                        if isRunning {
                            countdown -= 1
                        }
                        
                        if countdown == 0 {
                            isStart = true
                        }
                    }
                
                if !isRunning {
                    Button("Start") {
                        isRunning = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack {
                Rectangle()
                    .fill(.red)
                    .ignoresSafeArea()
                Rectangle()
                    .fill(.blue)
                    .ignoresSafeArea()
            }
            
            CountdownView(countdown: .constant(3), isStart: .constant(false))
        }
    }
}
