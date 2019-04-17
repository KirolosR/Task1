//
//  MainCategory.swift
//  Task1
//
//  Created by Kirolos on 3/31/19.
//  Copyright © 2019 Kirolos. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher



class MainCategory: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
   
    
    @IBOutlet weak var MainCatCollection: UICollectionView!
    
    var categories : [category] = []
    
    @IBOutlet weak var spin: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       MainCatCollection.delegate = self
       MainCatCollection.dataSource = self
   
        MainCatCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        let width = view.bounds.width / 2
        let layout = MainCatCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        self.spin.isHidden = false
        self.spin.startAnimating()
        
       loadCategory()
        
    }
        
       

        
    
    func loadCategory(){
           DispatchQueue.main.async{
            GetCategory.instance.getCat(Url: Main_CAT_URL) { (success) in
                if(success){
                    debugPrint("success!")
                    self.categories  = GetCategory.categories!
                }
            
            
               
           }
         DispatchQueue.main.async(execute: self.finishThread)
        }
        
        }
    

    func finishThread(){
        self.spin.isHidden = true
        self.spin.stopAnimating()
       self.MainCatCollection.reloadData()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = MainCatCollection.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as? CategoryCell else { return  CategoryCell()}
        
           
            
         //   cell.path = self.categories[indexPath.row].Photo ?? ""
           let url = URL(string: self.categories[indexPath.item].Photo ?? "")
       
            cell.catImage.kf.setImage(with: url ,  placeholder : UIImage(named: "cat_no_img"))
             var k = self.categories[indexPath.item].TitleAR ?? ""
            var pc = self.categories[indexPath.item].ProductCount ?? ""
            cell.catLabel.text =  "\(k) ( \(pc) )"
            return cell
 
        
      return CategoryCell()
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        SubCategory.categoryId = categories[indexPath.item].Id
        SubCategory.categoryLabel = categories[indexPath.item].TitleAR
        performSegue(withIdentifier: "selectedCell", sender: nil)
    }
    
   

    
}

