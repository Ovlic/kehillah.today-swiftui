//
//  PreLaunch.swift
//  kehillah.today-ios-watchos Watch App
//
//  Created by Ovlic B on 12/15/22.
//

import SwiftUI

struct PreLaunch: View {
    
    @State var showMainView: Bool = false
    @State private var hasTimeElapsed = false
    
    var body: some View {
        Group{
            if showMainView {
                ContentView()
            }
            else {
                ZStack {
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
                    Image("kt-logo")
                        .border(Color("Background"), width: 11)
                }
            
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.25).delay(0.75)) {
                showMainView = true
            }
        }
    }
}

struct PreLaunch_Previews: PreviewProvider {
    static var previews: some View {
        PreLaunch()
    }
}
