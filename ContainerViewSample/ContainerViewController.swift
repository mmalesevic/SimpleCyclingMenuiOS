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
        
        navControllerPrimaryVC.didMove(toParentViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(sidePanelViewController.view)
        displayContentViewController(primaryViewController)
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

    func cycle(fromViewController oldVC: UIViewController, toViewController newVC: UIViewController) {
     
        oldVC.willMove(toParentViewController: nil)
        addChildViewController(newVC)
        
        newVC.view.frame = CGRect(x: -320, y: 0, width: 320, height: 814)
        let endFrame: CGRect = CGRect(x: -320, y:0, width: 320, height: 814)
        
        self.transition(from: oldVC, to: newVC, duration: 0.25, options: .layoutSubviews, animations: {
            newVC.view.frame = oldVC.view.frame
            oldVC.view.frame = endFrame
        }) { _ in
            oldVC.removeFromParentViewController()
            newVC.didMove(toParentViewController: self)
        }
    }
    
    func anmiateSidepanel(_ targetPosition: CGFloat,currentVC oldVC: UIViewController, vcToDisplay newVC: UIViewController, completion: ((Bool) -> Void)? = nil) {
        view.addSubview(sidePanelViewController.view)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.sidePanelViewController.view.frame.origin.x = targetPosition
            let shadowPath = UIBezierPath(rect: self.sidePanelViewController.view.bounds)
            oldVC.view.layer.masksToBounds = false
            oldVC.view.layer.shadowOpacity = 1.0
            oldVC.view.layer.shadowColor = UIColor.black.cgColor
            oldVC.view.layer.shadowPath = shadowPath.cgPath
            //self.displayContentViewController(newVC)
        }, completion: completion)
    }
    
    func openSidePanel(currentVC oldVC: UIViewController, completion: ((Bool) -> Void)? = nil) {
        self.anmiateSidepanel(0, currentVC: oldVC, vcToDisplay: sidePanelViewController, completion: completion)
    }
    
    func closeSidePanel(vcToDisplay newVC: UIViewController, completion: ((Bool) -> Void)? = nil) {
        self.anmiateSidepanel(self.sidePanelViewController.view.frame.size.width * -1, currentVC: sidePanelViewController , vcToDisplay: newVC, completion: completion)
    }
    
}
