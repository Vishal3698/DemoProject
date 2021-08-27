//
//  Home.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-17.
//

import SwiftUI

struct UserHome: View {
    @State var launchTest = false
    @State var showInspectionScreen = false
    @State var showRoadTestScreen = false
    @State var showMedicalScrren = false
    @State var set: String
    @State var selClass: Int
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
    
    
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0
    @State var submitted = false
    @State var started = false

    var LicDesc: String{
        if selClass == 4{
            return "Licence for Ambulance, Bus, and Rideshare Vehicles"
        }else if selClass == 5{
            return "Licence for Passenger Cars"
        }else{
            return "Licence for motorcycle"
        }
    }
    

    var body: some View {
        
        VStack{
           Spacer()
            Text("Class \(selClass)")
                .fontWeight(.heavy)
                .font(.system(size: 39))
                .foregroundColor(Color(hex: darkestColor))
            Text(LicDesc)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.all, 8)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(hex: darkestColor))
            
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: set == "Class4" ? 2 : 1),spacing:15, content: {
                
                if set == "Class4" {
                    CardView(set: set, imageName: "lv1", tileTitle: "Knowledge Test", tileDesc: "Learner's Licence")
                        .onTapGesture(perform: {
                                launchTest.toggle()
                        })
                    CardView(set: set, imageName: "lv2", tileTitle: "Pre-trip Road Inspection", tileDesc: "Part of the road test")
                        .onTapGesture(perform: {
                            showInspectionScreen.toggle()
                        })
                    CardView(set: set, imageName: "lv3", tileTitle: "Road Test", tileDesc: "Interim Licence")
                        .onTapGesture(perform: {
                                showRoadTestScreen.toggle()
                        })
                    
                    CardView(set: set, imageName: "lv4", tileTitle: "Medical Test", tileDesc: "Final Step")
                        .onTapGesture(perform: {
                                showMedicalScrren.toggle()
                        })
                    
                }else{
                    CardView(set: set, imageName: "lv1", tileTitle: "Knowledge Test", tileDesc: "Learner's Licence")
                        .onTapGesture(perform: {
                                launchTest.toggle()
                        })
                    CardView(set: set, imageName: "lv3", tileTitle: "Road Test", tileDesc: "Final Step")
                        .onTapGesture(perform: {
                                showRoadTestScreen.toggle()
                        })
                }
            })
            .padding(.horizontal, 21)
            
            Spacer(minLength: UIScreen.main.bounds.height * 0.09)
            
        }
        .background(Color(hex: lightestColor)).ignoresSafeArea()
        
        .fullScreenCover(isPresented: $launchTest, content: {
            TestScreen(correct: $correct, wrong: $wrong, answered: $answered, submitted: $submitted, started: $started, set: set)
        })
        
        .sheet(isPresented: $showInspectionScreen, content: {
            TripInspectionScreen()
        })
        
        .sheet(isPresented: $showRoadTestScreen, content: {
            RoadTestScreen(setClass: selClass)
        })
        
        .sheet(isPresented: $showMedicalScrren, content: {
            MedicalTestScreen(set: set)
        })

        
    }
}


struct CardView: View{
    @Environment(\.colorScheme) var colorScheme
    var set: String
    var imageName: String
    var tileTitle, tileDesc: String
    let theme = UITheme()
    
    var body: some View{
        VStack(alignment: .center){
            if tileTitle == "Road Test" || tileTitle == "Medical Test"{
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .shadow(radius: 1)
                    .cornerRadius(2.0)
                    .clipShape(Circle())
            }else{
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .shadow(radius: 1)
                    .cornerRadius(5.5)
                
            }
            Text(tileTitle)
                .fontWeight(.heavy)
                .foregroundColor(colorScheme == .light ? Color(hex: theme.darkestColor) : Color(hex: theme.lightestColor))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            Text(tileDesc)
                .foregroundColor(colorScheme == .light ? Color(hex: theme.darkestColor) : Color(hex: theme.lightestColor))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.75,
               idealHeight: UIScreen.main.bounds.width * 0.48,
               maxHeight: UIScreen.main.bounds.width * 0.48)
        .padding()
        .background(colorScheme == .light ? Color(hex: theme.lightColor).opacity(0.30) : Color(hex: theme.darkColor))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex: theme.darkColor), lineWidth: 2)
        )
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserHome(set: "Class4", selClass: 4)
                .previewDevice("iPhone X")
                .preferredColorScheme(.light)
            UserHome(set: "Class4", selClass: 4)
                .previewDevice("iPhone X")
                .preferredColorScheme(.dark)

        }
    }
}
