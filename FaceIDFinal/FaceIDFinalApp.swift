//
//  FaceIDFinalApp.swift
//  FaceIDFinal
//
//  Created by Qiwei on 11/30/22.
//

import SwiftUI

@main
struct FaceIDFinalApp: App {
    @StateObject var appInfo = ChickenData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appInfo)
        }
    }
}
