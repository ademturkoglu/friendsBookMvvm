//
//  FriendDetailViewController.swift
//  FriendsBook
//
//  Created by adem.turkoglu on 6.06.2021.
//

import UIKit
import Foundation
import SafariServices

class FriendDetailViewController: UIViewController {
    @IBOutlet weak var downCallButton: LoginButton!
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.masksToBounds = true
            avatarImage.layer.borderWidth = 2
            avatarImage.layer.borderColor = UIColor.marineBlue.cgColor
        }
    }
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet {
            usernameLabel.text = model.username
        }
    }
    @IBOutlet weak var phoneLabel: UILabel! {
        didSet {
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
            let recognizerEmail = UITapGestureRecognizer(target: self, action: #selector(emailActionForLabel))
            emailStack.addGestureRecognizer(recognizerEmail)
        }
    }
    @IBOutlet weak var websiteLabel: UILabel! {
        didSet {
            websiteLabel.text = model.website
        }
    }
    @IBOutlet weak var websiteStackView: UIStackView! {
        didSet {
            let recognizerWebsite = UITapGestureRecognizer(target: self, action: #selector(websiteAction))
            websiteStackView.addGestureRecognizer(recognizerWebsite)
        }
    }
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
                guard let zipCode = adress.zipcode else { return }
                adressLabel.text! += zipCode
            }
        }
    }
    @IBOutlet weak var adressStackView: UIStackView! {
        didSet {
            let recognizerAddress = UITapGestureRecognizer(target: self, action: #selector(addressAction))
            adressStackView.addGestureRecognizer(recognizerAddress)
        }
    }
    var model: Person!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(downCallButton)
        // Do any additional setup after loading the view.
    }
    @objc func emailActionForLabel() {
        if let urlMail = URL(string: "mailto:\(emailLabel.text!)") {
            UIApplication.shared.open(urlMail)
        }
    }
    @objc func copyAction() {
        UIPasteboard.general.string = phoneLabel.text
        let succesAlert = UIAlertController(title: "Copied",
                                            message: nil, preferredStyle: UIAlertController.Style.alert)
        self.present(succesAlert, animated: true, completion: nil)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
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
    @IBAction func downCallButtonTapped(_ sender: Any) {
        model.phone?.makeACall()
    }
    @objc func addressAction() {
        routeToMapView(model: model)
    }
    @objc func websiteAction() {
        if let urlWeb = URL(string: "https://" + model.website!) {
            let safariVC = SFSafariViewController(url: urlWeb)
            present(safariVC, animated: true, completion: nil)
        }
    }
    func routeToMapView(model: Person) {
        let storyboard = UIStoryboard(name: "FriendDetail", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(
            withIdentifier: "FriendLocationViewController") as? FriendLocationViewController {
            destinationVC.person = model
            self.show(destinationVC, sender: nil)
        }
    }
}
