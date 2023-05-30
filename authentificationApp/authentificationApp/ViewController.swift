//
//  ViewController.swift
//  authentificationApp
//
//  Created by Алексей Зубель on 26.05.23.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    @IBOutlet var regView: UIView!
    
    @IBOutlet var logoutView: UIView!
    
    @IBOutlet var regLogin: UITextField!
    
    @IBOutlet var regEmail: UITextField!
    
    @IBOutlet var regPassword: UITextField!
    
    @IBOutlet var regRepeatPassword: UITextField!
    
    @IBOutlet var regSwitch: UISwitch!
    
    @IBOutlet var alertLabel: UILabel!
            
    @IBOutlet var logLogin: UITextField!
    
    @IBOutlet var logPassword: UITextField!

    @IBOutlet var logAlert: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(regView)
        view.addSubview(logoutView)
        logoutView.isHidden = true
        regView.isHidden = true
        
    }
    
    //MARK: changing log and sign views
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.regView.isHidden = true
        case 1:
            self.regView.isHidden = false
        default:
            break
        }
    }
    
    //MARK: sign view
    @IBAction func regEnter(_ sender: UIButton) {
        //verification
        if(regLogin.text != nil && regEmail.text != nil && regPassword.text != nil && regRepeatPassword.text == regPassword.text && regRepeatPassword.text != nil && regSwitch.isOn && !isUserExist()){
            
            let defaults = UserDefaults.standard  //получение ссылки для работы с файлом plist с данными пользователя
            
//            let customerDefaults = createCustomUserDefaults()//получение ссылки для работы с файлом plist с данными пользователя

            let login = regLogin.text
            defaults.set(login, forKey: "login")
            let email = regEmail.text
            defaults.set(email, forKey: "email")
            let password = regPassword.text
            defaults.set(password, forKey: "password")
            self.logoutView.isHidden = false
            alertLabel.text = ""
        }
        else{
            alertLabel.textColor = .red
            if(isUserExist()){
                alertLabel.text = "such user is already exists"
            }
            alertLabel.textColor = .red
            alertLabel.text = "data is incorrect"
        }
    }
    
    @IBAction func loggout(_ sender: Any) {
        self.logoutView.isHidden = true

    }
    
    //MARK: log view
    @IBAction func logEnter(_ sender: Any) {
        let defaults = UserDefaults.standard
        
//        let customerDefaults = createCustomUserDefaults()   //получение ссылки для работы с файлом plist с данными пользователя
        
        if(logLogin.text != nil && logPassword.text != nil){
            if(defaults.string(forKey: "login") == logLogin.text && defaults.string(forKey: "password") == logPassword.text){
                self.logoutView.isHidden = false
                logAlert.text = ""
            }
            else{
                logAlert.textColor = .red
                logAlert.text = "incorrect password or login"
            }
        }
        else{
            logAlert.textColor = .red
            logAlert.text = "login and password fields can't be empty"
        }
    }
    
    //TODO: loading file with user's data from project directory
    func createCustomUserDefaults() -> UserDefaults? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray //определяем путь к директории документов проекта
        let DocumentDirectory = paths[0] as! String
        let path = DocumentDirectory.appending("userData.plist")//добавляем имя файла к пути
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)){          //если файла не существует то копируем файл из проекта в директорию
            if let bundlePath = Bundle.main.path(forResource: "userData", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle file userData.plist is -> \(String(describing: result?.description))")
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }catch{
                    print("coping failure")
                }
            }
            else{
                print("file userData.plist not found")
            }
        }else{
            print("file userData.plist already exist")
        }
    
        let customUserDefaults = UserDefaults(suiteName: path)//получение ссылки для работы с файлом plist с данными пользователя
        
        return customUserDefaults
    }
    
    func isUserExist() -> Bool{
        let defaults = UserDefaults.standard
        return (regLogin.text == defaults.string(forKey: "login") && regPassword.text == defaults.string(forKey: "password"))
    }

}

