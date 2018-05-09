//
//  PrimaryViewController.swift
//  ContainerViewSample
//
//  Created by Matej Malesevic on 08.05.18.
//  Copyright © 2018 Approppo. All rights reserved.
//

import UIKit

class PrimaryViewController: UIViewController {
    
    @IBAction func showMenu(_ sender: Any) {
        if let safeParent: ContainerViewController = self.parent?.parent as? ContainerViewController {
            safeParent.openSidePanel(currentVC: safeParent.navControllerPrimaryVC)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let menuButton = UIBarButtonItem(title: nil, style: UIBarButtonItemStyle.done, target: self, action: #selector(showMenu(_:)))
        menuButton.image = UIImage(named: "burger")
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = menuButton;
        // hide export button in navigation bar
        self.navigationItem.leftBarButtonItem?.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
