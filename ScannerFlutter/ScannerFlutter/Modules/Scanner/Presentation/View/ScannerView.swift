//
//  ScannerView.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import SwiftUI
import Flutter

struct ScannerView: UIViewControllerRepresentable {
  // Flutter dependencies are passed in through the view environment.
  @Environment(FlutterDependencies.self) var flutterDependencies
  
  func makeUIViewController(context: Context) -> some UIViewController {
   let flutterViewController = FlutterViewController(
      engine: flutterDependencies.flutterEngine,
      nibName: nil,
      bundle: nil)
    
    // Configurar el FlutterMethodChannel
    let channel = FlutterMethodChannel(name: "com.example.scanner_flutter/native_scanner_bridge",
                                       binaryMessenger: flutterViewController.binaryMessenger)
    
    channel.setMethodCallHandler { (call, result) in
      if call.method == "receiveMessage" {
        let message = call.arguments as? String
        print("Mensaje recibido desde Flutter: \(message ?? "")")
        result("Respuesta desde iOS en ScannerView")
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    return flutterViewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
