//
//  RecognizeVC.swift
//  QRTool
//
//  Created by wangkan on 2016/12/14.
//  Copyright © 2016年 rockgarden. All rights reserved.
//

import UIKit

class RecognizeVC: UIViewController {
    
    //MARK: - Global Variables
    var sourceImage : UIImage?
    @IBOutlet private weak var sourceImageView: UIImageView!
    @IBOutlet private weak var activityIndicatoryView: UIActivityIndicatorView!
    
    //MARK: - Lazy Components
    
    
    //MARK: - Public Methods
    
    
    //MARK: - Data Initialize
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        setupGes()
    }
    
    
    //MARK: - Interface Components
    private func setupGes() {
        sourceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
    }
    
    private func setupImage() {
        sourceImageView.image = sourceImage
        recognizeQRCode()
    }
    
    //MARK: - Target Action
    @objc private func chooseImage() {
        AppFunc.shareTool.choosePicture(self, editor: false) { [weak self] (image) in
            self?.sourceImage = image
            self?.setupImage()
        }
    }
    
    //MARK: - Data Request
    
    
    //MARK: - Private Methods
    private func recognizeQRCode() {
        activityIndicatoryView.startAnimating()
        
        DispatchQueue.global().async {
            let recognizeResult = self.sourceImage?.recognizeQRCode()
            let result = recognizeResult?.characters.count > 0 ? recognizeResult : "无法识别"
            DispatchQueue.main.async {
                AppFunc.confirm(title: "扫描结果", message: result, controller: self)
                self.activityIndicatoryView.stopAnimating()
            }
        }
    }
    
    @IBAction fileprivate func dismissVC(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}
