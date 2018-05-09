//
//  SidePanelViewController.swift
//  ContainerViewSample
//
//  Created by Matej Malesevic on 08.05.18.
//  Copyright © 2018 Approppo. All rights reserved.
//

import UIKit

class SidePanelViewController: UIViewController {

    @IBAction func showSecundaryTouched(_ sender: Any) {
        
        if let safeParent: ContainerViewController = self.parent as? ContainerViewController {
            safeParent.displayContentViewController(safeParent.navControllerSecundaryVC)
        }
    }
    
    @IBAction func showPrimaryTouched(_ sender: Any) {
        
        if let safeParent: ContainerViewController = self.parent as? ContainerViewController {
            safeParent.displayContentViewController(safeParent.navControllerPrimaryVC)           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
