//
//  ContentView.swift
//  RAW File Cleaner
//
//  Created by Yaryna Pochtarenko on 16/09/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
import SwiftUI

struct MainView: View {
    @State private var name: String = ""
    @State private var showingAlert = false
    @State private var schmelzpunkt = 0
    @State var showModalView = false
    @State var selectedURL: URL?
    
    var alert: Alert {
        Alert(title: Text("iOScreator"), message: Text("Hello SwiftUI"), dismissButton: .default(Text("Dismiss")))
    }

    var body: some View {
        Section{
            VStack{
                    VStack {
                        Button(action: {
                            let dialog = NSOpenPanel()
                            dialog.title                   = "Choose a directory";
                            dialog.showsResizeIndicator    = true;
                            dialog.showsHiddenFiles        = false;
                            dialog.canChooseDirectories    = true;
                            dialog.canCreateDirectories    = false;
                            dialog.allowsMultipleSelection = false;
                            //dialog.allowedFileTypes        = ["txt"];
                            dialog.canChooseFiles = false;
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                let result = dialog.runModal()
                                if result == .OK {
                                    self.selectedURL = dialog.url
                                    self.name = dialog.url!.absoluteString
                                }
                            }
                        }) {
                            Text("Select file")
                        }
                    }
                
//                Text("""
//                    Filter RAW files based on present jpg files in the same directory.
//                    Spare RAW files will be removed.
//                    """).foregroundColor(.secondary).fontWeight(.thin)
                HStack{
                    TextField("Directory", text: $name)
                    Button(action: {
                        print("debug button")
                        self.showModalView.toggle()
                    }) {
                        Text("Select Directory")
                    }
                    .sheet(isPresented: $showModalView, content: { ModalView() })
//                    .popover(
//                        isPresented: $showModalView,
//                        arrowEdge: .bottom
//                    ) { Text("Popover") }
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
                Picker(selection: $schmelzpunkt, label: Text("RAW Extension")) {
                    Text("CR2").tag(0)
                    Text("CR3").tag(2)
                    Text("NEF").tag(3)
                    Text("NRW").tag(4)
                    Text("DNG").tag(5)
                    Text("GPR").tag(6)
                    Text("RAW").tag(7)
                    Text("RAF").tag(8)
                    Text("ORF").tag(9)
                }.frame(width:195)
                
            
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {self.showingAlert = true}) {
                        Text("Apply")
                    }
                    .padding()
                    .alert(isPresented: $showingAlert, content: { self.alert })
                }
            }
        }.frame(width: 400, height: 200)
            //.background(Color(.sRGB, white: 0.1, opacity: 1))
            //.background(Color.red)
            //.blendMode(.difference)
            //.blur(radius: 0.5, opaque: false)
            
            //.foregroundColor(.secondary)
    }
    func totalClicked(){
        print("TEST BUTTON")
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            Text("Hello World")
            Button("Dismiss") {
                self.presentation.wrappedValue.dismiss()
            }
        }.frame(width: 300, height: 100)
    }
}
struct ModalView2: View {
    @Environment(\.presentationMode) var presentation
    let message: String

    var body: some View {
        VStack {
            Text(message)
            Button("Dismiss") {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
