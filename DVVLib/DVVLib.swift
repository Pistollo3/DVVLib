//
//  DVVLib.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 02/11/21.
//

import Foundation

public class DVVLib {
    
    public static let shared = DVVLib()
    public static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    private static func sub(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
    
    public static func doLogin() {
        
    }
}
