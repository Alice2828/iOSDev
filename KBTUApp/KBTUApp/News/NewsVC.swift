//
//  NewsVC.swift
//  KBTUApp
//
//  Created by User on 06.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  
    @IBOutlet weak var newsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "newsCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        cell.newsImageView!.image = UIImage(named: images[indexPath.row])
        cell.newsLabel.text = labels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = UIImage(named: images[indexPath.row])
        let imageCrop = currentImage?.getCropRatio()
        return tableView.frame.width / imageCrop!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "newsDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "newsDetails"){
            let destination = segue.destination as! NewsDetailVC
            let index = (newsTableView.indexPathForSelectedRow?.row)!
            
            destination.image = UIImage(named: images[index])
            destination.text = text[index]
            destination.titleText = labels[index]
        }
    }
    
}
extension UIImage{
    func getCropRatio()->CGFloat{
        let widthRatio = CGFloat(self.size.width/self.size.height)
        return widthRatio
    }
}

