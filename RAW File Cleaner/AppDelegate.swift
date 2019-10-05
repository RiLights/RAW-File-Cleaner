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

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
    
    func dialogOKCancel(question: String, text: String) {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        if alert.runModal() == .alertFirstButtonReturn{
            return
        }
    }
    @IBAction func help(_ sender: Any) {
        print("help")
        dialogOKCancel(question: "Help",text: """
            Filtering RAW files based on present jpg files
            in the same directory.

            Spare RAW files will be in recycle bin.
""")
    }
}
