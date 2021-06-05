//
//  ViewController.swift
//  FriendsBook
//
//  Created by Adem Türkoğlu on 4.06.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.isHidden = true
        }
    }
    @IBOutlet weak var loginButton: LoginButton!
    @IBOutlet weak var formView: UIView! {
        didSet {
            formView.layer.shadowColor = UIColor.black.cgColor
            formView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            formView.layer.shadowOpacity = 0.2
            formView.layer.shadowRadius = 17
        }
    }
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameFieldView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordFieldView: UIView!
    @IBOutlet weak var hideButton: UIButton!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = UIColor.white
        hideKeyboard()
        setupViewModel()

        // Do any additional setup after loading the view.
    }
    
    private func setupViewModel() {
        viewModel.changeHandler = { [unowned self] change in
            self.viewModelStateChanged(change: change)
        }
    }
    
    @IBAction func hideButtonAction(_ sender: Any) {
        if(passwordTextField.isSecureTextEntry == true){
                   passwordTextField.isSecureTextEntry = false
                   hideButton.setTitle("hide", for: UIControl.State.normal)
                   
               }else{
                   passwordTextField.isSecureTextEntry = true
                   hideButton.setTitle("show", for: UIControl.State.normal)
               }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        viewModel.login(userName: userNameTextField.text, password: passwordTextField.text)
    }
    func hideKeyboard(){
        let tab:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tab)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == userNameTextField)
        {
            userNameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
            viewModel.login(userName: userNameTextField.text, password: passwordTextField.text)
            
        }
        return true
    }
    
    func showError(){
        self.userNameFieldView.backgroundColor = UIColor.scarlet
        self.passwordFieldView.backgroundColor = UIColor.scarlet
        self.loginButton.isUserInteractionEnabled = true
        self.errorLabel.textColor = UIColor.scarlet
        self.errorLabel.isHidden = false
    }

}

extension LoginViewController: UITextFieldDelegate {
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userNameTextField {
            userNameFieldView.backgroundColor = UIColor.marineBlue
        }
        if textField == passwordTextField {
            passwordFieldView.backgroundColor = UIColor.marineBlue
            errorLabel.isHidden = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userNameTextField {
            userNameFieldView.backgroundColor = UIColor.whiteTextField
        }
        if textField == passwordTextField {
            passwordFieldView.backgroundColor = UIColor.whiteTextField
        }
    }
    
}

extension LoginViewController {
 
    
    func routeToFriendsList() {
       // let storyboard = UIStoryboard(name: "TaskDetail", bundle: nil)
        //if let destinationVC = storyboard.instantiateViewController(withIdentifier: "TaskDetailViewController") as? TaskDetailViewController {
          //  destinationVC.model = model
         //   self.show(destinationVC, sender: nil)
     //   }
    }
    

    private func viewModelStateChanged(change: LoginViewState.Change){
        switch change {
        case let .fetchState(_): break
              //  fetching ? showIndicator() : hideIndicator()
        case let .loginError(error: error):
            print(error ?? "error")
            showError()
        case let .loginSucces: break
            // Route to list
        }
    }
}
