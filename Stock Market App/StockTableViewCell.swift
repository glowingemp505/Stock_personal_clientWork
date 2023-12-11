//
//  StockTableViewCell.swift
//  Stock Market App
//
//  Created by Truepicks on 12/10/23.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    @IBAction func tapAdd(_ sender: Any) {
        
        
    }
    @IBOutlet weak var changepriceButton: UIButton!
    @IBOutlet weak var currentpriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tickerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
