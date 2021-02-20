//
//  LoginView.swift
//  X3BarWorkout
//
//  Created by David Fish on 11/30/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI
import Foundation
import CryptoSwift

struct LoginView: View {

    @EnvironmentObject var settings: Settings
    @Environment(\.presentationMode) var presentationMode

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var emailAddress = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMsg = ""
    @State private var showForgotPassword = false
    @State private var showSignup = false
    @State var showAlert = false
    @State var showDetails = false

    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }

    func passwordHash(from email: String, password: String) -> String {
      let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        return "\(password).\(email).\(salt)".sha256()
    }

    func login() -> Bool {
        var loginSuccess = false
        let finalHash = passwordHash(from: emailAddress, password: password)

        /*try KeychainPasswordItem(service: serviceName, account: user.email).savePassword(finalHash)

        Settings.currentUser = user */

        // Create URL
        let url = URL(string: "https://www.davidefish.com/X3BarWorkoutTracker/api/User/login.php?email=\(emailAddress)&password=\(finalHash)")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                loginSuccess = false
                return
            }

            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }

            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {

                    // Print out entire dictionary
                    print(convertedJsonIntoDict)

                    // Get value by key
                    let status = convertedJsonIntoDict["status"] as? Int
                    let message = convertedJsonIntoDict["message"] as? String

                    if status == 1 {
                        //Successfully enrolled
                        self.presentationMode.wrappedValue.dismiss()
                        loginSuccess = true
                        return
                    } else {
                        //There was a problem enrolling the user
                        self.alertMsg = message ?? "An error occured. Please try again"
                        self.showingAlert = true
                        self.emailAddress = ""
                        self.password = ""
                        loginSuccess = false
                        return
                    }

                }

            } catch let error as NSError {
                print(error.localizedDescription)
                loginSuccess = false
                return
            }

        }
        task.resume()
        return loginSuccess
    }

    fileprivate func isValidInputs() -> Bool {

        if self.emailAddress.isEmpty {
            self.alertMsg = "Email can't be blank."
            self.showAlert.toggle()
            return false
        } else if !self.emailAddress.isValidEmail {
            self.alertMsg = "Email is not valid."
            self.emailAddress = ""
            self.showAlert.toggle()
            return false
        } else if self.password.isEmpty {
            self.alertMsg = "Password can't be blank."
            self.showAlert.toggle()
            return false
        } else if !(self.password.isValidPassword) {
            self.alertMsg = "Please enter valid password"
            self.password = ""
            self.showAlert.toggle()
            return false
        }

        return true
    }

    var body: some View {
        VStack {

                VStack {
                    Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)

                    VStack {

                        HStack {

                            Image("ic_email")
                                .padding(.leading, (UIScreen.main.bounds.width * 20) / 414)

                            TextField("Email", text: $emailAddress)
                                .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                                .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                                .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                                .imageScale(.small)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)

                        }
                        Separator()
                    }

                    Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)

                    VStack {

                        HStack {
                            Image("ic_password")
                                .padding(.leading, (UIScreen.main.bounds.width * 20) / 414)

                            SecureField("Password", text: $password)
                                .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                                .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                                .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                                .imageScale(.small)
                        }
                        Separator()

                    }

                    Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)

                    VStack(alignment: .trailing) {
                        HStack {
                            Spacer()

                            Button(action: {
                                self.showForgotPassword = true
                            }) {
                                Text("Forgot Password?")
                                    //.foregroundColor(.)
                                    .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .bold, design: .default))

                            }.sheet(isPresented: self.$showForgotPassword) {
                                ForgotPasswordView()
                            }

                        }.padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                    }

                    VStack {
                        Spacer()
                        Button(action: {
                            if self.isValidInputs() {
                                // For use with property wrapper
                                UserDefaults.standard.set(true, forKey: "Loggedin")
                                UserDefaults.standard.synchronize()
                                self.settings.loggedIn = true
                                // ==========

                                // For use with property wrapper
                                //                self.dataStore.loggedIn = true
                                // ==========
                            }

                        }) {
                            ButtonWithBackground(btnText: "LOGIN")
                        }
                        Spacer()
                    }

                    VStack {
                        Spacer(minLength: (UIScreen.main.bounds.width * 10) / 414)
                        Button(action: {
                            self.showSignup = true
                        }) {
                            Text("New User? Create an account")
                                //.foregroundColor(.white)
                                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .bold, design: .default))

                        }.sheet(isPresented: self.$showSignup) {
                            SignupView()
                        }

                        Spacer(minLength: (UIScreen.main.bounds.width * 20) / 414)
                    }
                }

                .alert(isPresented: $showAlert, content: { self.alert })
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
