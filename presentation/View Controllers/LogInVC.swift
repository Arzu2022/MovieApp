//
//  LogInVC.swift
//  presentation
//
//  Created by AziK's  MAC on 19.09.22.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import Alamofire
import SwiftUI
public class LogInVC:BaseViewController<MovieViewModel> {
    let auth = FirebaseAuth.Auth.auth()
    private lazy var showPassword:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(systemName: "eye"), for: .normal)
        btn.addTarget(self, action: #selector(onClickShowPassword), for: .touchUpInside)
        return btn
    }()
    private lazy var showRepassword:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "eye"), for: .normal)
        btn.addTarget(self, action: #selector(onClickShowRepassword), for: .touchUpInside)
        return btn
    }()
    private lazy var loginText:UILabel = {
        let text = UILabel()
        text.text = "Login Page"
        text.textColor = .blue
        text.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return text
    }()
    private lazy var signUpText:UILabel = {
        let text = UILabel()
        text.text = "SignUp Page"
        text.textColor = .blue
        text.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        return text
    }()
    private lazy var login:UIButton = {
        let text = UIButton()
        text.backgroundColor = .gray
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 12
        text.isEnabled = false
        text.setTitle("Login", for: .normal)
        text.setTitleColor(UIColor.white, for: .normal)
        text.addTarget(self, action: #selector(onClickLogin), for: .touchUpInside)
        return text
    }()
    private lazy var register:UIButton = {
        let text = UIButton()
        text.backgroundColor = .gray
        text.isEnabled = false
        text.setTitle("Sign Up", for: .normal)
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 12
        text.setTitleColor(UIColor.white, for: .normal)
        text.addTarget(self, action: #selector(onClickSignup), for: .touchUpInside)
        return text
    }()
    @objc func onClickSignup() {
        if repassword.text != password.text {
            self.showToast(message: "Passwords are not same!", seconds: 2.2)
        }
        else {
            auth.createUser(withEmail: email.text!, password: password.text!) { result, error in
                if error == nil {
                    let changeRequest = self.auth.currentUser?.createProfileChangeRequest()
                    changeRequest!.displayName = self.username.text
                    changeRequest?.commitChanges()
                    self.auth.currentUser?.sendEmailVerification(completion: { error in
                        if let error = error {
                            self.makeAlert(title: "Error", message: error.localizedDescription)
                        }
                        else {
                            self.auth.currentUser?.reload(completion: { error in
                                if error == nil {
                                    if ((self.auth.currentUser?.isEmailVerified) != nil) {
                                        let tabbar:UITabBarController = self.router.tabbarController()
                                        self.navigationController?.pushViewController(tabbar, animated: true)
                                    } else {
                                        self.showToast(message: "Please, verify email.", seconds: 1.5)
                                    }
                                }
                                else {
                                    self.makeAlert(title: "Error", message: error!.localizedDescription)
                                }
                            })
                        }
                    })
                }
                else {
                    self.makeAlert(title: "Error!", message: error!.localizedDescription)
                }
            }
        }
    }
    @objc func onClickLogin() {
        auth.signIn(withEmail: email.text!, password: password.text!) { [weak self] result, error in
            guard let strongSelf = self else { return}
            if error != nil {
                strongSelf.showToast(message: error!.localizedDescription, seconds: 2.2)
                
            }
            else {
                strongSelf.auth.currentUser?.reload(completion: { error in
                    if error == nil {
                        if ((strongSelf.auth.currentUser?.isEmailVerified) != nil) {
                            let tabbar:UITabBarController = strongSelf.router.tabbarController()
                                   strongSelf.navigationController?.pushViewController(tabbar, animated: true)
                                }
                            }
                            else {
                                strongSelf.makeAlert(title: "Error", message: error!.localizedDescription)
                            }
                        })
            }
        }
    }
    private lazy var createAccount:UIButton = {
        let text = UIButton()
        text.setTitle("Create Account", for: .normal)
        text.setTitleColor(UIColor.blue, for: .normal)
        text.addTarget(self, action: #selector(goSignUp), for: .touchUpInside)
        return text
    }()
    private lazy var forgotPassword:UIButton = {
        let text = UIButton()
        text.setTitle("Forget password", for: .normal)
        text.setTitleColor(UIColor.blue, for: .normal)
        text.addTarget(self, action: #selector(onClickForgetPass), for: .touchUpInside)
        return text
    }()
    @objc func onClickForgetPass(){
        auth.sendPasswordReset(withEmail: email.text!) { error in
            if let error = error {
                self.makeAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    private lazy var backLogin:UIButton = {
        let text = UIButton()
        text.setTitle("Back Login", for: .normal)
        text.setTitleColor(UIColor.blue, for: .normal)
        text.addTarget(self, action: #selector(backLoginFunc), for: .touchUpInside)
        return text
    }()
    private lazy var username:UITextField = {
    let text = UITextField()
    text.placeholder = "Enter username"
    text.layer.borderWidth = 1
    text.layer.masksToBounds = true
    text.layer.cornerRadius = 8
    text.textColor = .black
    text.autocapitalizationType = .none
    text.autocorrectionType = .no
    text.layer.borderColor = UIColor.gray.cgColor
    text.textAlignment = .left
    text.addPaddingToTextField()
    text.font = UIFont(font: FontFamily.PTSans.regular, size: 17)
    return text
}()
    private lazy var email:UITextField = {
        let text = UITextField()
        text.placeholder = "Enter email"
        text.layer.borderWidth = 1
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 8
        text.textColor = .black
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.layer.borderColor = UIColor.gray.cgColor
        text.textAlignment = .left
        text.addPaddingToTextField()
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 17)
        return text
    }()
    private lazy var password:UITextField = {
        let text = UITextField()
        text.placeholder = "Enter password"
        text.layer.borderWidth = 1
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 8
        text.isSecureTextEntry = true
//        text.isSecureTextEntry.toggle()
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.textColor = .black
        text.layer.borderColor = UIColor.gray.cgColor
        text.textAlignment = .left
        text.addPaddingToTextField()
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 17)
        return text
    }()
    private lazy var repassword:UITextField = {
        let text = UITextField()
        text.placeholder = "Enter password again"
        text.layer.borderWidth = 1
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 8
        text.textColor = .black
        text.isSecureTextEntry = true
//        text.isSecureTextEntry.toggle()
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.layer.borderColor = UIColor.gray.cgColor
        text.textAlignment = .left
        text.addPaddingToTextField()
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 17)
        return text
    }()
    @objc func onClickShowPassword(){
        if password.isSecureTextEntry {
            showPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }else {
            showPassword.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        password.isSecureTextEntry.toggle()
        
    }
    @objc func onClickShowRepassword(){
        if repassword.isSecureTextEntry {
            showRepassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }else {
            showRepassword.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        repassword.isSecureTextEntry.toggle()
    }
    override init(vm: MovieViewModel, router: RouterProtocol) {
        super.init(vm: vm, router: router)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLogin()
    }
    @objc func goSignUp(){
        email.text = ""
        password.text = ""
        self.loginText.removeFromSuperview()
        self.email.removeFromSuperview()
        self.password.removeFromSuperview()
        self.login.removeFromSuperview()
        self.createAccount.removeFromSuperview()
        self.showPassword.removeFromSuperview()
        self.forgotPassword.removeFromSuperview()
        setupRegister()
        print("tapped to go signUp")
    }
    @objc func backLoginFunc(){
        email.text = ""
        password.text = ""
        self.signUpText.removeFromSuperview()
        self.username.removeFromSuperview()
        self.email.removeFromSuperview()
        self.password.removeFromSuperview()
        self.repassword.removeFromSuperview()
        self.register.removeFromSuperview()
        self.backLogin.removeFromSuperview()
        self.showPassword.removeFromSuperview()
        self.showRepassword.removeFromSuperview()
        setupLogin()
        print("tapped to BackLogin")
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.username.text?.isEmpty == false && self.email.text?.isEmpty == false && self.password.text?.isEmpty == false && self.repassword.text?.isEmpty == false {
            register.backgroundColor = .blue
            register.isEnabled = true
        }
        else {
            register.backgroundColor = .gray
            register.isEnabled = false
        }
    }
    @objc func textFieldDidChangeLogin(_ textField: UITextField) {
        if  self.email.text?.isEmpty == false && self.password.text?.isEmpty == false {
            login.backgroundColor = .blue
            login.isEnabled = true
        }
        else {
            login.backgroundColor = .gray
            login.isEnabled = false
        }
    }
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btn)
        self.present(alert, animated: true)
    }
    private func setupRegister(){
        self.view.addSubview(signUpText)
        self.view.addSubview(username)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(repassword)
        self.view.addSubview(register)
        self.view.addSubview(backLogin)
        self.view.addSubview(showPassword)
        self.view.addSubview(showRepassword)
        password.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        repassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        email.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        username.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        email.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        username.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(email.snp.top).offset(-20)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        signUpText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(username.snp.top).offset(-40)
        }
        password.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(email.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        showPassword.snp.makeConstraints { make in
            make.centerY.equalTo(password.snp.centerY)
            make.right.equalTo(password.snp.right).offset(-6)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        repassword.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(password.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        showRepassword.snp.makeConstraints { make in
            make.centerY.equalTo(repassword.snp.centerY)
            make.right.equalTo(repassword.snp.right).offset(-6)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        register.snp.makeConstraints { make in
            make.right.equalTo(self.repassword.snp.right)
            make.top.equalTo(repassword.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        backLogin.snp.makeConstraints { make in
            make.centerY.equalTo(self.register.snp.centerY)
            make.left.equalTo(self.repassword.snp.left)
        }
    }
    private func setupLogin(){
        self.view.addSubview(loginText)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(login)
        self.view.addSubview(createAccount)
        self.view.addSubview(forgotPassword)
        self.view.addSubview(showPassword)
        password.addTarget(self, action: #selector(textFieldDidChangeLogin), for: .editingChanged)
        email.addTarget(self, action: #selector(textFieldDidChangeLogin), for: .editingChanged)
        password.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        showPassword.snp.makeConstraints { make in
            make.centerY.equalTo(password.snp.centerY)
            make.right.equalTo(password.snp.right).offset(-6)
            make.height.equalTo(20)
            make.width.equalTo(30)
        }
        email.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(password.snp.top).offset(-20)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        loginText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(email.snp.top).offset(-40)
        }
        forgotPassword.snp.makeConstraints { make in
            make.top.equalTo(self.password.snp.bottom).offset(10)
            make.right.equalTo(self.password.snp.right)
        }
        login.snp.makeConstraints { make in
            make.right.equalTo(self.password.snp.right)
            make.top.equalTo(forgotPassword.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        createAccount.snp.makeConstraints { make in
            make.centerY.equalTo(self.login.snp.centerY)
            make.left.equalTo(self.password.snp.left)
        }
    }
}
