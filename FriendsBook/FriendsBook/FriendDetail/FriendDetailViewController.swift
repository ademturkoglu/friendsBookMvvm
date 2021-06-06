//
//  FriendDetailViewController.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import UIKit
import Foundation

class FriendDetailViewController: UIViewController {
    
    @IBOutlet weak var downCallButton: LoginButton!
    @IBOutlet weak var avatarImage: UIImageView!{
        didSet {
            avatarImage.layer.masksToBounds = true
            avatarImage.layer.borderWidth = 2
            avatarImage.layer.borderColor = UIColor.marineBlue.cgColor
        
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!{
        didSet{
            usernameLabel.text = model.username
        }
    }
    @IBOutlet weak var phoneLabel: UILabel! {
        didSet{
            phoneLabel.text = model.phone
        }
    }
    @IBOutlet weak var phoneStackView: UIStackView! {
        didSet {
            let gestureRecognizerPhone = UITapGestureRecognizer(target: self, action: #selector(copyAction))
            phoneStackView.addGestureRecognizer(gestureRecognizerPhone)
        }
       
    }
    @IBOutlet weak var nameSurnameLabel: UILabel! {
        didSet {
            nameSurnameLabel.text = model.name
        }
    }
    @IBOutlet weak var emailLabel: UILabel! {
        didSet {
            emailLabel.text = model.email
        }
    }
    @IBOutlet weak var emailStack: UIStackView! {
        didSet {
            let gestureRecognizerEmail = UITapGestureRecognizer(target: self, action: #selector(emailActionForLabel))
            emailStack.addGestureRecognizer(gestureRecognizerEmail)
        }
       
    }
    @IBOutlet weak var websiteLabel: UILabel! {
        didSet {
            websiteLabel.text = model.website
        }
    }
    @IBOutlet weak var websiteStackView: UIStackView!
    @IBOutlet weak var companyNameLabel: UILabel! {
        didSet {
            companyNameLabel.text = model.company?.name
        }
    }
    @IBOutlet weak var adressLabel: UILabel! {
        didSet {
            if let adress = model.address {
                guard let street = adress.street else { return }
                adressLabel.text = street + " "
                guard let suite = adress.suite else { return }
                adressLabel.text! += suite + " "
                guard let city = adress.city else { return }
                adressLabel.text! += city + " "
                guard let zip = adress.zipcode else { return }
                adressLabel.text! += zip
            }
         
        }
    }
    @IBOutlet weak var adressStackView: UIStackView!
    var model: Person!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(downCallButton)
        // Do any additional setup after loading the view.
    }
    
    @objc func emailActionForLabel(){
        if let url = URL(string: "mailto:\(emailLabel.text!)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func copyAction(){
        UIPasteboard.general.string = phoneLabel.text
        let succesAlert = UIAlertController(title: "Copied", message: nil, preferredStyle: UIAlertController.Style.alert)
        self.present(succesAlert, animated: true, completion: nil)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            succesAlert.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func upCallButtonTapped(_ sender: Any) {
        model.phone?.makeACall()
    }
    
    @IBAction func messageButtonTapped(_ sender: Any) {
        model.phone?.makeAMessage()
    }
    
}
