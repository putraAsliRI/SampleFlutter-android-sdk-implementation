//
//  EyeGazeLivenessController.swift
//  Runner
//
//  Created by Putra Rolli on 07/02/25.
//

import Foundation
import AsliEyeGazeLiveness
import UIKit

protocol EyeGazeLivenessControllerDelegate: AnyObject {
    func didCompleteLiveness(result: String)
}

class EyeGazeLivenessController : ContainerViewController {
    
    var controller: AsliEyeGazeLivenessViewController?
    weak var delegate: EyeGazeLivenessControllerDelegate?
    
    init() {
        controller = AsliEyeGazeLivenessViewController.create(token: "4cdfb7dd-b690-45db-8f0c-e5a8c0813d1a")
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

extension EyeGazeLivenessController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension EyeGazeLivenessController: AsliEyeGazeLivenessViewControllerDelegate {
    func didEyeGazeLivenessSuccess(images: [UIImage], result: Bool) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didCompleteLiveness(result: "\(result)")
    }
    
    func didEyeGazeLivenessFailure(code: Int, errorMessage: String) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didCompleteLiveness(result: "\(errorMessage)")
    }
    
    func didTapRetake() {
        controller?.start()
    }
}
