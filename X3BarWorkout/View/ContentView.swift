//
//  ContentView.swift
//  X3BarWorkout
//
//  Created by David Fish on 10/21/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
let lightGreenColor = Color(red: 21.0/255.0, green: 183.0/255.0, blue: 177.0/255.0, opacity: 1.0)
let lightblueColor = Color(red: 85.0/255.0, green: 84.0/255.0, blue: 166.0/255.0, opacity: 1.0)

struct ButtonWithBackground: View {

    var btnText: String

    var body: some View {

        HStack {
//            Spacer()
            Text(btnText)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 140, height: 50)
                .background(lightblueColor)
                .clipped()
                .cornerRadius(5.0)
                .shadow(color: lightblueColor, radius: 5, x: 0, y: 5)

//            Spacer()
        }
    }
}

struct Separator: View {

    var body: some View {

        VStack {

            Divider().background(lightGreyColor)

        }.padding()
            .frame(height: 1, alignment: .center)
    }
}

struct ContentView: View {
    @State var selection = 0
    @State var showingAddScreen = false

    @ObservedObject var settings = UserSettings()

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {

                VStack {
                    Spacer()
                    NavigationLink(destination: Workout1(settings: settings)) {
                        Text("Workout 1").myNavStyle()
                    }

                    Spacer()
                    NavigationLink(destination: Workout2(settings: settings)) {
                        Text("Workout 2")
                            .myNavStyle()
                    }
                    Spacer()
                    NavigationLink(destination: CustomWorkout()) {
                        Text("Custom Workout")
                            .myNavStyle()
                    }
                    Spacer()
                }
                .tabItem {
                    VStack {
                        Image(systemName: "bolt")
                        Text("Workouts")
                    }
                }
                .tag(0)
                NavigationView {
                    VStack {
                        SettingsView()
                    }
                    .navigationBarTitle(Text("Reports"))
                }
                    .tabItem {
                        VStack {
                            Image(systemName: "folder")
                            Text("Reports")
                        }
                }
                .tag(1)
                NavigationView {
                    VStack {
                        SettingsView()
                    }
                    .navigationBarTitle(Text("History"))
                }
                    .tabItem {
                        VStack {
                            Image(systemName: "clock")
                            Text("History")
                        }
                }
                .tag(2)
                NavigationView {
                    VStack {
                        SettingsView()
                    }
                    .navigationBarTitle(Text("Settings"))
                }
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .tag(3)
            } //TabView
                .navigationBarTitle(Text("X3 Bar Workout Tracker"), displayMode:
                    .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                })
                    .sheet(isPresented: $showingAddScreen) {
                        LoginView()
                }
        } //NavigationView
            .accentColor(Color(.orange))
    } //Body
} //ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selection: 0)
    }
}
