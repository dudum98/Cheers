//
//  ContentView.swift
//  Cheerify
//
//  Created by Kari on 1/5/24.
//

import SwiftUI

// TODO: fix the padding for menu and title

struct ContentView: View {
    @State private var affirmation: String = "Get started by pressing the refresh button..."
    var body: some View {
        ZStack {
            GIFImageView(gifURL: URL(string: "https://media0.giphy.com/media/KztT2c4u8mYYUiMKdJ/200.webp?cid=ecf05e473flmfm6hquy5wmdmullnzptj0o1n96ocsmerfwxf&ep=v1_gifs_search&rid=200.webp&ct=g")!)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.4)
            VStack {
                HStack{
                    Button {
                        //view menu button
                        print("Button")
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(Circle())
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding(.leading, 10)
                    Spacer()
                    VStack {
                        Text("Cheers")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 63/209, green: 65/255, blue: 78/200))
                        Text("daily affirmation buddy")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 63/255, green: 65/255, blue: 78/255))
                    }
                    Spacer()
                    Button {
                        //add affirmation button
                        print("Button")
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(Circle())
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding(.trailing, 10)

                    
                }
                Spacer()
                Text(affirmation)
                    .onAppear {
                        Task {
                            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.affirmations.dev/")!)
                            let decodedResponse = try? JSONDecoder().decode(Affirmation.self, from: data)
                            affirmation = decodedResponse?.affirmation ?? "failed"
                        }
                    }
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 63/255, green: 65/255, blue: 78/255))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                HStack{
                    Button {
                        // make a call to our affirmation API
                        Task {
                            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://www.affirmations.dev/")!)
                            let decodedResponse = try? JSONDecoder().decode(Affirmation.self, from: data)
                            affirmation = decodedResponse?.affirmation ?? "failed"
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(Circle())
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Button {
                        print("Button")
                    } label: {
                        // favorite affirmation button
                        Image(systemName: "heart.fill")
                            .frame(width: 50, height: 50)
                            .background(Color(red: 196/255, green: 197/255, blue: 202/255))
                            .clipShape(Circle())
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    .padding(.trailing, 10)
                }
            }
        }
    }
}

struct Affirmation: Codable {
    let affirmation: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
