//
//  UIReportsUITests.swift
//  UIReportsUITests
//
//  Created by Paul Von Schrottky on 5/5/18.
//  Copyright © 2018 Schrottky. All rights reserved.
//

import XCTest

// A log of test are saved to:
// /Users/pvons/Library/Developer/Xcode/DerivedData/UIReports-agomuviluvgvnhenffucldjauhsh/Logs/Test/F1DD104D-B798-4FDE-8A8D-6813F688046A_TestSummaries.plist

// Run UI tests from the command line:
// xcodebuild -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=11.2' -scheme UIReports test
// Note use `instruments -s devices` to see devices, and `xcodebuild -list` to see schemes

// Note to self: The XCTestObservation protocol defines methods that are called in response to significant events in the progress of test runs.

// UITextField
// - Is visible when in focus
// - Is (int, decimal, alphabetic, alphanumeric)
//   int:
//      - type, erase
//      - max, min
//      - Allows selecting text, copying text, pasting text
//      - Disallows pasting non-int values
//      - Supports `autocorrectionType` (i.e. suggestions / autocomplete / QuickType)?
//   decimal:
//      - max, min
//      - max and min fractional part

// - Can type n characters into field
// -


// Used to print to the xcodebuild output.
// See: https://stackoverflow.com/a/37251423/1305067
public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}

public var logStream = StderrOutputStream()

func report(_ items: Any...) {
    print(items, separator: "", terminator: " -- UIReport\n")
}

class UIReportsTextFieldUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        for textField in app.textFields.allElementsBoundByIndex {
            textField.tap()
            let total = 10
            var contents = ""
            for i in 0 ..< total {
                let text = "x"
                textField.typeText(text)
                contents.append(text)
                
                if textField.value as! String != contents {
                    report("Failed entering text at \(i + 1)th character.")
                    break
                }
            }
            if contents.count == total {
                report("Passed text entering with \(total) characters entered.")
            }
            
            
        }
    }
    
}
