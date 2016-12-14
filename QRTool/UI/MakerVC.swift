//
//  MakerVC.swift
//  QRTool
//
//  Created by wangkan on 2016/12/13.
//  Copyright © 2016年 rockgarden. All rights reserved.
//

import UIKit

class MakerVC: UIViewController {
    
    //MARK: - Global Variables
    @IBOutlet private weak var contentLab: UITextField!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var QRCodeImageView: UIImageView!
    
    //MARK: - Lazy Components
    
    
    //MARK: - Public Methods
    
    
    //MARK: - Data Initialize
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
    }
    
    
    //MARK: - Interface Components
    
    fileprivate func setupComponents() {
        let chooseLogoGes = UITapGestureRecognizer(target: self, action: #selector(chooseLogo))
        logoImageView.addGestureRecognizer(chooseLogoGes)
    }
    
    //MARK: - Target Action

    @IBAction fileprivate func generateItemClick() {
        view.endEditing(true)
        
        guard let content = contentLab.text else {
            AppFunc.confirm(title: "confirmTitle", message: "confirmMessage", controller: self)
            return
        }
        
        if content.characters.count > 0 {
            DispatchQueue.global().async {
                let image = content.generateQRCodeWithLogo(logo: self.logoImageView.image)
                DispatchQueue.main.async(execute: {
                    self.QRCodeImageView.image = image
                })
            }
        } else {
            AppFunc.confirm(title: "confirmTitle", message: "confirmMessage", controller: self)
        }
        
    }
    
    @objc private func chooseLogo() {
        AppFunc.shareTool.choosePicture(self, editor: true) { [weak self] (image) in
            self?.logoImageView.image = image
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction fileprivate func dismissVC(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Data Request
    
    
    //MARK: - Private Methods
    
    
    //MARK: - Dealloc
    
}

