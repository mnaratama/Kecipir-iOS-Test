//
//  HeaderNameCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class HeaderNameCell: UITableViewCell {
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
