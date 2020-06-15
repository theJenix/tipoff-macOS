//
//  AppDelegate.swift
//  reminderSB
//
//  Created by Jesse Rosalia on 6/15/20.
//  Copyright © 2020 Jesse Rosalia. All rights reserved.
//

import Cocoa


// based on https://www.raywenderlich.com/450-menus-and-popovers-in-menu-bar-apps-for-macos and
// https://stackoverflow.com/questions/28362472/is-there-a-simple-input-box-in-cocoa
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    static let noTaskString = "No task set"
    static let leftPadding = "      "
    static let rightPadding = "        "
    var currentTask = noTaskString
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            //button.title = "Testing"
          //button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(updateTask(_:))
            updateButtonTitle(button, currentTask)
        }
        //constructMenu()

    }
    
    @objc func updateTask(_ sender: Any?) {
        if let button = statusItem.button {
            let msg = getString(title: "Update task", question: "What are you working on?", defaultValue: currentTask == AppDelegate.noTaskString ? "" : currentTask)
            currentTask = msg == "" ? AppDelegate.noTaskString : msg
            updateButtonTitle(button, currentTask)
        }
    }
    
    func updateButtonTitle(_ button:NSButton, _ taskName:String) {
        
        button.title = "Currently working on:" + AppDelegate.leftPadding + taskName + AppDelegate.rightPadding
        
    }
    func getString(title: String, question: String, defaultValue: String) -> String {
        let msg = NSAlert()
        msg.addButton(withTitle: "OK")      // 1st button
        msg.addButton(withTitle: "Cancel")  // 2nd button
        msg.messageText = title
        msg.informativeText = question

        let txt = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        txt.stringValue = defaultValue

        msg.accessoryView = txt

        DispatchQueue.main.async() {
            txt.becomeFirstResponder()
        }

        let response: NSApplication.ModalResponse = msg.runModal()

        if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
            return txt.stringValue
        } else {
            return ""
        }
    }
    func constructMenu() {
      let menu = NSMenu()

      //menu.addItem(NSMenuItem(title: "Print Quote", action: //#selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
      menu.addItem(NSMenuItem.separator())
      menu.addItem(NSMenuItem(title: "Quit reminderSB", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
         
      statusItem.menu = menu
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

