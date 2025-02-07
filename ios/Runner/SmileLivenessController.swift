//
//  SmileLivenessController.swift
//  Runner
//
//  Created by Putra Rolli on 07/02/25.
//
import Foundation
import AsliSmileLiveness
import UIKit

protocol SmileLivenessControllerDelegate: AnyObject {
    func didCompleteLiveness(result: String)
}

class SmileLivenessController : ContainerViewController {
    
    var controller: AsliSmileLivenessViewController?
    weak var delegate: SmileLivenessControllerDelegate?
    
    init() {
        controller = AsliSmileLivenessViewController.create(token: "4cdfb7dd-b690-45db-8f0c-e5a8c0813d1a")
        super.init(viewController: controller!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller?.delegate = self
        controller?.start()
        
        if let gesture = self.navigationController?.interactivePopGestureRecognizer {
            gesture.isEnabled = true
            gesture.delegate = self
        }
    }
    
}

extension SmileLivenessController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension SmileLivenessController: AsliSmileLivenessViewControllerDelegate {
    func didSmileLivenessSuccess(neutralImage: UIImage, smileImage: UIImage, result: Bool) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didCompleteLiveness(result: "\(result)")
    }
    
    func didSmileLivenessFailure(code: Int, errorMessage: String) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didCompleteLiveness(result: "\(errorMessage)")
    }
    
    func didTapRetake() {
        controller?.start()
    }
}
