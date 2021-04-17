//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by sanmi_personal on 03/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var message = ""
    @State private var selectedNumber = 0
    @State private var correctFlag = false
    @State private var wrongFlag = false
    @State private var makeFlagOpaque = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .modifier(LargwWhiteText())
                    
                    
                }
                
                ForEach(0..<3 ) { number in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }.rotation3DEffect(.degrees(self.correctFlag && self.selectedNumber == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.makeFlagOpaque && !(self.selectedNumber == number) ? 0.25 : 1)
                }
                Text("User score: \(userScore)").foregroundColor(.white)
                Spacer()
                
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message:  Text(message), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        selectedNumber = number
        if (number == correctAnswer) {
            scoreTitle = "Correct"
            userScore += 1
            message = "Your score is \(userScore)"
            correctFlag = true
        } else {
            scoreTitle = "Wrong"
            message = "Wrong! That’s not the flag of \(countries[correctAnswer])"
            userScore -= 1
            wrongFlag = true
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        wrongFlag = false
        correctFlag = false
    }
}

struct LargwWhiteText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
