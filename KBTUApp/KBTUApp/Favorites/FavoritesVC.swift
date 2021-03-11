//
//  FavoritesVC.swift
//  KBTUApp
//
//  Created by User on 11.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
protocol DeleteProtocol{
    func deleteFav(item faculty: Faculty)
}
class FavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DeleteProtocol {
    @IBOutlet weak var favoritesCV: UICollectionView!
    func deleteFav(item faculty: Faculty) {
        if let index = favorites.firstIndex(where: { $0 == faculty}){
            favorites.remove(at: index)
            facultiesCV.deleteItems(at: [IndexPath(row: index, section: 0)])
        }
        facultiesCV.reloadData()
    }
    
    @IBOutlet weak var facultiesCV: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (favorites.count == 0){
            favoritesCV.setMessage("Empty list")
        }
        else{
            favoritesCV.restore()
        }
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
            newcell.faculty = favorites[indexPath.row]
            newcell.delegateDelete = self
            cell = newcell as UICollectionViewCell
            return cell
        default:
            return cell
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates for collectionView
        //register custom cell
        let nib = UINib(nibName: "FacultyCell", bundle: nil)
        facultiesCV.register(nib, forCellWithReuseIdentifier: "facultyCell")
        facultiesCV.delegate = self
        facultiesCV.dataSource = self
        //flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 10, height: 190)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        facultiesCV.collectionViewLayout = flowLayout
        
        
    }
}
extension UICollectionView{
    func setMessage(_ message: String){
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
    messageLabel.sizeToFit()
    
    self.backgroundView = messageLabel
    }
    func restore() {
        self.backgroundView = nil
    }
}
