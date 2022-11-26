import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginAndRegistrationViewController: UIViewController {
    
    @IBOutlet weak var centralTextLable: UILabel!
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var errorOutputTextLable: UILabel!
    @IBOutlet weak var settingsLoginButton: UIButton!
    @IBOutlet weak var settingRegisterButton: UIButton!
    @IBOutlet weak var settingGuestLoginButton: UIButton!
    @IBOutlet weak var backButton: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingErrorOutputTextLable()
        settingsCentralTextLable()
        settingsBackButton()
    }
    
    func settingsBackButton() {
        backButton.backButtonTitle = "Back to login"
    }
    
    func settingErrorOutputTextLable() {
        errorOutputTextLable.alpha = 0
        errorOutputTextLable.textColor = .systemRed
    }
    
    func settingsCentralTextLable() {
        centralTextLable.text = "MovTvList"
    }
    
    enum LoginRegister {
        case success
        case failure(Error)
    }
    
    func login(email: String?, password: String?, completion: @escaping(LoginRegister) -> ()) {
        
        guard ErCheckLogin.isFilledLogin(email: email, password: password) else {
            completion(.failure(AuthErrorLogin.notField))
            return
        }
        
        guard let emailLogin = email, let _ = password else {
            completion(.failure(AuthErrorLogin.unknowError))
            return
        }
        
        guard ErCheckLogin.checkEmailForLogin(emailLogin) else {
            completion(.failure(AuthErrorLogin.invalidEmail))
            return
        }
        
        Auth.auth().signIn(withEmail: enterEmailTextField.text!, password: enterPasswordTextField.text!) {(result, error) in
            guard let _ = result else {
                completion(.failure(error!))
                return}
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainControllerLogin = storyboard.instantiateViewController(withIdentifier: "\(UINavigationController.self)") as?
                UINavigationController {
                
                self.present(mainControllerLogin, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func pressedLoginButton(_ sender: Any) {
        
        login(email: enterEmailTextField.text, password: enterPasswordTextField.text) { result in
            switch result {
            case .success:
                self.showAlert(with: "", and: "")
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
    
    @IBAction func pressedRegisterButton(_ sender: Any) {
        performSegue(withIdentifier: "goRegister", sender: nil)
    }
    
    @IBAction func pressedGuestLoginButton(_ sender: Any) {}
    
    @IBAction func tap(_ sender: Any) {
        enterEmailTextField.resignFirstResponder()
        enterPasswordTextField.resignFirstResponder()
    }
}

