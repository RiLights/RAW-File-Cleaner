//
//  ContentView.swift
//  RAW File Cleaner
//
//  Created by Yaryna Pochtarenko on 16/09/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//Filter RAW files based on present jpg files in the same directory.
//Spare RAW files will be removed.
import SwiftUI

struct MainView: View {
    @State var selected_url: String = ""
    @ObservedObject var filter_model = FilterModel()
    
    var alert: Alert {
        Alert(title: Text(filter_model.alert_title), message: Text(filter_model.message), dismissButton: .default(Text("Ok")))
    }

    var body: some View {
        Section{
            VStack{
                DirectorySelect(selected_url: $selected_url)
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                
                RAWExtension(filter_model: self.filter_model)
                    .frame(width:195)
                
                Spacer()
                HStack{
                    Text("©2019 lovemiphoto.com")
                        .padding()
                        .foregroundColor(.secondary)
                        .font(.system(size: 10))
                    Spacer()
                    Button(action: {self.filter_model.apply_filter(self.selected_url)}) {
                        Text("Apply")
                    }
                    .padding()
                    .alert(isPresented: $filter_model.show_popup, content: { self.alert })
                }
            }
        }.frame(width: 400, height: 200)
    }
}

struct DirectorySelect: View {
    @Binding var selected_url: String
    
    var body: some View {
        VStack {
            HStack{
                TextField("Directory", text: $selected_url)
                Button(action: {
                    let dialog = NSOpenPanel()
                    dialog.title                   = "Choose a directory";
                    dialog.showsResizeIndicator    = true;
                    dialog.showsHiddenFiles        = false;
                    dialog.canChooseDirectories    = true;
                    dialog.canCreateDirectories    = false;
                    dialog.allowsMultipleSelection = false;
                    dialog.canChooseFiles = false;
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        let result = dialog.runModal()
                        if result == .OK {
                            self.selected_url = dialog.url!.path
                        }
                    }
                }) {
                    Text("Select Directory")
                }
            }
        }
    }
}

struct RAWExtension: View {
    @ObservedObject var filter_model: FilterModel
    
    var body: some View {
        Picker(selection: $filter_model.selected_raw_extension,
               label: Text("RAW Extension")) {
            ForEach(0 ..< filter_model.raw_extensions.count) {
                Text(self.filter_model.raw_extensions[$0])

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


