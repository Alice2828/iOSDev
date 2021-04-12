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
var imageProfile = UIImage.init(named:"загружено")
class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var currentUser : User?
    @IBOutlet weak var myTableView: UITableView!
    var filteredData: [Tweet]!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var surname: UILabel!
    
    @IBOutlet weak var birthDate: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row].tweet! + "      " + filteredData[indexPath.row].hashtag!
        cell.detailTextLabel?.text = filteredData[indexPath.row].author! + "         " + filteredData[indexPath.row].date!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Change tweet", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = self.filteredData[indexPath.row].tweet!
        }
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = self.filteredData[indexPath.row].hashtag!
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
            
            let randomId = Database.database().reference().child("tweets").child(self.filteredData[indexPath.row].randomId!)
            
            let tweet = ["tweet": tweetContent!.text!,
                         "hashtag": hashtag!.text!,
                         "date": result]
            randomId.updateChildValues(tweet)
            
        }))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ref = Database.database().reference().child("tweets").child(self.filteredData[indexPath.row].randomId!)
            ref.removeValue()
            tweets.remove(at: indexPath.row)
            self.filteredData.remove(at: indexPath.row)
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
            let tweet = Tweet(randomId.key!, tweetContent!.text!, self.currentUser!.email!,result,hashtag!.text!, self.currentUser!.uid)
            randomId.setValue(tweet.dict)
        }))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? tweets : tweets.filter { (item: Tweet) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.hashtag!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        searchBar.delegate = self
        currentUser = Auth.auth().currentUser
        let parent = Database.database().reference().child("tweets")
        parent.observe(.value){
            [weak self](snapshot) in
            tweets.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let tweet = Tweet(snapshot: snap)
                    if tweet.userId == self!.currentUser!.uid {
                    tweets.append(tweet)
                    }
                }
            }
            self?.imageView.image = imageProfile
            tweets.reverse()
            self?.filteredData = tweets
            self?.myTableView.reloadData()
        }
        self.filteredData = tweets
        
        let parentUser = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        parentUser.observe(.value){
            [weak self](snapshot) in
            let user = UserCustom(snapshot: snapshot)
            self?.userName.text = user.name
            self?.surname.text = user.surname
            self?.birthDate.text = user.dateBirth
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        imageView.image = imageProfile
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
