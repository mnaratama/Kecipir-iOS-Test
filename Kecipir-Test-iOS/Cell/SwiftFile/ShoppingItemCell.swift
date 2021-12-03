//
//  ShoppingItemCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class ShoppingItemCell: UITableViewCell {
    
    @IBOutlet weak var productItem: UIImageView!
    @IBOutlet weak var discView: UIView!
    @IBOutlet weak var discLbl: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemStock: UILabel!
    @IBOutlet weak var itemFarm: UILabel!
    @IBOutlet weak var stockView: UIView!
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.deleteView.setShadow()
        self.stockView.layer.cornerRadius = 10
        self.stockView.layer.borderWidth = 1
        self.stockView.layer.borderColor = UIColor.init(hex: 0xFF0802).cgColor
    }
    
}
