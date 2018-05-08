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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
