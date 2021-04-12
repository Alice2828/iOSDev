//
//  Tweet.swift
//  TwitterApp
//
//  Created by User on 10.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class Tweet{
    var tweet: String?
    var author: String?
    var date: String?
    var hashtag: String?
    var randomId: String?
    var userId: String?
    var dict: [String: String]{
        return [
            "randomId": randomId!,
            "tweet": tweet!,
            "author": author!,
            "date": date!,
            "hashtag": hashtag!,
            "userId": userId!
        ]
    }
    
    init(_ randomId:String, _ tweet: String, _ author: String, _ date: String, _ hashtag: String, _ userId:String) {
        self.tweet = tweet
        self.author = author
        self.date = date
        self.hashtag = hashtag
        self.randomId = randomId
        self.userId = userId
    }
    
    init(snapshot: DataSnapshot){
        if let value = snapshot.value as? [String:String]{
            tweet = value["tweet"]
            author = value["author"]
            date = value["date"]
            hashtag = value["hashtag"]
            randomId = value["randomId"]
            userId = value["userId"]
        }
    }
}
