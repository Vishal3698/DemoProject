//
//  AppHome.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-19.
//

import SwiftUI

struct AppHome: View {
    @State var show = false
    @State var selected = 0
    @State var selClass = ""
    @Environment(\.colorScheme) var colorScheme
    @State var attempts: Int = 0
    
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
        NavigationView{
        ZStack{
        
            VStack(alignment: .leading){
            Text("Welcome to")
                .foregroundColor(Color(hex: darkestColor))
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .padding(.top, UIScreen.main.bounds.height*0.09)

            Text("Driver's Licence Guide")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: darkColor).opacity(0.81))
            
            Spacer()
                
                Button(action: {
                    let generator = UINotificationFeedbackGenerator()
                    if selected == 0{
                        generator.notificationOccurred(.error)
                        withAnimation(.default) {
                        attempts += 1
                        }
                    }else{
                        generator.notificationOccurred(.success)
                        show.toggle()
                    }
                }, label: {
                    Text("Continue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(selected == 0 ? Color(hex: darkColor).opacity(0.87) : Color(hex: darkColor))
                        .cornerRadius(12)
                        
                })
            }
            .padding(.horizontal)
           
            
            VStack(alignment: .leading){
            Spacer(minLength: UIScreen.main.bounds.height*0.27)
            Text("Select your Class to start:")
                .font(.system(size: 18))
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: darkestColor))
                .modifier(Shake(animatableData: CGFloat(attempts)))
                .padding(.bottom, 15)
            
                classView(classType: "Class 4", classImage: "taxi", imageClr: darkColor, setClass: 4, attempts: attempts)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(selected == 4 ? Color(hex: darkColor) : Color.clear, lineWidth: 2)
                )
                .onTapGesture {
                    selected = 4
                    selClass = "Class\(selected)"
                }
            
            
                classView(classType: "Class 5", classImage: "car", imageClr: darkColor, setClass: 5, attempts: attempts)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(selected == 5 ? Color(hex: darkColor) : Color.clear, lineWidth: 2)
        
                            
                )
                .onTapGesture {
                    selected = 5
                    selClass = "Class\(selected)"
                }
            
            
                classView(classType: "Class 8", classImage: "motorcycle", imageClr: darkColor, setClass: 8, attempts: attempts)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(selected == 8 ? Color(hex: darkColor) : Color.clear, lineWidth: 2)
                )
                .onTapGesture {
                    selected = 8
                    selClass = "Class\(selected)"
                }
            Spacer()
            }
          
        NavigationLink(destination: UserHome(set: selClass, selClass: selected), isActive: $show) {EmptyView()}
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .onAppear(perform: {selected = 0})

        }
    }
    
}



//MARK: - View Snippets

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct classView: View{
    let classType: String
    let classImage: String
    let imageClr: String
    let setClass: Int
    var attempts: Int
    
    var LicDesc: String{
        if setClass == 4{
            return "Licence for Ambulance, Bus, and Rideshare Vehicles"
        }else if setClass == 5{
            return "Licence for Passenger Cars"
        }else{
            return "Licence for motorcycle"
        }
    }
    
    var body: some View{
        HStack(alignment: .center) {
                    Image(classImage)
                        .resizable()
                        .font(.largeTitle)
                        .foregroundColor(Color(hex: imageClr))
                        .frame(maxWidth: 39, maxHeight: 39)
                        .padding()
                        .padding(.horizontal, 6)
                        .shadow(color:Color(hex: imageClr), radius: 1.5)
                        .accessibility(hidden: true)

                    VStack(alignment: .leading) {
                        Text(classType)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .accessibility(addTraits: .isHeader)
                        

                        Text(LicDesc)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.all, 9)
                }
//        .modifier(Shake(animatableData: CGFloat(attempts)))
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: 90, alignment: .leading)
        

    }
}



//MARK: - Extensions



extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}

extension Color {
    static var mainColor = Color(UIColor.systemIndigo)
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct AppHome_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            AppHome()
                .previewDevice("iPhone X")
            AppHome()
                .previewDevice("iPhone X")
                .preferredColorScheme(.dark)
        }
       
    }
}
