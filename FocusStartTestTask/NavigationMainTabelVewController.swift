//
//  NavigationMainTabelVewController.swift
//  FocusStartTestTask
//
//  Created by Max on 19.03.2021.
//  Copyright © 2021 Max. All rights reserved.
//

import UIKit

class NavigationMainTabelVewController: UINavigationController {

    //var sendEditScreenNumberAllNote=1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let mainScreen = storyBoard.instantiateViewController(withIdentifier: "MainScreen") as! MainTableViewController
        
        //mainScreen.numberAllNote=sendEditScreenNumberAllNote
        
        show(mainScreen, sender: nil)
    }
    


}
