//
//  UIReportsUtils.swift
//  UIReportsUITests
//
//  Created by Paul Von Schrottky on 5/6/18.
//  Copyright © 2018 Schrottky. All rights reserved.
//

import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     See: https://stackoverflow.com/a/32894080/1305067
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}

extension UIKeyboardType {
    var description: String {
        switch self {
        case .default:
            return "Default Keyboard"
        case .asciiCapable:
            return "ASCII Capable Keyboard"
        case .numbersAndPunctuation:
            return "Numbers and Punctuation Keyboard"
        case .URL:
            return "URL Keyboard"
        case .numberPad:
            return "Number Pad Keyboard"
        case .phonePad:
            return "Phone Pad Keyboard"
        case .namePhonePad:
            return "Name Phone Pad Keyboard"
        case .emailAddress:
            return "Email Address Keyboard"
        case .decimalPad:
            return "Decimal Pad Keyboard"
        case .twitter:
            return "Twitter Keyboard"
        case .webSearch:
            return "Web Search Keyboard"
        case .asciiCapableNumberPad:
            return "ASCII Capable Number Pad Keyboard"
        }
    }
}

class UIReports {
    static func currentKeyboardType() -> UIKeyboardType? {
        let app = XCUIApplication()
        let keys = app.keyboards.keys
        if keys["delete"].exists && keys["more, numbers"].exists && keys["space"].exists && app.keyboards.buttons["Next keyboard"].exists {
            return .default
        } else if keys["delete"].exists && keys["more, numbers"].exists && keys["space"].exists && keys["@"].exists == false && keys["#"].exists == false {
            return .asciiCapable
        }
        // Check for a number, a punctuation, and
        else if keys["1"].exists && keys[";"].exists && keys["@"].exists && keys["ampersand"].exists {
            return .numbersAndPunctuation
        }
        // The URL keyboard is the only one that contains a `.com` key.
        else if keys[".com"].exists {
            return .URL
        }
        // The `+*#` (a.k.a. Shift) button should NOT exist.
        else if keys["0"].exists && keys["Delete"].exists && keys["Shift"].exists == false {
            return .numberPad
        }
        // The `+*#` (a.k.a. Shift) button SHOULD exist.
        else if keys["0"].exists && keys["Delete"].exists && keys["Shift"].exists {
            return .phonePad
        } else if keys["more, phone pad"].exists {
            return .namePhonePad
        } else if keys["more, numbers"].exists && keys["@"].exists {
            return .emailAddress
        }
        // Check for a number, a decimal point, and the delete key.
        else if keys["0"].exists && keys["."].exists && keys["Delete"].exists {
            return .decimalPad
        }
        else if keys["#"].exists {
            return .twitter
        }
        // TODO: What's the difference between `.asciiCapableNumberPad` and `.numberPad`?
        else if keys["0"].exists && keys["Delete"].exists && keys["Shift"].exists == false {
            return .asciiCapableNumberPad
        }
        return nil
    }
}
