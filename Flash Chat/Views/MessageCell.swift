//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 19.04.2024.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var leftBubbleConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBubbleConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightTimeConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftTimeConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
