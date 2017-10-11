//
//  CarCell.swift
//  CodingTaskApp
//
//  Created by Aleksandr Afanasiev on 11.10.17.
//  Copyright © 2017 Aleksandr Afanasiev. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carDescription: UILabel!
    @IBOutlet weak var other: UILabel!
    @IBOutlet weak var carColor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
