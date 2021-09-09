//
//  TestScreen.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-18.
//


import SwiftUI

// question Answser View...
struct TestScreen: View {
    @Binding var correct : Int
    @Binding var wrong: Int
    @Binding var answered: Int
    @Binding var submitted: Bool
    @Binding var started: Bool
    @State var noOfQuestionsToShow: Int = 5
    @State var queIndex = 0
    var nextButtonStatus: Bool{
        return ((correct == 0 && wrong == 0) || (data.questions[queIndex].isSubmitted == false)) ? true : false
    }
    var buttonColor: Color {
        return nextButtonStatus ? Color(hex: lightColor) : Color(hex: darkestColor)
    }
 
    var set: String
    @StateObject var data = QuestionViewModel()
    
    @Environment(\.presentationMode) var present
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
            if data.questions.isEmpty{
                ProgressView()
            }
            else{
                //If data is found
                
                
                if answered == noOfQuestionsToShow || submitted == true{
                    VStack(alignment: .center){
                        let result = (CGFloat(correct)/(CGFloat(correct) + CGFloat(wrong)))*100
                        Spacer()
                        if result >= 80{
                        Image("trophy")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 210, height: 210)
                            .padding()
                            .shadow(radius: 3)
                            Spacer()
                            Text("Result: \(String(format: "%.0f", result))%")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .padding(.all, 15)
                            .foregroundColor(resultColor())
                        Text("Well Done!")
                            .font(.title)
                            .foregroundColor(.green)
                        }else if CGFloat(correct) >= (CGFloat(answered)*0.6) && CGFloat(correct) < (CGFloat(answered)*0.8){
                            Image("tried")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 210, height: 210)
                                .shadow(radius: 3)
                            Spacer()
                            Text("Result: \(String(format: "%.0f", result))%")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .padding(.all, 15)
                                .foregroundColor(resultColor())
                            Text("Almost There!")
                                .font(.title)
                                .foregroundColor(.yellow)
                        }else{
                            Image("fail")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 210, height: 210)
                                .padding(.leading)
                                .shadow(radius: 4)
                            Spacer()
                            Text("Result: \(String(format: "%.0f", result))%")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .padding(.all, 15)
                                .foregroundColor(resultColor())
                            Text("Keep Practising!")
                                .font(.title)
                                .foregroundColor(.red)
                                
                        }
                        
                        
                        // Score And Back To Home Button...
                        
                        HStack(spacing: 12){
                            Image(systemName: "checkmark")
                                .font(.title)
                                .foregroundColor(.green)
                            Text("\(correct)")
                                .font(.title)
                                .foregroundColor(Color(hex: darkestColor))
                            
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(.red)
                                .padding(.leading)
                            Text("\(wrong)")
                                .font(.title)
                                .foregroundColor(Color(hex: darkestColor))
                        }
                        
                        Spacer()
                        Button(action: {
                            // closing sheet....
                            present.wrappedValue.dismiss()
                            answered = 0
                            correct = 0
                            wrong = 0
                            submitted = false
                            started = false
                            queIndex = 0
                        }, label: {
                            Text("Go to Home")
                                .fontWeight(.heavy)
                                .foregroundColor(Color(hex: lightestColor))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color(hex: darkColor))
                                .cornerRadius(15)
                        })
                        Button(action: {
                            answered = 0
                            correct = 0
                            wrong = 0
                            data.getQuestions(set: set)
                            submitted = false
                            started = false
                            queIndex = 0
                        }, label: {
                            Text("Try Again")
                                .fontWeight(.heavy)
                                .foregroundColor(Color(hex: lightestColor))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color(hex: darkColor))
                                .cornerRadius(15)
                        })
                        Spacer()
                    }
                    
                }else if answered == 0 && started == false{
                    
                    VStack{
                        HStack{
                            Button(action: {
                                present.wrappedValue.dismiss()
                                answered = 0
                                correct = 0
                                wrong = 0
                            }, label: {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 27, height: 27)
                                    .foregroundColor(Color(hex: darkColor)).opacity(0.87)
                                    .padding()
                            })
                            Spacer()
                        }

                        Spacer()
                        Text("Number of Questions:")
                            .font(.title)
                            .foregroundColor(Color(hex: darkestColor))
                        
                        Picker("Questions:", selection: $noOfQuestionsToShow, content: {
                            Group{
                                Text("5").tag(5)
                                Text("10").tag(10)
                                Text("20").tag(20)
                                Text("35").tag(35)
                                Text("80").tag(80)
                                Text("all").tag(data.questions.count)
                            }
                            .foregroundColor(Color(hex: darkestColor))
                        })
                        .padding(.horizontal, 30)
                        
                        Spacer()
                        Button(action: {
                            started = true
                                if noOfQuestionsToShow>data.questions.count{
                                    noOfQuestionsToShow = data.questions.count
                                }
                        }, label: {
                            Text("Start")
                                .fontWeight(.heavy)
                                .foregroundColor(Color(hex: lightestColor))
                                .padding(.vertical)
                                .frame(maxWidth: 111, maxHeight: 45)
                                .background(Color(hex: darkestColor))
                                .cornerRadius(9)
                        })
                        Spacer()
                    }
                }else{
                    VStack{
                        // Top Progress View...
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                            
                            Capsule()
                                .fill(Color.gray.opacity(0.45))
                                .frame(height: 9)
                            
                            Capsule()
                                .fill(Color.green)
                                .frame(width: progress(), height: 9)

                        })
                        .padding(.all, 12)
                        
                        // Correct And Wrong Count...
                        Spacer()
                        HStack{
                            Button(action: {
                                present.wrappedValue.dismiss()
                                answered = 0
                                correct = 0
                                wrong = 0
                                started = false
                            
                            }, label: {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .frame(width: 27, height: 27, alignment: .leading)
                            })
                            .foregroundColor(Color(hex: darkColor)).opacity(0.9)
                            Spacer()
                            Label(
                                title: { Text(correct == 0 ? "0" : "\(correct)")
                                    .font(.title2)
                                    .foregroundColor(Color(hex: darkestColor))
                                },
                                icon: { Image(systemName: "checkmark")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                })
                            
                            Label(
                                title: { Text(wrong == 0 ? "0" : "\(wrong)")
                                    .font(.title2)
                                    .foregroundColor(Color(hex: darkestColor))
                                },
                                icon: { Image(systemName: "xmark")
                                    .font(.title2)
                                    .foregroundColor(.red)
                                })
                        }
                        .padding()
                        .frame(height: 30)
                        
                        Spacer()
                        QuestionView(question: $data.questions[queIndex], correct: $correct, wrong: $wrong, answered: $answered, submitted: $submitted)
//                      .offset(x: data.questions[queIndex].completed ? 300 : 0)
                        
                        Spacer()
                        HStack{
                            Button(action: submittedQuiz, label: {
                                    Text("Submit")
                                        .fontWeight(.heavy)
                                        .foregroundColor(((wrong == 0) && (correct == 0)) ? Color.black : Color(hex: lightestColor))
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(((wrong == 0) && (correct == 0)) ? Color(hex: lightColor) : Color(hex: darkestColor))
                                        .cornerRadius(9)
                            })
                            .disabled(((wrong == 0) && (correct == 0)) ? true : false)
                            Button(action: nextQues, label: {
                                    Text("Next")
                                        .fontWeight(.heavy)
                                        .foregroundColor(nextButtonStatus ? Color.black : Color(hex: lightestColor))
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(buttonColor)
                                        .cornerRadius(9)
                            })
                            .disabled(nextButtonStatus)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .padding(.vertical, 21)
                }
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        // fetching...
        .onAppear(perform: {
            data.getQuestions(set: set)
        })
            
    }
    
    // progres...
    
    func progress()->CGFloat{
        
        let fraction = CGFloat(answered) / CGFloat(noOfQuestionsToShow)
        
        let width = UIScreen.main.bounds.width - 30
        
        return fraction * width
    }

    func resultColor() -> Color{
        let result = (Double(correct)/Double(answered))*100
        if result>=80{
            return Color.green
        }else if result>=60 && result<80{
            return Color.yellow
        }else{
            return Color.red
        }
    }
    
    func nextQues(){
        withAnimation{
            data.questions[queIndex].completed.toggle()
        }
        answered += 1
        queIndex += 1
    }

    func submittedQuiz(){
            submitted = true
        queIndex = 0
    }
}



struct TestScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            TestScreen(correct: .constant(1), wrong: .constant(4), answered: .constant(1), submitted: .constant(false), started: .constant(true), set: "Class4")
                .previewDevice("iPhone X")
            TestScreen(correct: .constant(4), wrong: .constant(1), answered: .constant(3), submitted: .constant(false), started: .constant(true), set: "Class4")
                .previewDevice("iPhone X")
                .preferredColorScheme(.dark)
        }
    }
}


