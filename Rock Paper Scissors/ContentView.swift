//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Alex Hwan on 03.12.2022.
//

import SwiftUI

struct ContentView: View {
    let moves = ["rock", "scissors", "paper"]
    
    @State private var appCurrentChoice = Int.random(in: 0...2)
    @State private var restart = false
    @State private var showResult = false
    @State private var resultTitle = ""
    @State private var wonScore = 0
    @State private var lostScore = 0
    @State private var roundsLeft = 10
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Background1"), Color("Background2")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("App Choice")
                        .font(.custom("HelveticaNeue", size: 24).weight(.thin))
                        .foregroundColor(Color("Background2"))
                    
                    ZStack {
                        Text("❔")
                            .font(.system(size: 150))
                            .foregroundColor(showResult ? .clear : .primary)
                        Image(moves[appCurrentChoice])
                            .resizable()
                            .frame(width: 150, height: 150)
                            .opacity(showResult ? 1 : 0)
                    }
                }
                .padding(40)
                .background(Color("Background1"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color("Background2"), radius: 20)
                
                Spacer()
                
                HStack {
                    VStack {
                        Text("WON")
                        Text("\(wonScore)")
                    }
                    .frame(width: 200)
                    
                    VStack {
                        Text("LOST")
                        Text("\(lostScore)")
                    }
                    .frame(width: 200)
                }
                .font(.custom("HelveticaNeue", size: 24).weight(.regular))
                .foregroundColor(Color("Background1"))
                
                Spacer()
                
                Text("Your Choice")
                    .font(.custom("HelveticaNeue", size: 24).weight(.thin))
                    .foregroundColor(Color("Background1"))
                    .padding()
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            if roundsLeft > 1 {
                                moveChosen(moves[number])
                            } else {
                                restart = true
                            }
                        } label: {
                            Text(Image(moves[number]))
                        }
                        .padding(10)
                        .background(Color("LightText"))
                        .cornerRadius(10)
                        .shadow(color: Color("LightText"), radius: 20, x: 10, y: 10)
                    }
                }
                
                
                Spacer()
                
                Text("\(roundsLeft) ROUNDS LEFT")
                    .font(.custom("HelveticaNeue", size: 12).weight(.regular))
                    .foregroundColor(Color("Background1"))
                
                Spacer()
            }
        }
        
        .alert(resultTitle, isPresented: $showResult) {
            Button("Continue") {
                appCurrentChoice = Int.random(in: 0...2)
            }
        } message: {
            Text("You won \(wonScore) rounds and lost \(lostScore) rounds. \n\(roundsLeft) rounds left")
        }
        
        .alert("GAME OVER!", isPresented: $restart) {
            Button("Try again") {
                restartGame()
            }
        } message: {
            if wonScore > lostScore {
                Text("YOU WON! \nYou won \(wonScore) rounds and lost \(lostScore) rounds.")
            } else if wonScore < lostScore {
                Text("YOU LOST! \nYou won \(wonScore) rounds and lost \(lostScore) rounds.")
            } else {
                Text("DRAW! \nYou won \(wonScore) rounds and lost \(lostScore) rounds.")
            }
        }
    }
    
    func moveChosen(_ playerChoice: String) {
        if playerChoice == moves[appCurrentChoice]  {
            showResult.toggle()
            resultTitle = "DRAW!"
            roundsLeft -= 1
        } else if playerChoice == "🪨" && moves[appCurrentChoice] == "✂️" {
            showResult.toggle()
            resultTitle = "YOU WIN!"
            wonScore += 1
            roundsLeft -= 1
        } else if playerChoice == "✂️" && moves[appCurrentChoice] == "📄" {
            showResult.toggle()
            resultTitle = "YOU WIN!"
            wonScore += 1
            roundsLeft -= 1
        } else if playerChoice == "📄" && moves[appCurrentChoice] == "🪨" {
            showResult.toggle()
            resultTitle = "YOU WIN!"
            wonScore += 1
            roundsLeft -= 1
        } else {
            showResult.toggle()
            resultTitle = "YOU LOST!"
            lostScore += 1
            roundsLeft -= 1
        }
    }
    
    func restartGame() {
        appCurrentChoice = Int.random(in: 0...2)
        wonScore = 0
        lostScore = 0
        roundsLeft = 10
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
