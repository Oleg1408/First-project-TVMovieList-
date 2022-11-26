import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddRegistrationViewController: UIViewController {
    
    @IBOutlet weak var centralMainTextLable: UILabel!
    @IBOutlet weak var enterRegisterNameTextField: UITextField!
    @IBOutlet weak var enterRegisterSecondNameTextField: UITextField!
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterRegisterPasswordTextField: UITextField!
    @IBOutlet weak var errorOutputTextLable: UILabel!
    
    var dataBaseFirebase: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsMainTextLable()
        settingserrorOutputTextLable()
        dataBaseFirebase = Firestore.firestore()
    }
    
    func settingserrorOutputTextLable() {
        errorOutputTextLable.alpha = 0
        errorOutputTextLable.textColor = .systemRed
    }
    
    func settingsMainTextLable() {
        centralMainTextLable.text = "Register"
    }
    
    enum RegisterResult {
        case success
        case failure(Error)
    }
    
    func register(email: String?, password: String?, completion: @escaping(RegisterResult) -> ()) {
        
        guard ErCheckRegister.isFilledRegister(name: enterRegisterNameTextField.text,
                                               secondName: enterRegisterSecondNameTextField.text,
                                               email: email, password: password) else {
            completion(.failure(AuthErrorRegister.notField))
            return
        }
        
        guard let email = email, let password = password else {
            completion(.failure(AuthErrorRegister.unknowError))
            return
        }
        
        guard ErCheckRegister.checkEmailForRegister(email) else {
            completion(.failure(AuthErrorRegister.invalidEmail))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return}
            
            self.dataBaseFirebase.collection("users").addDocument(data: [
                "Name" : self.enterRegisterNameTextField.text!,
                "Second Name": self.enterRegisterSecondNameTextField.text!,
                "UID": result.user.uid ]) { error in
                    if error != nil {
                        completion(.failure(AuthErrorRegister.serverError))
                    } else {
                        completion(.success)
                    }
                }
            }
        }
    
    @IBAction func pressedSingUpButton(_ sender: Any) {
        register(email: enterEmailTextField.text, password: enterRegisterPasswordTextField.text) { result in
            switch result {
            case .success:
                self.showAlert(with: "Successfully", and: "You are registered")
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
    
    @IBAction func tapRegistration(_ sender: Any) {
        
        enterRegisterNameTextField.resignFirstResponder()
        enterRegisterSecondNameTextField.resignFirstResponder()
        enterEmailTextField.resignFirstResponder()
        enterRegisterPasswordTextField.resignFirstResponder()
    }
}
