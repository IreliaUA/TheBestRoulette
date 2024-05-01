//
//  AuthManager.swift
//  TheBestRoulette
//
//  Created by Irina on 02.05.2024.
//

import UIKit
import FirebaseAuth
import Firebase


protocol AuthManagerProtocol {
    func logIn(email: String, pass: String, completion: ((Bool) -> Void)?)
    func register(email: String, pass: String, name: String, completion: ((Bool) -> Void)?)
    func signInAnonymously(completion: ((Bool) -> Void)?)
}

final class AuthManager: AuthManagerProtocol {
    var isAuth = false
    
    func logIn(email: String, pass: String, completion: ((Bool) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: pass) { result, error in
            if error == nil {
                print("Ошибок нет, ты вошел в свой акк!!!")
                completion?(true)
            } else {
                print("ошибка \(error)")
                completion?(false)
            }
        }
    }
    
    func register(email: String, pass: String, name: String, completion: ((Bool) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: pass) { result, error in
            if error == nil {
                print("Ошибок нет, \(result), userID = \(result?.user.uid)")
                let ref = Database.database().reference().child("users")
                if let uid = result?.user.uid {
                    ref.child(uid).updateChildValues([
                        "name" : name,
                        "email" : email,
                        "winRate": 0,
                        "coins": 2000
                    ])
                    completion?(true)
                }
            } else {
                print("Ошибka \(result) AND \(error)")
                completion?(false)
            }
        }
    }
    
    
    func signInAnonymously(completion: ((Bool) -> Void)?) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Error signing in anonymously: \(error.localizedDescription)")
                completion?(false)
                return
            }
            
            let ref = Database.database().reference().child("users")
            if let uid = authResult?.user.uid {
                ref.child(uid).updateChildValues([
                    "name" : "Anonym",
                    "email" : UUID().uuidString,
                    "winRate": 0,
                    "coins": 2000
                ])
                print("anon created success")
                completion?(true)
            }
            
        }
    }
    
    func createUserInFirestore(uuid: String, completion: @escaping (Error?) -> Void) {
        let userData: [String: Any] = [
            "uuid": uuid,
            "winRate": 0,
            "coins": 2000
        ]
        
        Firestore.firestore().collection("Users").document(uuid).setData(userData) { error in
            completion(error)
            
        }
    }
    
    func checkStatus() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.isAuth = false
            } else {
                self.isAuth = true
            }
        }
    }
    
    func getAllData() {
        let ref = Database.database().reference().child("users")
        ref.getData { error, data in
            print(data)
        }
    }
    
}
