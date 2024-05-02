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
    func getAllData(completion: (([UserInfo]) -> Void)?)
}

final class AuthManager: AuthManagerProtocol {
    
    static var shared = AuthManager()
    var isAuth = false
    
    init() {
        checkStatus()
    }
    
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
    
    func getAllData(completion: (([UserInfo]) -> Void)?) {
        var users: [UserInfo] = []
        let ref = Database.database().reference().child("users")
        ref.getData { error, dataSnapshot in
            guard let data = dataSnapshot?.value as? [String: Any] else {
                print("Failed to parse data snapshot")
                completion?([])
                return
            }
            
            for (_, userData) in data {
                guard let userData = userData as? [String: Any],
                      let coins = userData["coins"] as? Int,
                      let email = userData["email"] as? String,
                      let name = userData["name"] as? String,
                      let winRate = userData["winRate"] as? Int else {
                    continue
                }
                
                let user = UserInfo(coins: coins, email: email, name: name, winRate: winRate)
                users.append(user)
            }
            
            completion?(users)
        }
    }
}

struct UserInfo {
    let coins: Int
    let email: String
    let name: String
    let winRate: Int
}