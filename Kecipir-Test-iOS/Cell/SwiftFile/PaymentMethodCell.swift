//
//  PaymentMethodCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class PaymentMethodCell: UITableViewCell {
    
    
    @IBOutlet weak var lblPayment: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnView.layer.cornerRadius = 16
        self.btnView.layer.borderWidth = 1
        self.btnView.layer.borderColor = UIColor.init(hex: 0x4CB245).cgColor
    }
    
}


