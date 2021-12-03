//
//  ShippingAddressCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class ShippingAddressCell: UITableViewCell {
    
    @IBOutlet weak var addressHeaderLbl: UILabel!
    @IBOutlet weak var addressBodyLbl: UILabel!
    @IBOutlet weak var addressPriceLbl: UILabel!
    @IBOutlet weak var settingImg: UIImageView!
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

