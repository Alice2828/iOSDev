//
//  FacultiesVC.swift
//  KBTUApp
//
//  Created by User on 09.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
var selectedImage: String?
var selectedText: String?
var selectedTextMore: String?
class FacultiesVC: UIViewController {
    
    @IBOutlet weak var facultiesCollectionView: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //register custom cell
        let nib = UINib(nibName: "FacultyCell", bundle: nil)
        facultiesCollectionView.register(nib, forCellWithReuseIdentifier: "facultyCell")
        
        //delegates for collectionView
        facultiesCollectionView.delegate = self
        facultiesCollectionView.dataSource = self
        
        //flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 10, height: 190)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        facultiesCollectionView.collectionViewLayout = flowLayout
    }
}
extension FacultiesVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        switch(collectionView){
        case(facultiesCollectionView):
            let newcell = (collectionView.dequeueReusableCell(withReuseIdentifier: "facultyCell", for: indexPath) as? FacultyCell)!
            newcell.facultyImageView.image = UIImage(named: facultyIcons[indexPath.row])
            newcell.facultyLabel.text = items[indexPath.row]
            return newcell as UICollectionViewCell
        default:
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let cell = collectionView.cellForItem(at: indexPath) as! FacultyCell
        cell.facultyImageView.layer.borderColor = UIColor.green.cgColor    
        cell.facultyImageView.layer.borderWidth = 4
        selectedImage = deans[indexPath.row]
        selectedText = deanTexts[indexPath.row]
        selectedTextMore = facultyMoreText[indexPath.row]
        performSegue(withIdentifier: "facultyDetails", sender:self)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath) as! FacultyCell
        cell.facultyImageView.layer.borderColor = UIColor.clear.cgColor
        cell.facultyImageView.layer.borderWidth = 4
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "facultyDetails"){
            if  let destination = segue.destination as? FacultyDetailVC{
                destination.image = UIImage(named: selectedImage!)
                destination.text = selectedText
                destination.textMore = selectedTextMore
            }
        }
    }
}
