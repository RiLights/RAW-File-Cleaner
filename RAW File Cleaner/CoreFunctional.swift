//
//  CoreFunctional.swift
//  RAW File Cleaner
//
//  Created by Yaryna Pochtarenko on 21/09/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//

import Foundation

func testPrint(){
    print("hellocore")
}

func apply_filter(_ directory_items:[String],raw_name:String) ->[String]{
    let lraw_ext = raw_name.lowercased()
    let uraw_ext = raw_name.uppercased()
    var filtered: [String] = []
    
    for directory_item in directory_items {
        let filename: NSString = directory_item as NSString
        var raw_ext: String!
        let pathExtention:String = filename.pathExtension
        if (pathExtention == lraw_ext) {raw_ext = lraw_ext}
        if (pathExtention == uraw_ext) {raw_ext = uraw_ext}
        if raw_ext != nil{
            let gen_name = filename.deletingPathExtension + ".jpg"
            if !(directory_items.contains(gen_name)) {
                filtered.append(filename as String)
            }
        }
    }
    
    return filtered
}

public class TEST {
    var total: Int!
    
    init(){
    }
}
