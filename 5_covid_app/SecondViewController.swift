//
//  SecondViewController.swift
//  5_covid_app
//
//  Created by David Granado Jordan on 6/9/22.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let margins = view.layoutMarginsGuide

        let button = UIButton()
        
        view.addSubview(button)

        button.setTitle("TEST", for: [])
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3

        button.translatesAutoresizingMaskIntoConstraints = false

        //button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        //button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        //button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
    
    
    }
    


}
