//
//  News.swift
//  Exam
//
//  Created by Apple on 2019/12/23.
//  Copyright © 2019 Exam. All rights reserved.
//

import UIKit

class News: NSObject {

    var title: String = ""
    
    var count: Int = 0
    
    var url: String = ""
    
    var date: String = ""
    
    init(title: String, count: Int, url: String, date: String) {
        self.title = title
        self.count = count
        self.url = url
        self.date = date;
        super.init()
    }
}
