//
//  ViewController.swift
//  SwipeToSpin
//
//  Created by Bali on 20/04/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  static let ViewToImagesSegue = "ViewToImagesVC"
  
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var countTextField: UITextField!

  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchTextField.becomeFirstResponder()
    navigationItem.title = "Home"
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    if let vc = segue.destination as? ImagesViewController {
      vc.searchText = searchTextField.text!
      vc.count = Int(countTextField.text!)!
    }
  }

  // MARK:- IBActions
  @IBAction func searchButtonTapped(_ sender: UIButton) {
    guard let searchText = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), searchText.count > 0,
      let text = countTextField.text,
      let n = Int(text), n > 1 else {
        AlertManager.showError(message: "Invalid input", viewController: self)
        return
    }
    
    if isNumberPrime(n) {
      performSegue(withIdentifier: type(of: self).ViewToImagesSegue, sender: nil)
    } else {
      AlertManager.showError(message: "Input number not prime", viewController: self)
    }
  }
  
  // MARK:- Private Methods
  private func isNumberPrime(_ n: Int) -> Bool {
    let m = Int(Float(n).squareRoot())
    if n%2 == 0 {
      return false
    }
    
    for i in stride(from: 3, through: m, by: 2) {
      if n%i == 0 {
        return false
      }
    }
    
    return true
  }
}

// MARK:- UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == searchTextField {
      countTextField.becomeFirstResponder()
    }
    
    return true
  }
}
