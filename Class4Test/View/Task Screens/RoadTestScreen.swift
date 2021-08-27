//
//  RoadTestScreen.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-23.
//

import SwiftUI

struct RoadTestScreen: View {
    @Environment(\.openURL) var openURL
    var setClass: Int
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
        ZStack{
            Color(hex: lightestColor).ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Road Test for Class \(setClass)")
                    .font(.system(size: 27))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(hex: darkestColor))
                    .padding(.horizontal)
                    .padding(.vertical, 24)
                
                
                Text("Tips for booking a road test:")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(hex: darkestColor))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 21)
                
                TextDesc(text: "- Always book a road test at a location which is not busy, like: Richmond, Port Coquitlam, Chilliwack", darkestColor: darkestColor).padding(.leading, 6)
                TextDesc(text: "- Book when traffic will be less", darkestColor: darkestColor).padding(.leading, 6)
                TextDesc(text: "- Practise on the road where test will be taken (your driving instructor will know)", darkestColor: darkestColor).padding(.leading, 6)
                
                
                if setClass == 4{
                    Text("Remember")
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color(hex: darkestColor))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 30)
                    TextDesc(text: "To book a road test for Class 4, you have to call the ICBC office to book a road test as it can not be booked via website.", darkestColor: darkestColor).padding(.leading, 6)
                    Spacer()
                    Button(action: {
                        guard let url = URL(string: "tel://1-800-950-1498") else { return }
                            UIApplication.shared.open(url)
                    }, label: {
                        Text("Call to book a Road Test")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: lightestColor))
                            .frame(maxWidth: .infinity, maxHeight: 39,alignment: .center)
                            .background(Color(hex: darkestColor))
                            .cornerRadius(9)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                    })
                }else{
                    Text("Remember")
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color(hex: darkestColor))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 30)
                    TextDesc(text: "- If you are not able to find your desired test locarion, book your road test at any loction first and then check the website daily for earlier dates.", darkestColor: darkestColor).padding(.leading, 6)
                    Spacer()
                    Button(action: {
                        openURL(URL(string: "http://onlinebusiness.icbc.com/webdeas-ui/home")!)
                    }, label: {
                        Text("Book a Road Test")
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: lightestColor))
                            .frame(maxWidth: .infinity, maxHeight: 39,alignment: .center)
                            .background(Color(hex: darkestColor))
                            .cornerRadius(9)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                    })
                }
                    
                
            }
        }
        
    }
}


struct TextDesc: View{
    var text: String
    var darkestColor: String
    var body: some View{
        Text(text)
            .font(.system(size: 18))
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(Color(hex: darkestColor))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 3)
    }
}
struct RoadTestScreen_Previews: PreviewProvider {
    static var previews: some View {
        RoadTestScreen(setClass: 4)
            .previewDevice("iPhone X")
    }
}
