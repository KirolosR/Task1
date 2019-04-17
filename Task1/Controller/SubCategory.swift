//
//  SubCategory.swift
//  Task1
//
//  Created by Kirolos on 3/31/19.
//  Copyright © 2019 Kirolos. All rights reserved.
//

import UIKit
import Kingfisher

class SubCategory: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    
    static  var  categoryId : Int?
    static  var  categoryLabel : String?
     var categories : [category] = []
    var  SubCatURL : String = ""
    @IBOutlet weak var SubCatCollection: UICollectionView!
    
    @IBOutlet weak  var subCategoryLabel: UILabel!
    @IBOutlet weak var spin: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        SubCatCollection.delegate = self
        SubCatCollection.dataSource = self
        subCategoryLabel.text = SubCategory.categoryLabel!
        SubCatCollection.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        let width = view.bounds.width / 2
        let layout = SubCatCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        
        self.spin.isHidden = false
        self.spin.startAnimating()
        
        loadCategory()
    }

  
    func loadCategory(){
        DispatchQueue.main.async{
            
            self.SubCatURL = "\(Sub_CAT_URL)\(SubCategory.categoryId!)&countryId=1"
            GetCategory.instance.getCat(Url: self.SubCatURL) { (success) in
                if(success){
                    debugPrint("success!")
                    self.categories  = GetCategory.categories!
                }
                
                DispatchQueue.main.async(execute: self.finishThread)
                
            }
        }
        
    }
    
    
    func finishThread(){
        self.spin.isHidden = true
        self.spin.stopAnimating()
        self.SubCatCollection.reloadData()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = SubCatCollection.dequeueReusableCell(withReuseIdentifier: "subCategory", for: indexPath) as? SubCategoryCell else { return  SubCategoryCell()}
        
       
        //   cell.path = self.categories[indexPath.row].Photo ?? ""
        let url = URL(string: self.categories[indexPath.item].Photo ?? "")
        
        cell.catImage.kf.setImage(with: url ,  placeholder : UIImage(named: "cat_no_img"))
        var k = self.categories[indexPath.item].TitleAR ?? ""
        var pc = self.categories[indexPath.item].ProductCount ?? ""
        cell.catLabel.text =  "\(k) ( \(pc) )"
        return cell
        
    
        
        return SubCategoryCell()
    }
    
   
    @IBAction func backBtnPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "MainCat", sender: nil)
    }
    
}
