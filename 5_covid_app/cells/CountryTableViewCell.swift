//
//  CountryTableViewCell.swift
//  5_covid_app
//
//  Created by David Granado Jordan on 6/8/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryImageView: UIImageView!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var countryDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
