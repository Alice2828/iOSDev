//
//  MainPageViewController.swift
//  TwitterApp
//
//  Created by User on 09.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

var tweets:[Tweet] = []

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currentUser : User?
    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        cell.textLabel?.text = tweets[indexPath.row].tweet
        cell.detailTextLabel?.text = tweets[indexPath.row].author
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = Database.database().reference().child("tweets").child(tweets[indexPath.row].randomId!)
            ref.removeValue()
            tweets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBAction func addTweet(_ sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New tweet", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Tweet"
        }
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Hashtag"
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Tweet", style: .default, handler: { [weak alert] (_) in
            //date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
            let result = formatter.string(from: date)
            //createtweet
            let tweetContent = alert?.textFields![0]
            let hashtag = alert?.textFields![1]
            
            let randomId = Database.database().reference().child("tweets").childByAutoId()
            let tweet = Tweet(randomId.key!, tweetContent!.text!, self.currentUser!.email!,result,hashtag!.text!)
            randomId.setValue(tweet.dict)
        }))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            
        }
        catch{
            print("Error sign out")
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser
        let parent = Database.database().reference().child("tweets")
        parent.observe(.value){
            [weak self](snapshot) in
            tweets.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let tweet = Tweet(snapshot: snap)
                    tweets.append(tweet)
                }
            }
            
            tweets.reverse()
            self?.myTableView.reloadData()
        }
    }
    @IBAction func gotoUserInfo(_ sender: UIButton) {
        goTo()
    }
    func goTo(){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let userPage = storyBoard.instantiateViewController(withIdentifier: "UserInfoViewController") as? UserInfoViewController{
            userPage.modalPresentationStyle = .fullScreen
            present(userPage, animated: true, completion: nil)
        }
    }
}
