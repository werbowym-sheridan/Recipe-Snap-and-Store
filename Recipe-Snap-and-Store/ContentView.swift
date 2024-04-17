//
//  ContentView.swift
//  Recipe-Snap-and-Store
//
//  Created by Michael Werbowy on 2024-04-13.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
                ZStack{
                    
                    Color("Light egg yellow")
                        .edgesIgnoringSafeArea(.all)
                    
                    Text("Recipe")
                        .position(x: 150, y: 100)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Recipe")
                        .position(x: 147, y: 99)
                        .font(.largeTitle)
                        .foregroundColor(Color("Orange red"))
                        .fontWeight(.bold)
                    
                    Image(.recipeBook)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .position(x: 225, y: 100)
                    
                    Text("Snap")
                        .position(x: 210, y: 150)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Snap")
                        .position(x: 207, y: 148)
                        .font(.largeTitle)
                        .foregroundColor(Color("Light baby blue"))
                        .fontWeight(.bold)
                    
                    Image(systemName: "camera")
                        .foregroundColor(.black)
                        .bold()
                        .font(.system(size: 25))
                        .position(x: 275, y: 151)

                    Text("N'")
                        .position(x: 280, y: 210)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Store")
                        .position(x: 330, y: 260)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Store")
                        .position(x: 327, y: 258)
                        .font(.largeTitle)
                        .foregroundColor(Color("Egg yellow"))
                        .fontWeight(.bold)
                        
                    Image(systemName:"square.and.arrow.down")
                        .foregroundColor(.black)
                        .bold()
                        .font(.system(size: 25))
                        .position(x: 395, y: 258)
                        
                    Image(.contentViewPic)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 510, height: 250)
                        .position(x: 250, y: 400)

                    NavigationLink(destination: SignUpView()) {
                        Text("Create Account")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 270, maxHeight: 30)
                            .padding()
                            .background(Color("Dark Indigo"))
                            .cornerRadius(30)
                            .shadow(color: .gray, radius: 3, x: 2, y: 2)
                    }
                    .navigationBarBackButtonHidden(true)
                    .position(x: 250, y: 598)
                    DividerWithText()
                            .padding()
                            .position(x: 182, y: 648)
                            .frame(maxWidth: 365)
                    NavigationLink(destination: LogInView()) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: 270, maxHeight: 30)
                            .padding()
                            .background(Color("Egg yellow"))
                            .cornerRadius(30)
                            .shadow(color: .gray, radius: 3, x: 2, y: 2)
                    }
                    .navigationBarBackButtonHidden(true)
                    .padding()
                    .position(x: 250, y: 698)
            }
            // The frame modifier here is to provide enough space for the absolute positioning
            .frame(width: 500, height: 800)

                .padding(.horizontal)
        
        }
        .navigationBarBackButtonHidden(true)
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
