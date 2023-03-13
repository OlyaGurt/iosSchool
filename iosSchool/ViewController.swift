//
//  ViewController.swift
//  iosSchool
//
//  Created by Ольга Гуртуева on 13.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newGen = ColorGenerator(alpha: 1)
        newGen.alpha = 0.5
        var color = Color(red: 1, green: 1, blue: 1, alpha: .bright)
        color.description()
        // Do any additional setup after loading the view.
    }


}

