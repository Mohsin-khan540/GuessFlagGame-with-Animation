//
//  ContentView.swift
//  guassFlageName(Animation)
//
//  Created by Mohsin khan on 09/08/2025.
//

import SwiftUI


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var CorrectAnswer = Int.random(in: 0..<2)
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var score = 0
    @State private var isGameOver = false
    
    @State private var rotationAmounts = [0.0, 0.0]
    @State private var selectedFlage : Int? = nil
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.yellow , .red], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                if !isGameOver{
                    Text("Guass Flage Name")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }else if alertTitle == "You Win"{
                    Text("Game over You Win  🏆")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }else{
                    Text("Game over You Lose  😔")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                VStack(spacing : 30){
                    VStack{
                        Text("Tap The Flage Of")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(countries[CorrectAnswer])
                            .font(.largeTitle.bold())
                            .foregroundStyle(.primary)
                    }
                    ForEach(0..<2){ number in
                        Button{
                            selectedFlage = number
                            withAnimation(.easeInOut(duration: 0.7)){
                               rotationAmounts[number] += 720
                            }
                            flageTapped(number)
                            
                        }label:  {
                            Image(countries[number])
                                .rotation3DEffect(.degrees(rotationAmounts[number]), axis: (x:0, y:1, z:0))
                                .opacity(selectedFlage == nil || selectedFlage == number ? 1 : 0.25)
                        }
                        .clipShape(Capsule())
                    }
                }
                .frame(maxWidth : .infinity)
                .padding(.vertical , 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius:20))
                .padding()
                
                Text("Score : \(score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Button("Reset"){
                    ResetGame()
                }
                .buttonStyle(.borderedProminent)
                
                .alert(alertTitle , isPresented: $isShowingAlert){
                    if isGameOver{
                        Button("Reset" , action : ResetGame)
                    }else{
                        Button("Continue" , action: AskNewQuestion)
                    }
                }
            }
        }
    }
    func flageTapped(_ number : Int){
        if number == CorrectAnswer{
            alertTitle = "Correct! you are Genius"
            score += 5
        }else{
            alertTitle = "Wrong! thats a flage of \(countries[number])"
            score -= 5
        }
        if score > 25{
            alertTitle = "You Win"
            isGameOver = true
        }else if score < -25{
            alertTitle = "You Lose"
            isGameOver = true
        }
        isShowingAlert = true
    }
    
    func AskNewQuestion(){
        countries.shuffle()
        CorrectAnswer = Int.random(in: 0..<2)
        selectedFlage = nil
    }
    func ResetGame(){
        score = 0
        rotationAmounts = [0.0, 0.0]
        AskNewQuestion()
        isGameOver = false
    }
}
#Preview {
    ContentView()
}

