//
//  Extentions.swift
//  msi
//
//  Created by Emilia Tothova on 27/10/2020.
//

import Foundation
import UIKit

extension UIColor {

    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

}




extension UIView {
    
    func addBackground() {
        let width = self.bounds.size.width
        let height = self.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "path3Copy")

        // you can change the content mode:
        imageViewBackground.contentMode = .scaleAspectFill


        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    func addLeftRedViewAndBorder() {
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        
        let testFrame = CGRect(x: 0, y: 0, width: 10, height: self.frame.height)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = UIColor.red
        self.addSubview(testView)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.veryLightPink.cgColor
        
        self.layer.shadowColor = UIColor.whiteTwo.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
    }
    
    func addLeftYellowViewAndBorder() {
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        
        let testFrame = CGRect(x: 0, y: 0, width: 10, height: self.frame.height)
        let testView : UIView = UIView(frame: testFrame)
        testView.backgroundColor = UIColor.maize
        self.addSubview(testView)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.veryLightPink.cgColor
        
        self.layer.shadowColor = UIColor.whiteTwo.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
    }
    
    func addPictoRight(picName: String) {
        var imageView : UIImageView
        let imageFrame = CGRect(x: self.frame.width - 25, y: self.frame.height / 2 - 10, width: 20, height: 20)
        imageView = UIImageView(frame: imageFrame)
        imageView.image = UIImage(named: picName)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
    }
    
    func addPictoLeft(picName: String) {
        var imageView : UIImageView
        let imageFrame = CGRect(x: 25, y: self.frame.height / 2 - 12, width: 20, height: 20)
        imageView = UIImageView(frame: imageFrame)
        imageView.image = UIImage(named: picName)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
    }
    
    func addBottomBG(){
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = UIColor(hexString: "#ececec").cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
            self.layer.addSublayer(border)
        }

        func addRightBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x: self.frame.size.width - width,y: 0, width:width, height:self.frame.size.height)
            self.layer.addSublayer(border)
        }

        func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.name = "bottomBorder"
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
            self.layer.addSublayer(border)
        }

        func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
            self.layer.addSublayer(border)
        }
    
        func removeLayer(layerName: String) {
            for item in self.layer.sublayers ?? [] where item.name == layerName {
                    item.removeFromSuperlayer()
            }
        }
}

extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = .center

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}

extension UITextField {
    
    func addBottomBorder() {
        let screenSize: CGRect = UIScreen.main.bounds
        print(screenSize.width)
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: screenSize.width - 80, height: 1)
        bottomLine.backgroundColor = UIColor.veryLightPink.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIColor {

    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 162.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 239.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black: UIColor {
        return UIColor(white: 26.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var maize: UIColor {
        return UIColor(red: 1.0, green: 215.0 / 255.0, blue: 78.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whiteTwo: UIColor {
        return UIColor(white: 246.0 / 255.0, alpha: 1.0)
    }
    
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        alert.view.tintColor = UIColor.white
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createCustomActivityIndicator() -> MyIndicator {
        let grayView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        grayView.tag = 100
        view.addSubview(grayView)
        
        let ind = MyIndicator(frame: CGRect(x: self.view.frame.size.width / 2 - 50, y: self.view.frame.size.height / 2 - 50, width: 100, height: 100), image: UIImage(named: "spinningArrow")!)
        grayView.addSubview(ind)
        //ind.startAnimating()
        
        return ind
    }
    
    func stopCustomActivityIndicator(indicator: MyIndicator) {
        indicator.stopAnimating()
        
        let mySubviews = self.view.allSubViews
        
        for subview in mySubviews {
            if let graySubview = subview.viewWithTag(100) {
                graySubview.removeFromSuperview()
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    var allSubViews : [UIView] {

        var array = [self.subviews].flatMap {$0}

        array.forEach { array.append(contentsOf: $0.allSubViews) }

        return array
    }
}

extension UIButton {
    func activate() {
        self.setTitleColor(UIColor.black, for: .normal)
        self.addBottomBorderWithColor(color: UIColor(hexString: "#ffd74e"), width: 2)
    }
    
    func deactivate() {
        self.setTitleColor(UIColor.brownGrey, for: .normal)
        self.removeLayer(layerName: "bottomBorder")
    }
    
    func startAnimating() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.rotated(by: .pi / 2)
            }) { (finished) -> Void in
            
                if self.tag == -1 {
                    return
                }
                else {
                    self.startAnimating()
                }
                
            }
    }
    
    func stopAnimating() {
        self.tag = -1
    }
    
    func roundButton(background: UIColor) {
        self.backgroundColor = background
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.maize.cgColor
    }
}
