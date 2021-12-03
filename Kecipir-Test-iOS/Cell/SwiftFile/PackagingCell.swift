//
//  PackagingCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class PackagingCell: UITableViewCell {
    
    @IBOutlet weak var packagingHeaderLbl: UILabel!
    @IBOutlet weak var packagingBodyLbl: UILabel!
    @IBOutlet weak var btnLbl: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnView.layer.cornerRadius = 10
    }
    
}
