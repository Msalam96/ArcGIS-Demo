//
//  DetailViewController.swift
//  ArcGIS-Demo
//
//  Created by Brandon Cortes on 1/2/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UITableView {
    
    
    
    var attributesDict:NSMutableDictionary?
    private var keyArray =  [String]()
    private var valueArray =  [Any]()
    
    init(attributesDictionary: NSMutableDictionary) {
        super.init(frame: CGRect(x: 0, y: 0, width: 1000, height: 2000), style: .plain)
        
        self.attributesDict = attributesDictionary
        self.register(DetailTableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.dataSource = self
        self.delegate = self
        print("this is happening")
        
        for(key,value) in attributesDict! {
            //print("key:\(key) -- value:\(value)")
            
            keyArray.append(key as! String)
            valueArray.append(value)
            

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}

extension DetailViewController: UITableViewDelegate {
    
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributesDict!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // set the cell equal to a dequed cell so we can reuse it
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! DetailTableViewCell
        
        cell.leftText = keyArray[indexPath.row]
        cell.rightText = "\(valueArray[indexPath.row])"
        
        
        return cell
    }
    
    
    
}
