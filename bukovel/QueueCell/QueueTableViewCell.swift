//
//  QueueTableViewCell.swift
//  bukovel
//
//  Created by Денис Данилюк on 12.01.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class QueueTableViewCell: UITableViewCell {
    @IBOutlet weak var liftLabel: UILabel!
    @IBOutlet weak var liftImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        liftLabel.text = nil
        liftImage.image = UIImage()
    }
}
