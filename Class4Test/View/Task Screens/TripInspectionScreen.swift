//
//  TripInspectionScreen.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-23.
//

import SwiftUI
import AVKit
import AVFoundation


struct TripInspectionScreen: View {
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    var darkColor: String{
        colorScheme == .light ? "393E46" : "93B5C6"
        
    }
    var lightColor: String{
        colorScheme == .light ? "93B5C6" : "393E46"
        
    }
    var darkestColor: String{
        colorScheme == .light ? "222831" : "EEEEEE"
        
    }
    var lightestColor: String{
        colorScheme == .light ? "EEEEEE" : "222831"
        
    }

    
    var body: some View {
        VStack(alignment: .leading){

            Text("Pre-Trip Inspection Test")
                .font(.system(size: 27))
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: darkestColor))
                .padding(.horizontal)
                .padding(.vertical, 24)
            
            TextDesc(text: "An overview of an actual full length class 4 pre-trip inspection.", darkestColor: darkestColor)
            
            WebView(url: "http://www.youtube.com/embed/IVPtp9wZ0sM")
                .frame(height: 198, alignment: .center)
                .padding(.all)

            TextDesc(text: "Below is a useful resources from ICBC to help you preapre:", darkestColor: darkestColor)
            Spacer()
            Button(action: {
                openURL(URL(string: "http://www.icbc.com/insurance/commercial/Documents/class4-pre-trip-inspection.pdf")!)
            }, label: {
                Text("Official Preparation Guide from ICBC")
                    .fontWeight(.bold)
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: lightestColor))
                    .frame(maxWidth: .infinity, maxHeight: 39,alignment: .center)
                    .background(Color(hex: darkestColor))
                    .cornerRadius(9)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
            })
            
            Button(action: {
                openURL(URL(string: "http://www.icbc.com/insurance/commercial/Documents/class4-pre-trip-inspection.pdf")!)
            }, label: {
                Text("Examination Pre-Trip Inspection Form")
                    .fontWeight(.bold)
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: lightestColor))
                    .frame(maxWidth: .infinity, maxHeight: 39,alignment: .center)
                    .background(Color(hex: darkestColor))
                    .cornerRadius(9)
                    .padding(.horizontal)
                    .padding(.bottom, 12)
            })
            

        }
        .background(Color(hex: lightestColor).ignoresSafeArea())
    }
}

struct TripInspectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        TripInspectionScreen()
            .previewDevice("iPhone X")
    }
}


