//
//  TestView.swift
//  LearningApp
//
//  Created by Pavel Bohomolnyi on 08/09/2022.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex: Int?
    @State var submited = false
    
    @State var numCorrect = 0
    @State var showResults = false
    
    var body: some View {
        
        if model.currentQuestion != nil && showResults == false {
            
            VStack(alignment: .leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // Answers
                ScrollView {
                    VStack {
                        
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            Button {
                                selectedAnswerIndex = index
                                
                            } label: {
                                
                                ZStack {
                                    
                                    if submited == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    }
                                    else {
                                        // Answer has been submitted
                                        if index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex {
                                            
                                            // Show a green background
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else if index == selectedAnswerIndex &&
                                                    index != model.currentQuestion!.correctIndex {
                                            
                                            // Show a red background
                                            RectangleCard(color: Color.red)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else {
                                            RectangleCard(color: Color.white)
                                                .frame(height: 48)
                                        }
                                    }
                                    
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submited)
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                // Submit Button
                Button {
                    
                    // Check if answer has been submited
                    if submited == true {
                        if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                            showResults = true
                        }
                        else {
                            
                            model.nextQuestion()
                            
                            submited = false
                            selectedAnswerIndex = nil
                        }
                    }
                    else {
                        
                        // Change submitted state to true
                        submited = true
                        
                        // Check the answer
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }
                    
                } label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            
        }
        else if showResults == true {
            // If current question is nil, we show result view
            TestResultView(numCorrect: numCorrect)
        }
        else {
            ProgressView()
        }
    }
    
    var buttonText: String {
        if submited == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                return "Finish"
            }
            else {
                return "Next"
            }
        }
        else {
            return "Submit"
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
