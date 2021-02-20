//
//  SignUpView.swift
//  X3BarWorkout
//
//  Created by David Fish on 12/3/19.
//  Copyright © 2019 David Fish. All rights reserved.
//

import SwiftUI
import Foundation

struct SignupView: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var emailAddress = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showingAlert = false
    @State private var alertMsg = ""

    func signup() {

        //Validate email address
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        if  !emailPredicate.evaluate(with: self.emailAddress) {
            self.alertMsg = "Not a valid email address format"
            self.emailAddress = ""
            self.password = ""
            self.confirmPassword = ""
            self.showingAlert = true
            return
        }

        //validate password match
        if password != confirmPassword {
            print("Passwords do not match")
            self.password = ""
            self.confirmPassword = ""
            self.alertMsg = "Passwords do not match"
            self.showingAlert = true
            return
        }

        // Create URL
        let url = URL(string: "https://www.davidefish.com/X3BarWorkoutTracker/api/User/signup.php")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "POST"

        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "firstName=\(firstName)&lastName=\(lastName)&email=\(emailAddress)&password=\(password)"

        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8)

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check if Error took place
            if let error = error {
                self.alertMsg = "An error occured: \(error)"
                print("An error took place \(error)")
                return
            }

            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }

            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {

                    // Get value by key
                    let status = convertedJsonIntoDict["status"] as? Int
                    let message = convertedJsonIntoDict["message"] as? String

                    if status == 1 {
                        //Successfully enrolled
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        //There was a problem enrolling the user
                        self.alertMsg = message ?? "An error occured. Please try again"
                        self.showingAlert = true
                    }
                }

            } catch let error as NSError {
                print(error.localizedDescription)
            }

        }
        task.resume()

    }

    var body: some View {
        Form {
            Section(header: Text("Name").bold()) {
                TextField("First Name", text: $firstName )
                TextField("Last Name", text: $lastName)
            }
            Section(header: Text("Email").bold()) {
                TextField("Email Address", text: $emailAddress)
                    .autocapitalization(.none)
            }
            Section(header: Text("Password")) {
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)
            }
            Section {
                Button("Signup") {
                    self.signup()
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("X3 Bar Workout Tracker"), message: Text(self.alertMsg), dismissButton: .default(Text("OK")))
                }
            }
            .disabled(emailAddress.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty)
        }
        .navigationBarTitle(Text("Register"), displayMode: .inline)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
