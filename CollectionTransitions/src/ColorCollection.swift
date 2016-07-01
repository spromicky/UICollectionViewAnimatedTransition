//
//  ColorCollection.swift
//  CollectionTransitions
//
//  Created by Nick on 30/6/16.
//  Copyright © 2016 spromicky. All rights reserved.
//

import Foundation
import UIKit


struct ColorCollection {
    
    let name: String
    let colors: [UIColor]
    
    static let sharedCollection = ColorCollection.generate(20)
    static private var iteration = 0
    static private let colorArray = [UIColor(red: 0.866667, green: 0.572549, blue: 0.372549, alpha: 1),
                                     UIColor(red: 0.868731, green: 0.575814, blue: 0.373674, alpha: 1),
                                     UIColor(red: 0.589928, green: 0.594322, blue: 0.589154, alpha: 1),
                                     UIColor(red: 0.589928, green: 0.594322, blue: 0.589154, alpha: 1),
                                     UIColor(red: 0.696639, green: 0.58008, blue: 0.734811, alpha: 1),
                                     UIColor(red: 0.939447, green: 0.774972, blue: 0.455114, alpha: 1),
                                     UIColor(red: 0.431373, green: 0.560784, blue: 0.686275, alpha: 1),
                                     UIColor(red: 0.768627, green: 0.784314, blue: 0.776471, alpha: 1),
                                     UIColor(red: 0.770437, green: 0.783913, blue: 0.778299, alpha: 1),
                                     UIColor(red: 0.937255, green: 0.772549, blue: 0.454902, alpha: 1),
                                     UIColor(red: 0.505882, green: 0.631373, blue: 0.745098, alpha: 1),
                                     UIColor(red: 0.481865, green: 0.696398, blue: 0.659912, alpha: 1),
                                     UIColor(red: 0.550924, green: 0.745364, blue: 0.717924, alpha: 1),
                                     UIColor(red: 0.801655, green: 0.399344, blue: 0.401992, alpha: 1),
                                     UIColor(red: 0.833061, green: 0.501808, blue: 0.301806, alpha: 1),
                                     UIColor(red: 0.564706, green: 0.819608, blue: 0.466667, alpha: 1),
                                     UIColor(red: 0.801655, green: 0.399344, blue: 0.401992, alpha: 1),
                                     UIColor(red: 0.696639, green: 0.58008, blue: 0.734811, alpha: 1),
                                     UIColor(red: 0.868731, green: 0.575814, blue: 0.373674, alpha: 1),
                                     UIColor(red: 0.770437, green: 0.783913, blue: 0.778299, alpha: 1),
                                     UIColor(red: 0.801655, green: 0.399344, blue: 0.401992, alpha: 1),
                                     UIColor(red: 0.708155, green: 0.741288, blue: 0.405974, alpha: 1),
                                     UIColor(red: 0.506524, green: 0.633807, blue: 0.747343, alpha: 1)]
    
    static func generate(count: Int = 1) -> [ColorCollection] {
        
        let slice = 0..<count
        return slice.map { _ in
            iteration += 1
            
            let colors = (0..<4).map { _ in colorArray[Int(arc4random() % 23)] }
            
            return ColorCollection(name: "#\(iteration)", colors: colors)
        }
    }
}
