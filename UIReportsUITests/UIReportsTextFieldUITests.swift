//
//  UIReportsUITests.swift
//  UIReportsUITests
//
//  Created by Paul Von Schrottky on 5/5/18.
//  Copyright © 2018 Schrottky. All rights reserved.
//

import XCTest

// Run UI tests from the command line:
//
// For Xcode 10, first point xcodebuild to Xcode 10 (e.g. `xcode-select -switch /Applications/Xcode-beta.app`), then:
//
//      xcodebuild -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone SE,OS=12.0' -scheme UIReports test
//
// Note that for Xcode 9, do:
//
//      xcodebuild -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=11.2' -scheme UIReports test
//
// Now, to only show UIReport output, combine stderr with stdout (i.e. `2>&1`), and grep for `@report`:
//
//      xcodebuild -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone SE,OS=12.0' -scheme UIReports test 2>&1 | grep @report
//
//
// Notes to self:
//      - Use `instruments -s devices` to see devices
//      - Use `xcodebuild -list` to see schemes
//      - The XCTestObservation protocol defines methods that are called in response to significant events in the progress of test runs.
//      - A log of tests are saved to: /Users/pvons/Library/Developer/Xcode/DerivedData/UIReports-agomuviluvgvnhenffucldjauhsh/Logs/Test/F1DD104D-B798-4FDE-8A8D-6813F688046A_TestSummaries.plist



class UIReportsTextFieldUITests: XCTestCase {
    
    let app = XCUIApplication()
    let TestChar = "x"
    
    
    
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

    
    // UITextField
    // 1. Assert that text field is visible when focused
    // 2. If keyboard type is:
    //      - default
    //      - asciiCapable
    //      - numbersAndPunctuation
    //      - URL
    //      - numberPad
    //      - phonePad
    //      - namePhonePad
    //      - emailAddress
    //      - decimalPad
    //      - twitter
    //      - webSearch
    //      - asciiCapableNumberPad
    // default
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

    func testExample() {
    

        for textField in app.textFields.allElementsBoundByIndex {
            guard textField.isHittable else { continue }
            
            textField.tap()
            guard let keyboardType = UIReports.currentKeyboardType() else { continue }
            startReportSectionWith(title: "Testing \(keyboardType.description)")
            canPasteIn(textField: textField)
        }
        print("DONE")
    }
    
    
    @discardableResult
    func canPasteIn(textField: XCUIElement) -> Bool {
        textField.clearAndEnterText(text: "")
        UIPasteboard.general.string = TestChar
        textField.doubleTap()
        app.menuItems["Paste"].tap()
        if textField.value as? String == TestChar {
            report("Allows pasting text.")
            return true
        } else {
            report("Fails pasting text.")
            return false
        }
//
//
//            textField.tap()
//
//            // Test pasting text.
//            textField.clearAndEnterText(text: "")
//            UIPasteboard.general.string = "x"
//            textField.doubleTap()
//            app.menuItems["Paste"].tap()
//            if textField.value as! String == "x" {
//                report("Allows pasting text.")
//            } else {
//                report("Fails pasting text.")
//            }
//
//            // Test max length.
//            textField.clearAndEnterText(text: "")
//            let total = 10
//            var contents = ""
//            for i in 0 ..< total {
//                let text = "x"
//                textField.typeText(text)
//                contents.append(text)
//
//                if textField.value as! String != contents {
//                    report("Failed entering text at \(i + 1)th character.")
//                    break
//                }
//            }
//            if contents.count == total {
//                report("Passed text entering with \(total) characters entered.")
//            }
//
//
//
//
//        }
    }
    
}
