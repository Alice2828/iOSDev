//
//  NewsVC.swift
//  KBTUApp
//
//  Created by User on 06.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class NewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var images:[String] = ["ded.png","meetingRector.jpg","olimp2021.jpg","stipendialnayaPrograma.png","bestTeacher.jpg"]
    var labels:[String] = ["СУЛЕЙМЕНОВ ЭСЕН НУРГАЛИЕВИЧ: ПОЧЕТНОЕ ЗВАНИЕ «ОСНОВАТЕЛЬ НАУЧНОГО НАПРАВЛЕНИЯ»","On February 6, 2021, was held the first face-to-face meeting of the KBTU Rector with the Board of the KBTU ALUMNI Association.","Dear students and college graduates! We are pleased to announce to you the holding of the KBTU","Scientific and educational foundation named after Academician Shakhmardan Yessenov","Teachers of KBTU Isakhov Asylbek Abdiashimovich and Kulpeshov Beibut Shaiykovich became the holders of the title The best teacher of the"]
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
    
}
extension UIImage{
    func getCropRatio()->CGFloat{
        let widthRatio = CGFloat(self.size.width/self.size.height)
        return widthRatio
    }
}
