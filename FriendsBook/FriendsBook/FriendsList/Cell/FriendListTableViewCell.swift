//
//  FriendListTableViewCell.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        personImageView.layer.cornerRadius = self.personImageView.frame.width / 2
        personImageView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }
    
    func configure(with user: Person?){
        nameLabel.text = user?.name
        numberLabel.text = user?.phone
        personImageView.image = UIImage(named: "avatar")
    }

}
