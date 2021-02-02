//
//  BaseViewController.swift
//  City-Search
//
//  Created by Mathew Thomas on 02/02/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let darkenView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:- Start Activity Indicator
    func startIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 50,height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        darkenView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        darkenView.backgroundColor = UIColor.black
        darkenView.alpha = 0.5
        self.view.addSubview(darkenView)
    }

    // MARK:- Stop Activity Indicator
    func stopIndicator() {
        self.activityIndicator.stopAnimating()
        self.darkenView.removeFromSuperview()
    }
    
    // MARK:- Show Error Message
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
