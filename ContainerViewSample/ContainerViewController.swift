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
        
        secundaryViewController = SecundaryViewController(nibName: "SecundaryViewController", bundle: Bundle.main)
        navControllerSecundaryVC = UINavigationController(rootViewController: secundaryViewController)
        
        navControllerSecundaryVC.navigationBar.tintColor = UIColor.white
        navControllerSecundaryVC.navigationBar.barTintColor = UIColor.darkGray
        navControllerSecundaryVC.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navControllerSecundaryVC.navigationBar.isTranslucent = false
        navControllerSecundaryVC.didMove(toParentViewController: self)
        
        
        primaryViewController = PrimaryViewController(nibName: "PrimaryViewController", bundle: Bundle.main)
        navControllerPrimaryVC = UINavigationController(rootViewController: primaryViewController)
        
        navControllerPrimaryVC.navigationBar.tintColor = UIColor.white
        navControllerPrimaryVC.navigationBar.barTintColor = UIColor.darkGray
        navControllerPrimaryVC.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navControllerPrimaryVC.navigationBar.isTranslucent = false
        navControllerPrimaryVC.didMove(toParentViewController: self)
        
        addChildViewController(sidePanelViewController)
        view.addSubview(sidePanelViewController.view)
        
        addChildViewController(navControllerSecundaryVC)
        view.addSubview(navControllerSecundaryVC.view)
        
        addChildViewController(navControllerPrimaryVC)
        view.addSubview(navControllerPrimaryVC.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //as the sidepanel is added as last element to the stack, is must be hidden again by moving it out of the screen
        sidePanelViewController.view.frame.origin.x = sidePanelViewController.view.frame.size.width * -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navControllerPrimaryVC.willMove(toParentViewController: self)
        navControllerPrimaryVC.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayContentViewController(_ contentVC: UIViewController) {
        contentVC.view.alpha = 0.0
        contentVC.willMove(toParentViewController: self)
        
        if let safeWindow = self.view.window {
            contentVC.view.frame = safeWindow.frame
        }
        
        view.addSubview(contentVC.view)
        
        contentVC.didMove(toParentViewController: self)
        
        closeSidePanel()
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .layoutSubviews, animations: {
            contentVC.view.alpha = 1.0
            self.sidePanelViewController.view.alpha = 0.5
        }) {
            sidePanelViewController.view.alpha = 1.0
        }
    }
    
    func anmiateSidepanel(_ targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations:
            {
                let shadowPath = UIBezierPath(rect: self.sidePanelViewController.view.bounds)
                self.sidePanelViewController.view.layer.masksToBounds = false
                self.sidePanelViewController.view.layer.shadowOpacity = 0.8
                self.sidePanelViewController.view.layer.shadowColor = UIColor.black.cgColor
                self.sidePanelViewController.view.layer.shadowPath = shadowPath.cgPath
                self.sidePanelViewController.view.frame.origin.x = targetPosition
                
        }, completion: completion)
    }
    
    func openSidePanel(completion: ((Bool) -> Void)? = nil) {

        view.addSubview(self.sidePanelViewController.view)
        self.anmiateSidepanel(-5, completion: completion)
    }
    
    func closeSidePanel(completion: ((Bool) -> Void)? = nil) {
        self.anmiateSidepanel(self.sidePanelViewController.view.frame.size.width * -1, completion: completion)
    }
    
}
