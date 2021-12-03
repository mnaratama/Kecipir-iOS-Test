//
//  CouponCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class CouponCell: UITableViewCell {
    
    @IBOutlet weak var settingLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet var changeLbl: UILabel!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var settingImg: UIImageView!
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var imgView: UIView!
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

