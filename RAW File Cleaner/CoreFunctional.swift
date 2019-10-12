//
//  CoreFunctional.swift
//  RAW File Cleaner
//
//  Created by Yaryna Pochtarenko on 21/09/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//

import Foundation

let defaults = UserDefaults.standard

func raw_filter(_ directory_items:[String],raw_name:String) ->[String]{
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
            let lower_gen_name = filename.deletingPathExtension + ".jpg"
            let upper_gen_name = filename.deletingPathExtension + ".JPG"
            //print("gen_name",gen_name)
            if !(directory_items.contains(lower_gen_name) ||
                directory_items.contains(upper_gen_name)) {
                filtered.append(filename as String)
            }
        }
    }
    
    return filtered
}

func concatenate_path(_ directory_items:[String],
                      _ directory_path:String) ->[URL]{
    
    var file_urls = [URL]()
    let dir_URL = URL(fileURLWithPath: directory_path)
    for i in directory_items{
        let file_url = dir_URL.appendingPathComponent(i)
        file_urls.append(file_url)
    }
    return file_urls
}


class FilterModel: ObservableObject {
    @Published var show_popup:Bool = false
    @Published var message:String = ""
    @Published var alert_title: String = "Warning"
    
    @Published var selected_raw_extension = defaults.integer(forKey: "RAW_TYPE")
    let raw_extensions = ["CR2","CR3","NEF",
                          "NRW","DNG","GPR",
                          "RAW","RAF","ORF"]
    let file_manager = FileManager.default
    
    func apply_filter(_ dir_path:String){
        var is_dir : ObjCBool = false
        defaults.set(selected_raw_extension, forKey: "RAW_TYPE")
        
        if (dir_path == "") {
            show_popup = true
            message = "Direcory is not selected"
            return
        }
        
        if file_manager.fileExists(atPath: dir_path, isDirectory: &is_dir){
            do {
                let dir_items = try file_manager.contentsOfDirectory(atPath: dir_path)
                let filtered_items = raw_filter(dir_items,
                                                raw_name: raw_extensions[selected_raw_extension])
                if filtered_items.isEmpty {
                    message = "Can't find any spare file"
                    show_popup = true
                    return
                }
                let file_urls = concatenate_path(filtered_items,dir_path)
                move_to_trash(file_urls)
                alert_title = "Done"
                message = "\(file_urls.count) Spare files has been moved to recycle bin."
                show_popup = true
            }
            catch{}
        }
        else {
            show_popup = true
            message = "Direcory Is Not Exist"
        }
    }
    
    func move_to_trash(_ file_urls: [URL]){
        for i:URL in file_urls{
            do{
                try file_manager.trashItem(at: i, resultingItemURL: nil)
            }
            catch CocoaError.fileWriteNoPermission{
                show_popup = true
                message = "Please, give application permission to move the files"
            }
            catch{
                show_popup = true
                message = "Files wasn't moved \n \(error)"
            }
        }
    }
}
