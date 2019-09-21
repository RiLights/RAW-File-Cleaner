//
//  AppDelegate.swift
//  RAW File Cleaner
//
//  Created by Yaryna Pochtarenko on 16/09/19.
//  Copyright © 2019 Ostap Pochtarenko. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let visualEffect = NSVisualEffectView()
        visualEffect.blendingMode = .behindWindow
        visualEffect.state = .active
        visualEffect.material = .light
        
        //print("1debug")
        // Create the SwiftUI view that provides the window contents.
        //var contentView = ContentView()
        let content = NSHostingController(rootView: MainView())
        
        // Create the window and set the content view.
        window = NSWindow(contentViewController: content)
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
        window.center()
        window.title = ""
        window.styleMask.remove(.resizable)
        //window.appearance = NSVisualEffectView()//NSAppearance(named: .aqua)
        //window.setFrameAutosaveName("Main Window")
        //window.contentView = NSHostingView(rootView: contentView)

        //window?.contentView = visualEffect
        //var hh = NSHostingView(rootView: contentView)
        //hh.allowsVibrancy = true
        //window.appearance = NSAppearance(named: .vibrantLight)
        //window.contentView = NSHostingController(rootView: ContentView())
        //window.contentView = visualEffect
        //window.backgroundColor = .systemBlue
        //window.appearance = NSAppearance(named: .aqua)
        //window.contentView?.addSubview(visualEffect)
        window.makeKeyAndOrderFront(nil)
        window.titlebarAppearsTransparent = true
        //window.handleClose(<#T##command: NSCloseCommand##NSCloseCommand#>)
        //NSCloseCommand(test)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("terminate debug")
        //NSApplication.shared.terminate(self)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
    

}

