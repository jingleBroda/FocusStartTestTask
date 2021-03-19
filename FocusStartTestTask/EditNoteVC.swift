//
//  EditNoteVC.swift
//  FocusStartTestTask
//
//  Created by Max on 16.03.2021.
//  Copyright © 2021 Max. All rights reserved.
//
import UIKit

class EditNoteVC: UIViewController {
    
    let userDefaultsNote=UserDefaults.standard
    
    @IBOutlet weak var titleNote: UITextField!
    @IBOutlet weak var textNote: UITextView!
    var sendNavigationViewControllInfoTitle = ""
    var sendNavigationViewControllInfoText = ""
    var sendNavigationViewControllInfoIndex = 0
    //var sendNavigationNumberAllNote=1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textNote.text=sendNavigationViewControllInfoText
        titleNote.text=sendNavigationViewControllInfoTitle
        
    }
    
    
    @IBAction func SaveButton(_ sender: UIBarButtonItem) {
        let setTitle="Title"+String(sendNavigationViewControllInfoIndex)
        let setText="Text"+String(sendNavigationViewControllInfoIndex)
        userDefaultsNote.setValue(titleNote.text, forKey: setTitle)
        userDefaultsNote.setValue(textNote.text, forKey: setText)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let mainNavigationTabelScreen = storyBoard.instantiateViewController(withIdentifier: "MainNavigationScreen") as! NavigationMainTabelVewController
        
        //mainNavigationTabelScreen.sendEditScreenNumberAllNote=sendNavigationNumberAllNote
        
        show(mainNavigationTabelScreen, sender: nil)
        
        
    }
    
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let mainTabelScreen = storyBoard.instantiateViewController(withIdentifier: "MainNavigationScreen") as! NavigationMainTabelVewController
        
        //mainTabelScreen.sendEditScreenNumberAllNote=sendNavigationNumberAllNote
        
        show(mainTabelScreen, sender: nil)
    }
    
}
