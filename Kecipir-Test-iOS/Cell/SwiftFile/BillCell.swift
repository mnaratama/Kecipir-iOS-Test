//
//  BillCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class BillCell: UITableViewCell {
    
    @IBOutlet weak var totPriceLbl: UILabel!
    @IBOutlet weak var totPriceValueLbl: UILabel!
    @IBOutlet weak var discLbl: UILabel!
    @IBOutlet weak var discValueLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var deliveryValueLbl: UILabel!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var packageValueLbl: UILabel!
    @IBOutlet weak var totBillLbl: UILabel!
    @IBOutlet weak var totBillValueLbl: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
