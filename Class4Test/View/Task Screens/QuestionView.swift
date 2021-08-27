//
//  QuestionView.swift
//  Class4Test
//
//  Created by Vishal Patel on 2021-08-18.
//

//
//  QuestionView.swift
//  Quiz
//
//  Created by Balaji on 28/11/20.
//

import SwiftUI
import UIKit

struct QuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    @Binding var submitted: Bool
    
    @State var selected = ""
    @State private var disabled = false
    @State var nextButtonStatus: Bool = true
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
    
    var buttonColor: Color {
        return nextButtonStatus ? Color(hex: lightColor) : Color(hex: darkestColor)
        }
    var body: some View {
        VStack{
            let lengthOfWord = question.question?.utf16.count
                if let myURL = URL(string: question.qImage!){
                    if ((lengthOfWord ?? 0)<=60){
                        HStack{
                            Text(question.question!)
                                .fontWeight(.heavy)
                                .font(.title2)
                                .foregroundColor(Color(hex: darkestColor))
                                .fixedSize(horizontal: false, vertical: true)
                            ImageView(url: myURL, placeholder: { Text("") }, image: { Image(uiImage: $0).resizable() })
                                .frame(maxWidth: UIScreen.main.bounds.height*0.15, maxHeight: UIScreen.main.bounds.height*0.15, alignment: .center)
                                .padding(.all, 3)
                        }
                    }else{
                        Text(question.question!)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(hex: darkestColor))
                            .fixedSize(horizontal: false, vertical: true)
                        ImageView(url: myURL, placeholder: { Text("") }, image: { Image(uiImage: $0).resizable() })
                            .frame(maxWidth: UIScreen.main.bounds.height*0.15, maxHeight: UIScreen.main.bounds.height*0.15, alignment: .center)
                            .padding(.all, 3)
                    }
                    
                }else{
                    Text(question.question!)
                        .font(.system(size: 24))
                        .fontWeight(.heavy)
                        .lineLimit(4)
                        .foregroundColor(Color(hex: darkestColor))
                }
            Spacer(minLength: 30)
            // Options...
            Group{
            Button(action: {
                selected = question.optionA!
                
                if !question.isSubmitted{
                checkAns()
                }
            }, label: {
                Text(question.optionA!)
                    .foregroundColor(Color(hex: darkestColor))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 9)
                    .frame(maxWidth: .infinity, minHeight: 51, idealHeight: 60)
                    .lineLimit(4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color(option: question.optionA!).opacity(0.3),lineWidth: 3)
                            .background(color(option: question.optionA!)).cornerRadius(12)
                    )
            })
            .disabled(disabled)
            
            Button(action: {
                selected = question.optionB!
                
                if !question.isSubmitted{
                checkAns()
                }
            }, label: {
                Text(question.optionB!)
                    .foregroundColor(Color(hex: darkestColor))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 9)
                    .frame(maxWidth: .infinity, minHeight: 51, idealHeight: 60)
                    .lineLimit(4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color(option: question.optionB!).opacity(0.3),lineWidth: 3)
                            .background(color(option: question.optionB!)).cornerRadius(12)
                    )
            })
            .disabled(disabled)
            
            Button(action: {
                selected = question.optionC!
                
                if !question.isSubmitted{
                checkAns()
                }
            }, label: {
                Text(question.optionC!)
                    .foregroundColor(Color(hex: darkestColor))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 9)
                    .frame(maxWidth: .infinity, minHeight: 51, idealHeight: 60)
                    .lineLimit(4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color(option: question.optionC!),lineWidth: 3)
                            .background(color(option: question.optionC!)).cornerRadius(12)
                    )
            })
            .disabled(disabled)
            
            Button(action: {
                selected = question.optionD!
                if !question.isSubmitted{
                checkAns()
                }
            }, label: {
                Text(question.optionD!)
                    .foregroundColor(Color(hex: darkestColor))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 9)
                    .frame(maxWidth: .infinity, minHeight: 51, idealHeight: 60)
                    .lineLimit(4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(color(option: question.optionD!).opacity(0.3),lineWidth: 3)
                            .background(color(option: question.optionD!)).cornerRadius(12)
                    )
            })
            .disabled(disabled)
            }
            
            Spacer(minLength: 9)
            HStack{
                Button(action:  submittedQuiz, label: {
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
        }
        .padding()
        .background(Color(hex: lightestColor).ignoresSafeArea())
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        .frame(minWidth: UIScreen.main.bounds.width * 0.9, idealWidth: UIScreen.main.bounds.width * 0.9, maxWidth: UIScreen.main.bounds.width*0.9, minHeight: UIScreen.main.bounds.height*0.81, idealHeight: UIScreen.main.bounds.height*0.81, maxHeight: UIScreen.main.bounds.height*0.81, alignment: .center)
    }
    

    // highlighting answer...
    func color(option: String)->Color{

        if option == selected{
            // displaying if correct means green else red...
            if question.isSubmitted{
                
                if selected == question.answer!{
                    return Color.green.opacity(0.45)
                }
                else{
                    return Color.red.opacity(0.3)
                }
            }
            else{
                return Color(hex: lightColor).opacity(0.45)
            }
        }
        else{
            // displaying right if wrong selected....
            if question.isSubmitted && option != selected{
                
                if question.answer! == option{
                    return Color.green.opacity(0.45)
                }
            }
            return Color(hex: lightColor).opacity(0.45)
        }
        
    }

    
    func checkAns(){
        let generator = UINotificationFeedbackGenerator()
            if selected == question.answer!{
                correct += 1
            }
            else{
                wrong += 1
                generator.notificationOccurred(.error)
            }
        nextButtonStatus.toggle()
        question.isSubmitted.toggle()
        disabled = true
    }
    
    func nextQues(){
        withAnimation{
                question.completed.toggle()
        }
        answered += 1
    }
    
    func submittedQuiz(){
            submitted = true         
    }
}



struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let question = Question(id: "hihih", question: "You are operating a vehicle whose peak engine torque is at 1,500 r.p.m.",
                                optionA: "Dhat will you do when you have to ride a steep hil Dhat will you do when you have to ride a steep hdsdsdsdfgdfddfdf",
                                optionB: "Dhat will you do when you have to ride a steep hil Dhat will you do when you have to ride a steep hdsdsdsdfgdfddfdf",
                                optionC: "Chat will you do when you have to ride a steep hil ",
                                optionD: "Dhat will you do when you have to ride a steep hil Dhat will you do when you have to ride a steep hdsdsdsdfgdfddfdf", answer: "B",
                                qImage: "", isSubmitted: false, completed: false)
        Group {
            QuestionView(question: .constant(question), correct: .constant(0), wrong: .constant(0), answered: .constant(5), submitted: .constant(false))
                .previewDevice("iPhone X")
                .preferredColorScheme(.light)
            QuestionView(question: .constant(question), correct: .constant(0), wrong: .constant(0), answered: .constant(5), submitted: .constant(false))
                .previewDevice("iPhone X")
                .preferredColorScheme(.dark)
        }
    }
}

//"http://www.yourlibrary.ca/wp-content/uploads/driving/scenario5.gif"
//and whose peak horsepower is at 2,000 r.p.m. When employing the standard r.p.m. split to shift gears, you should:
