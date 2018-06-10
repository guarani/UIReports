//
//  UIReportLogger.swift
//  UIReportsUITests
//
//  Created by Paul Von Schrottky on 6/9/18.
//  Copyright © 2018 Schrottky. All rights reserved.
//

import UIKit

// Used to print to the xcodebuild output (which is `stderr`).
// See: https://stackoverflow.com/a/37251423/1305067
public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}

public var logStream = StderrOutputStream()

func report(_ items: Any...) {
    print(items, separator: "", terminator: " @report\n")
}

func startReportSectionWith(title: String, _ items: Any...) {
    var _items = items
    _items.insert("Start `\(title)`", at: 0)
    report(_items)
}
