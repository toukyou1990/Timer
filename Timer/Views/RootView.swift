//
//  RootView.swift
//  Timer
//
//  Created by Notty on 2020/11/23.
//

import SwiftUI

struct RootView: View {
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    var body: some View {
        ContentView()
            .sheet(isPresented: $isFirstLaunch) {
                WorkThroughView()
            }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
