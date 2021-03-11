//
//  FavoritesVC.swift
//  KBTUApp
//
//  Created by User on 11.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var facultiesCV: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch (collectionView)
        {
        case (facultiesCV):
            
            let newcell = (collectionView.dequeueReusableCell(withReuseIdentifier: "facultyCell", for: indexPath) as? FacultyCell)!
            newcell.facultyImageView.image = UIImage(named: favorites[indexPath.row].facultyIcon!)
            newcell.facultyLabel.text = favorites[indexPath.row].facultyTitle
            cell = newcell as UICollectionViewCell
            return cell
        default:
            return cell
        }
    }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
}
