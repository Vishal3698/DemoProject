//
//  MedicalTestScreen.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-23.
//

import SwiftUI

struct MedicalTestScreen: View {
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
    
    var set: String
    var body: some View {
        VStack(alignment: .leading){
            Text("Medical Test")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: darkestColor))
                .padding(.horizontal)
                .padding(.vertical, 24)
            
            Image("medical")
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .center)
                .clipShape(Circle())
            
            TextDesc(text: "As a commercial driver, you'll take a medical exam when applying for your licence, also on a regular basis after that. \n\nA doctor usually charges you a fee for these exams.", darkestColor: darkestColor).padding(.top, 30)
        
            Spacer()
            TextDesc(text: "Find more information on below link: ", darkestColor: darkestColor)
            
            Button(action: {
                openURL(URL(string: "http://www.icbc.com/driver-licensing/re-exam/Pages/Drivers-medical-exam.aspx")!)
            }, label: {
                Text("Driver's medical exams")
                    .fontWeight(.bold)
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: lightestColor))
                    .frame(maxWidth: .infinity, maxHeight: 39,alignment: .center)
                    .background(Color(hex: darkestColor))
                    .cornerRadius(9)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
            })
        }
        .background(Color(hex: lightestColor).ignoresSafeArea())
    }
}


struct MedicalTestScreen_Previews: PreviewProvider {
    static var previews: some View {
        MedicalTestScreen(set: "Class4")
            .previewDevice("iPhone X")
    }
}
