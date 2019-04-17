//
//  categoryDetails.swift
//  Task1
//
//  Created by Kirolos on 4/1/19.
//  Copyright © 2019 Kirolos. All rights reserved.
//

import Foundation


struct category : Decodable{
    var Id: Int?
    var TitleEN : String?
    var TitleAR : String?
    var Photo : String?
    var ProductCount : String?
    var HaveModel : String?
    var SubCategories : [category]?
}
