//
//  MyFullTableViewCell.swift
//  AllenVungleSwift
//
//  Created by allen.liu on 2021/11/29.
//

import UIKit

class MyFullTableViewCell: UITableViewCell {

    @IBOutlet weak var myFullVungleMeidaCell: VungleMediaView!
    
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myFulliconCell: UIImageView!
    @IBOutlet weak var myFullCellBody: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
