//
//  NavigationEdiitNoteController.swift
//  FocusStartTestTask
//
//  Created by Max on 18.03.2021.
//  Copyright © 2021 Max. All rights reserved.
//

import UIKit

class NavigationEdiitNoteController: UINavigationController {
    //это раздел переменных, в которые передаются данные нажатой ячейки
    var sendInfoTitle="" //титульник записи
    var sendInfoText="" //текст
    var sendInfoIndexNote=0 //индекс записи
    //var sendNumberAllNote=1 //общее число записей
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let editNoteScreen = storyBoard.instantiateViewController(withIdentifier: "EditScreen") as! EditNoteVC
        
        editNoteScreen.sendNavigationViewControllInfoTitle=sendInfoTitle
        editNoteScreen.sendNavigationViewControllInfoText=sendInfoText
        editNoteScreen.sendNavigationViewControllInfoIndex=sendInfoIndexNote
        //editNoteScreen.sendNavigationNumberAllNote=sendNumberAllNote
        
        
        show(editNoteScreen, sender: nil)
        //self.present(editNoteScreen, animated:true, completion:nil)
        
    }
    

    

}
