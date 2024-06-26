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
    func changeUserCoins(with newCoins: Double, winRate: WinRate, completion: (() -> Void)?)
    func getCurrentUserData(completion: ((UserInfo?) -> Void)?)
    func logOut()
    func deleteAccount()
}

final class AuthManager: AuthManagerProtocol {
    
    func logIn(email: String, pass: String, completion: ((Bool) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: pass) { result, error in
            if error == nil {
                completion?(true)
            } else {
                completion?(false)
            }
        }
    }
    
    func register(email: String, pass: String, name: String, completion: ((Bool) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: pass) { result, error in
            if error == nil {
                let ref = Database.database().reference().child("users")
                if let uid = result?.user.uid {
                    ref.child(uid).updateChildValues([
                        "name" : name,
                        "email" : email,
                        "win": 0,
                        "loose": 0,
                        "coins": 2000
                    ])
                    completion?(true)
                }
            } else {
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
                    "win": 0,
                    "loose": 0,
                    "coins": 2000
                ])
                print("anon created success")
                completion?(true)
            }
            
        }
    }
    
    func logOut() {
        do { try Auth.auth().signOut() }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError) }
    }
    
    func deleteAccount() {
        guard let currentUser = Auth.auth().currentUser else {
            print(NSError(domain: "AuthError", code: -1, userInfo: ["description": "No current user found"]))
            return
        }
        
        let uuid = currentUser.uid
        currentUser.delete { [weak self] error in
            self?.deleteUserFromRealtimeDatabase(uuid: uuid) {
                self?.logOut()
            }
            if let error = error {
                print("Error deleting account: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func deleteUserFromRealtimeDatabase(uuid: String, completion: (() -> Void)?) {
        let ref = Database.database().reference().child("users").child(uuid)
        
        ref.removeValue { error, _ in
            completion?()
        }
    }
    
    func changeUserCoins(with newCoins: Double, winRate: WinRate, completion: (() -> Void)?) {
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference().child("users").child(uid)
            ref.getData { error, data in
                var looseCount = 0
                var winCount = 0
                
                if let userData = data?.value as? [String: Any],
                   let win = userData["win"] as? Int,
                   let loose = userData["loose"] as? Int {
                    looseCount = loose
                    winCount = win
                    var newLooseCount = loose + 1
                    var newWinCount = win + 1
                    var parametersToChange: [AnyHashable: Any] = ["coins": newCoins]
                    switch winRate {
                    case .win:
                        parametersToChange["win"] = newWinCount
                    case .loose:
                        parametersToChange["loose"] = newLooseCount
                    case .all:
                        parametersToChange["win"] = newWinCount
                        parametersToChange["loose"] = newLooseCount
                    }
                    ref.updateChildValues(parametersToChange) { (error, _) in
                        if let error = error {
                            print("ошибка, \(error)")
                        } else {
                            print("coins успешно обновлено")
                            completion?()
                        }
                    }
                }
            }
        }
    }
    
    func getCurrentUserData(completion: ((UserInfo?) -> Void)?) {
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference().child("users").child(uid)
            ref.observeSingleEvent(of: .value) { dataSnapshot in
                if let userData = dataSnapshot.value as? [String: Any],
                   let coins = userData["coins"] as? Double,
                   let email = userData["email"] as? String,
                   let name = userData["name"] as? String,
                   let win = userData["win"] as? Int,
                   let loose = userData["loose"] as? Int {
                    let user = UserInfo(coins: coins, email: email, name: name, win: win, loose: loose, isItMe: true)
                    completion?(user)
                } else {
                    completion?(nil)
                }
            }
        } else {
            completion?(nil)
        }
    }
    
    func getAllData(completion: (([UserInfo]) -> Void)?) {
        var users: [UserInfo] = []
        let refUsers = Database.database().reference().child("users")
        
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference().child("users").child(uid)
            ref.getData { error, data in
                var userName = ""
                if let userData = data?.value as? [String: Any],
                   let name = userData["name"] as? String {
                    userName = name
                }
                
                refUsers.getData { error, dataSnapshot in
                    guard let data = dataSnapshot?.value as? [String: Any] else {
                        print("Failed to parse data snapshot")
                        completion?([])
                        return
                    }
                    
                    for (_, userData) in data {
                        guard let userData = userData as? [String: Any],
                              let coins = userData["coins"] as? Double,
                              let email = userData["email"] as? String,
                              let name = userData["name"] as? String,
                              let win = userData["win"] as? Int,
                              let loose = userData["loose"] as? Int else {
                            continue
                        }
                        var isItMe: Bool = false
                        
                        if userName == name && userName != "Anonym" {
                            isItMe = true
                        }
                        let user = UserInfo(coins: coins, email: email, name: name, win: win, loose: loose, isItMe: isItMe)
                        users.append(user)
                    }
                    completion?(users)
                }
            }
        }
    }
}

struct UserInfo {
    let coins: Double
    let email: String
    let name: String
    let win: Int
    let loose: Int
    let isItMe: Bool
}
