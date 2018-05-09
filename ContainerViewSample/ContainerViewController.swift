//
//  ContainerViewController.swift
//  ContainerViewSample
//
//  Created by Matej Malesevic on 08.05.18.
//  Copyright © 2018 Approppo. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    var sidePanelViewController: SidePanelViewController!
    
    var primaryViewController: PrimaryViewController!
    var secundaryViewController: SecundaryViewController!
    
    var navControllerPrimaryVC: UINavigationController!
    var navControllerSecundaryVC: UINavigationController!
    
    func setupViews() {
        sidePanelViewController = SidePanelViewController()
        addChildViewController(sidePanelViewController)
        
        primaryViewController = PrimaryViewController(nibName: "PrimaryViewController", bundle: Bundle.main)
        secundaryViewController = SecundaryViewController(nibName: "SecundaryViewController", bundle: Bundle.main)
        
        
        navControllerPrimaryVC = UINavigationController(rootViewController: primaryViewController)
        navControllerSecundaryVC = UINavigationController(rootViewController: secundaryViewController)
        
        addChildViewController(navControllerSecundaryVC)
        addChildViewController(navControllerPrimaryVC)
        
        navControllerPrimaryVC.navigationBar.tintColor = UIColor.white
        navControllerPrimaryVC.navigationBar.barTintColor = UIColor.darkGray
        navControllerPrimaryVC.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navControllerPrimaryVC.navigationBar.isTranslucent = false
        navControllerPrimaryVC.didMove(toParentViewController: self)
        
        navControllerSecundaryVC.navigationBar.tintColor = UIColor.white
        navControllerSecundaryVC.navigationBar.barTintColor = UIColor.darkGray
        navControllerSecundaryVC.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navControllerSecundaryVC.navigationBar.isTranslucent = false
        navControllerPrimaryVC.didMove(toParentViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let safeWindow = self.view.window {
            sidePanelViewController.view.frame.size.height = safeWindow.frame.height
        }
        
        view.addSubview(sidePanelViewController.view)
        view.addSubview(navControllerSecundaryVC.view)
        view.addSubview(navControllerPrimaryVC.view)
        
        navControllerPrimaryVC.didMove(toParentViewController: self)
//        displayContentViewController(primaryViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func displayContentViewController(_ contentVC: UIViewController) {
        addChildViewController(contentVC)
        if let safeWindow = self.view.window {
            contentVC.view.frame = safeWindow.frame
        }
        self.view.addSubview(contentVC.view)
        contentVC.didMove(toParentViewController: self)
    }
    
    func hideContentViewController(_ contentVC: UIViewController) {
        contentVC.willMove(toParentViewController: nil)
        contentVC.view.removeFromSuperview()
        contentVC.removeFromParentViewController()
    }

    func anmiateSidepanel(_ targetPosition: CGFloat,currentVC oldVC: UIViewController, vcToDisplay newVC: UIViewController, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.sidePanelViewController.view.frame.origin.x = targetPosition
            let shadowPath = UIBezierPath(rect: self.sidePanelViewController.view.bounds)
            oldVC.view.layer.masksToBounds = false
            oldVC.view.layer.shadowOpacity = 1.0
            oldVC.view.layer.shadowColor = UIColor.black.cgColor
            oldVC.view.layer.shadowPath = shadowPath.cgPath
        }, completion: completion)
    }
    
    func openSidePanel(currentVC oldVC: UIViewController, completion: ((Bool) -> Void)? = nil) {
        view.addSubview(sidePanelViewController.view)
        self.anmiateSidepanel(0, currentVC: oldVC, vcToDisplay: sidePanelViewController, completion: completion)
    }
    
    func closeSidePanel(vcToDisplay newVC: UIViewController, completion: ((Bool) -> Void)? = nil) {
        self.anmiateSidepanel(self.sidePanelViewController.view.frame.size.width * -1, currentVC: sidePanelViewController , vcToDisplay: newVC, completion: completion)
    }
    
}
