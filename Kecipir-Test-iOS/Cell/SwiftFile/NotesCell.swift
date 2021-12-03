//
//  NotesCell.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

class NotesCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var viewRadius: UIView!
    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewRadius.layer.cornerRadius = 8
        
        textView.text = "Contoh: Besok saya tidak dirumah, gerbang tidak di kunci"
        textView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Contoh: Besok saya tidak dirumah, gerbang tidak di kunci"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
