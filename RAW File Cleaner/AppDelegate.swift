//
//  AppDelegate.swift
//  RAW File Cleaner
//
//  Created by Yaryna Pochtarenko on 16/09/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//

import Cocoa
import SwiftUI
import Combine
//import "./CoreFunctional"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let content = NSHostingController(rootView: MainView())
        
        // Create the window and set the content view.
        window = NSWindow(contentViewController: content)
        window.center()
        window.title = ""
        window.styleMask.remove(.resizable)
        
        window.makeKeyAndOrderFront(nil)
        window.titlebarAppearsTransparent = true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        //print("terminate debug")
        //NSApplication.shared.terminate(self)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
    
}

class TestCall: ObservableObject {
    
    func hello(){
        print("hello")
    }
}

