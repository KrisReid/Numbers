//
//  ContentView.swift
//  Shared
//
//  Created by Kris Reid on 26/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var contentVM = ContentViewModel()
    
    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                Text("Number - Text")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 20)
                
                VStack(alignment: .leading) {
                    
                    Text("Type in a number from 0 - 999")
                        .font(.system(size: 15, weight: .light))
                        .padding(.bottom, 6)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: Binding(
                            get: { String(contentVM.number) },
                            set: { contentVM.number = Int($0) ?? 0 }
                        ))
                        .keyboardType(.numberPad)
                        .foregroundColor(Color.gray)
                        .padding(10)
                        
                        Spacer()
                    }
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    
                    HStack {
                        Spacer()
                        Text("\(contentVM.number)")
                            .padding(.top, 2)
                            .font(.system(size: 14, weight: .light))
                    }
                    
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                contentVM.numberConverter()
                            }, label: {
                                Text("Convert to text")
                            })
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .font(.system(size: 14, weight: .light))
                            .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                            .cornerRadius(10)
                            
                            Text("\(contentVM.text)")
                                .padding()
                                .font(.system(size: 14, weight: .light))
                        }
                        Spacer()
                    }
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .padding()
                .background(Color(.init(white: 1, alpha: 0.3)))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
