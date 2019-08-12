//
//  UIViewController+Extensions.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import Foundation
import UIKit
// TODO: - Uncomment frameworks after 'pod install'
// import ChameleonFramework

extension UIViewController {

  func loadCustomBackButton(withImage image: String, andTitle title: String = "") {
        let yourBackImage = UIImage(named: image)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.clearNavigationBackButtonText()
        self.navigationItem.backBarButtonItem?.title = title
  }
    
//    func hideNavigationBarHairline() {
//        if let navController = self.navigationController {
//            navController.hidesNavigationBarHairline = true
//        }
//    }
    
    func hideNavigationBar() {
        if let navController = self.navigationController {
            navController.navigationBar.isHidden = true
        }
    }
    
    func unHideNavigationBar() {
        if let navController = self.navigationController {
            navController.navigationBar.isHidden = false
        }
    }
    
    func showNavigationBar() {
        if let navController = self.navigationController {
            navController.navigationBar.isHidden = false
        }
    }
    
    func clearNavigationBackButtonText() {
        if (self.navigationController != nil) {
            self.navigationItem.title = ""
        }
    }
    
    func updateNavigationBar(withBackgroundColor bgColor: UIColor?,
                             tintColor: UIColor?,
                             andText text: String?) {
        if let navigationcontroller = self.navigationController {
            navigationcontroller.navigationBar.isTranslucent = false
            if let bgcolor = bgColor {
                navigationcontroller.navigationBar.barTintColor = bgcolor
            }
            if let tintcolor = tintColor {
                navigationcontroller.navigationBar.tintColor = tintcolor
              navigationcontroller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintcolor]
            }
            if text != nil {
                updateNavigationBar(title: text!)
            } else {
                clearNavigationBackButtonText()
            }
        }
    }
    
    func updateNavigationBar(title: String) {
        if (self.navigationController != nil) {
            self.navigationItem.title = title
        }
    }

    func updateNavigationBar(withImage imageName: String) {
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 38))
      imageView.contentMode = .scaleAspectFill
      let image = UIImage(named: imageName)
      imageView.image = image
      self.navigationItem.titleView = imageView
    }
    
    func updateNavigationBar(withButton button: UIButton) {
        if (self.navigationController != nil) {
            let button = UIBarButtonItem(customView: button)
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    func updateNavigationBar(withButton buttons: [UIButton]) {
        if (self.navigationController != nil) {
            var btns = [UIBarButtonItem]()
            for button in buttons {
                let btn = UIBarButtonItem(customView: button)
                btns.append(btn)
            }
            self.navigationItem.rightBarButtonItems = btns
        }
    }
    
    func navigateToView(withID vid: String, fromStoryboard sid: String = "Main") {
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: vid)
        UIApplication.shared.keyWindow?.rootViewController = viewcontroller
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    func pushToView(withID vid: String, fromStoryboard sid: String = "Main") {
        let storyboard = UIStoryboard(name: sid, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: vid)
        if (self.navigationController != nil) {
            self.navigationController!.pushViewController(viewcontroller, animated: true)
        } else {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    func pushToView(withViewController viewcontroller: UIViewController) {
        if (self.navigationController != nil) {
            self.navigationController!.pushViewController(viewcontroller, animated: true)
        } else {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    func popViewController(to vid: String? = nil, fromStoryboard sid: String? = nil){
        guard let idForViewController = vid, let idForStoryboard = sid else {
            if (self.navigationController != nil) {
                self.navigationController!.popViewController(animated: true)
            }
            return
        }
        let storyboard = UIStoryboard(name: idForStoryboard, bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: idForViewController)
        if (self.navigationController != nil) {
            self.navigationController!.popToViewController(viewcontroller,
                                                           animated: true)
        }
    }
    
    func popViewController(withViewController viewcontroller: UIViewController){
        if (self.navigationController != nil) {
            self.navigationController!.popToViewController(viewcontroller,
                                                           animated: true)
        } else {
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    func dismissViewController() {
        self.dismiss(animated: true,
                     completion: nil)
    }

    func setBackground(_ imageName: String, onView view: UIView) {
        if let view = self.view {
          let image = UIImage(named: imageName)
          let imageView = UIImageView(frame: view.frame)
          imageView.contentMode = .scaleAspectFill
          imageView.image = image
          view.addSubview(imageView)
          view.sendSubviewToBack(imageView)
        }
    }
    
    func setBackground(_ color: UIColor, onView view: UIView) {
        if let view = self.view {
            view.backgroundColor = color
        }
    }
    
//    func setBackgroundWithPrimaryGradient() {
//        if let view = self.view {
//            view.addPrimaryGradientToBackground()
//        }
//    }
//
//    func setBackgroundWithSecondaryGradient() {
//        if let view = self.view {
//            view.addSecondaryGradientToBackground()
//        }
//    }

    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 16, y: self.view.frame.size.height-150, width: self.view.frame.size.width - 32, height: 70))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: kFontBody, size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 2
        toastLabel.adjustsFontSizeToFitWidth = true

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: kAnimationDuration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    var emptyCell: UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ""
        return cell
    }
    
}

extension UIViewController {
  func setVCBackgroundImageToView(image: String) {
    let vcBackgroundImageView = UIImageView(frame: self.view.frame)
    let vcBackgroundImage = UIImage(named: image)
    vcBackgroundImageView.image = vcBackgroundImage
    vcBackgroundImageView.contentMode = .scaleAspectFill
    vcBackgroundImageView.clipsToBounds = true
    self.view.insertSubview(vcBackgroundImageView,
                            at: 0)
  }

//  func setVCBackgroundImageToViewWithGradient(image: String) {
//    let vcBackgroundImageView = UIImageView(frame: self.view.frame)
//    let vcBackgroundImage = UIImage(named: image)
//    vcBackgroundImageView.image = vcBackgroundImage
//    vcBackgroundImageView.contentMode = .scaleAspectFill
//    vcBackgroundImageView.clipsToBounds = true
//
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.frame = self.view.bounds
//    gradientLayer.colors = [UIColor.AppColors.purple.cgColor, UIColor.clear]
//    gradientLayer.locations = [0.3, 0.6]
//
//    vcBackgroundImageView.layer.addSublayer(gradientLayer)
//
//    self.view.insertSubview(vcBackgroundImageView,
//                            at: 0)
//  }

  public func programmaticSegue(vcName: String, storyBoard: String) -> Any? {
    let sb = UIStoryboard.init(name: storyBoard, bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: vcName)
    return vc
  }

  public func displaySpinner(onView : UIView) -> UIView {
    let spinnerView = UIView.init(frame: onView.bounds)
    spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    let ai = UIActivityIndicatorView.init(style: .whiteLarge)
    ai.startAnimating()
    ai.center = spinnerView.center

    DispatchQueue.main.async {
      spinnerView.addSubview(ai)
      onView.addSubview(spinnerView)
    }

    return spinnerView
  }

  public func removeSpinner(spinner :UIView) {
    DispatchQueue.main.async {
      spinner.removeFromSuperview()
    }
  }

  func showErrorAlert(title:String, message:String, okButtonTitle: String){
    let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title:okButtonTitle, style: .default, handler: {action in })
    alertView.addAction(okAction)
    alertView.modalPresentationStyle = .overFullScreen
    self.present(alertView, animated: true, completion: nil)
  }
  
//    func setupSuperHUD() {
//        HUDAppearance.cornerRadius = 10
//        HUDAppearance.animateInTime = 1.0
//        HUDAppearance.animateOutTime = 1.0
//        HUDAppearance.iconColor = UIColor.flatGreen
//        HUDAppearance.titleTextColor =  UIColor.flatGreen
//        HUDAppearance.loadingActivityIndicatorColor = UIColor.flatGreen
//        HUDAppearance.cancelableOnTouch = true
//        HUDAppearance.iconSize = CGSize(width: kIconSizeWidth, height: kIconSizeHeight)
//        HUDAppearance.messageFont = UIFont(name: kFontBody, size: kFontSizeBody) ?? UIFont.systemFont(ofSize: kFontSizeBody, weight: .regular)
//        HUDAppearance.titleFont = UIFont(name: kFontTitle, size: kFontSizeTitle) ?? UIFont.systemFont(ofSize: kFontSizeTitle, weight: .bold)
//    }
//
//    func showHUD(_ text: String = "Finding Users") {
//        APESuperHUD.show(style: .icon(image: UIImage(named: "dadhive-hive")!, duration: 4.0), title: nil, message: text, completion: nil)
//    }
//
//    func showHUD(_ text: String = "Finding Users", withDuration duration: TimeInterval? = 4.0) {
//        APESuperHUD.show(style: .icon(image: UIImage(named: "dadhive-hive")!, duration: duration), title: nil, message: text, completion: nil)
//    }
//
//    func dismissHUD() {
//        APESuperHUD.dismissAll(animated: true)
//    }
//
//    func showErrorAlert(message: String?) {
//        SVProgressHUD.showError(withStatus: message ?? "")
//        SVProgressHUD.setDefaultStyle(.dark)
//        SVProgressHUD.setDefaultMaskType(.gradient)
//        SVProgressHUD.setMinimumDismissTimeInterval(1)
//    }
//
//    func showErrorAlert(_ error: DadHiveError) {
//        SVProgressHUD.showError(withStatus: error.rawValue)
//        SVProgressHUD.setDefaultStyle(.dark)
//        SVProgressHUD.setDefaultMaskType(.gradient)
//        SVProgressHUD.setMinimumDismissTimeInterval(1)
//    }
//
//    func showAlertErrorIfNeeded(error: Error?) {
//        if let e = error {
//            showErrorAlert(message: e.localizedDescription)
//        } else {
//            SVProgressHUD.dismiss()
//        }
//    }
//
//    func showHUD() {
//        SVProgressHUD.show()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//        SVProgressHUD.setBackgroundColor(AppColors.darkGreen)
//        SVProgressHUD.setForegroundColor(UIColor.white)
//    }
//
//    func hideHUD() {
//        if SVProgressHUD.isVisible() {
//            SVProgressHUD.dismiss()
//        }
//        UIApplication.shared.endIgnoringInteractionEvents()
//    }
}
