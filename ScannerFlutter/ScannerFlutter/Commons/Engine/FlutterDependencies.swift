//
//  FlutterDependencies.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import Foundation
import Flutter
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
    let flutterEngine = FlutterEngine(name: "scanner_flutter")
    init() {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run()
        // Connects plugins with iOS platform code to this app.
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
    }
}
