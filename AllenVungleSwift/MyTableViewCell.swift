//
//  MyTableViewCell.swift
//  AllenVungleSwift
//
//  Created by allen.liu on 2021/11/25.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myCellBody: UILabel!

    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myCellCTABtn: UIButton!
    @IBOutlet weak var myCellVungleView: VungleMediaView!
    @IBOutlet weak var myCellRate: UILabel!
    @IBOutlet weak var myCellSpon: UILabel!
    @IBOutlet weak var myCellTitle: UILabel!
    @IBOutlet weak var myCellIconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
