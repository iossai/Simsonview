//
//  HomeViewModel.swift
//  SimpsonsCharacterViewer
//
//  Created by Sai Goutham  on 27/01/19.
//  Copyright © 2019 DataQ. All rights reserved.
//

import Foundation
import Alamofire

public class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    /// Get Users
    ///
    /// - Parameter handler: handel the response
    func getUsers(handler: @escaping (_ results: [[String: Any]]?, _ erro: Error?) -> Void) {
        Alamofire.request(Constants.serviceURL).responseJSON { response in
            if response.result.error != nil {
                handler(nil,response.result.error)
            } else {
                var results : [[String: Any]]  = []
                if let finalResponse = response.result.value as? [String: Any] {
                    results = finalResponse["RelatedTopics"] as? [[String: Any]] ?? []
                }
                handler(results, nil)
            }
        }
    }
    
    /// Create User model from the results
    ///
    /// - Parameter results: results array
    /// - Returns: list of user model objects
    func creteUserModels(results: [[String: Any]]) -> [User] {
        var users : [User] = []
        let decoder = JSONDecoder()
        for result in results {
            let data = try! JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
            let user = try! decoder.decode(User.self, from: data)
            users.append(user)
        }
        return users
    }
    
    
    /// Get title and descreption
    ///
    /// - Parameter userText: complte text
    /// - Returns: title and descreption
    func getTitleDescreption(userText: String) -> (title: String, descreption:  String) {
        var title = ""
        var descreption = ""
        let titleDescreptionArray = userText.components(separatedBy: " - ")
        if titleDescreptionArray.count == 1 {
            title = titleDescreptionArray[0]
        } else if titleDescreptionArray.count >= 2 {
            title = titleDescreptionArray[0]
            descreption = titleDescreptionArray[1]
        }
        return (title,descreption)
    }
}
