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
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3 ) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
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
        if (number == correctAnswer) {
            scoreTitle = "Correct"
            userScore += 1
            message = "Your score is \(userScore)"
        } else {
            scoreTitle = "Wrong"
            message = "Wrong! That’s the flag of \(countries[correctAnswer])"

        }
        
        showingScore = true
    }
       
    func askQuestion() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
