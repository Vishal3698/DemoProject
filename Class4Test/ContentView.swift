//
//  ContentView.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-17.
//

import SwiftUI

struct ContentView: View {
    @State var showSplash = true
    
    var body: some View {
        ZStack{
            AppHome()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().preferredColorScheme(.light)
        ContentView()
    }
}
