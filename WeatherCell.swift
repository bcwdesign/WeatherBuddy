//
//  WeatherCell.swift
//  WeatherBuddy
//
//  Created by bluecryjoe on 10/5/16.
//  Copyright © 2016 bluecryjoe. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

   // @IBOutlet var imageName: UIImageView!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var dayOfWeek: UILabel!
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var weatherLow: UILabel!
    @IBOutlet var weatherHigh: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
