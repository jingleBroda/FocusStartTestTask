//
//  MainTabelViewTableViewController.swift
//  FocusStartTestTask
//
//  Created by Max on 16.03.2021.
//  Copyright © 2021 Max. All rights reserved.
//
/*
 Заранее извиняюсь за использование  userDefault в таком виде.
 Я к сожалению не успел разобрать метод работы с нормальной БД, поэтому пришлось делать таким образом=)
 
 */

import UIKit

class MainTableViewController: UITableViewController {
    @IBOutlet weak var newNote: UIBarButtonItem!
    
    var itemArray=[ModelNote]()
    var newTitleNote = "Я новая заметка!"
    var newTextNote = "напишите сюда что-нибудь"
    let userDefaultsNote=UserDefaults.standard
    var numberAllNote=1 //число записей
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //очистка userdefault
        /*
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        */
        
        if (userDefaultsNote.object(forKey: "AllNote")==nil) || (userDefaultsNote.integer(forKey: "AllNote")==0)
        {  //если это первый запуск приложения (или же существующих заметок нет в приложении)
            numberAllNote=1
            let startNote=ModelNote(titleNote:"Я новая заметка!", textNote:"напишите сюда что-нибудь")
            itemArray.append(startNote)
            userDefaultsNote.setValue(numberAllNote, forKey: "AllNote")
            userDefaultsNote.setValue("Я новая заметка!", forKey: "Title0")
            userDefaultsNote.setValue("напишите сюда что-нибудь", forKey: "Text0")
        }
        else{
            //иначе загружаем сохраненные заметки
            numberAllNote=userDefaultsNote.integer(forKey: "AllNote")
            
            for i in 0..<numberAllNote{
            
            let setTitle="Title"+String(i)
            let setText="Text"+String(i)
            if let textViewScreen=userDefaultsNote.object(forKey: setText)
            {
                newTextNote=textViewScreen as! String
            }
            
            if let textFieldScreen=userDefaultsNote.object(forKey: setTitle)
            {
                newTitleNote=textFieldScreen as! String
            }
            
            
            let startNote=ModelNote(titleNote:newTitleNote, textNote:newTextNote)
            itemArray.append(startNote)
            //print(itemArray.count)
            }
        }
 

    }
    
    //создаем новую заметку
    @IBAction func NewNoteAction(_ sender: UIBarButtonItem) {
        let startNote=ModelNote(titleNote:"Я новая заметка!", textNote:"напишите сюда что-нибудь")
        itemArray.append(startNote)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: itemArray.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        

        let setTitle="Title"+String(numberAllNote)
        let setText="Text"+String(numberAllNote)
        userDefaultsNote.setValue(startNote.titleNote, forKey: setTitle)
        userDefaultsNote.setValue(startNote.textNote, forKey: setText)
        
        numberAllNote+=1
        userDefaultsNote.setValue(numberAllNote, forKey: "AllNote")
        
        
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyTableViewCell
        {
            let item = itemArray[indexPath.row]
            
            cell.titleNoteLabel.text=item.titleNote
            cell.textNoteLabel.text=item.textNote
            cell.backgroundColor = .yellow
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    //нажатие на заметку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "EditScreenNavigator") as! NavigationEdiitNoteController //UINavigationController
        
            let item = itemArray[indexPath.row]
            secondViewController.sendInfoTitle=item.titleNote
            secondViewController.sendInfoText=item.textNote
            secondViewController.sendInfoIndexNote = indexPath.row
            //secondViewController.sendNumberAllNote=numberAllNote
        
        
        
        self.present(secondViewController, animated:true, completion:nil)
        
    }
    
    //удаление заметки
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = itemArray[indexPath.row]
        func deleteAction(forRowAt indexPath: IndexPath)-> UIContextualAction{
            return UIContextualAction(style: .destructive, title: "Delete") { (_,_,_) in
                
                let startfor=indexPath.row
                
                if indexPath.row==self.numberAllNote-1{
                    self.itemArray.remove(at: indexPath.row)
                    
                    self.numberAllNote-=1
                    self.userDefaultsNote.setValue(self.numberAllNote, forKey: "AllNote")
                    
                    let deleteLastNoteTitle="Title"+String(indexPath.row)
                    self.userDefaultsNote.removeObject(forKey:deleteLastNoteTitle)
                    self.userDefaultsNote.removeSuite(named: deleteLastNoteTitle)
                    let deleteLastNoteText="Text"+String(indexPath.row)
                    self.userDefaultsNote.removeObject(forKey:deleteLastNoteText)
                    self.userDefaultsNote.removeSuite(named: deleteLastNoteText)
                    
                }
                else
                {
                    self.itemArray.remove(at: self.numberAllNote-1)
                    for i in startfor..<self.numberAllNote-1{
                        let setTitle="Title"+String(i+1)
                        let setTitleNew="Title"+String(i)
                        let setText="Title"+String(i+1)
                        let setTextNew="Title"+String(i)
                        self.userDefaultsNote.setValue(self.userDefaultsNote.object(forKey: setTitle), forKey: setTitleNew)
                        self.userDefaultsNote.setValue(self.userDefaultsNote.object(forKey: setText), forKey: setTextNew)
                    }
                    
                    let deleteLastNoteTitle="Title"+String(self.numberAllNote-1)
                    self.userDefaultsNote.removeObject(forKey:deleteLastNoteTitle)
                    self.userDefaultsNote.removeSuite(named: deleteLastNoteTitle)
                    let deleteLastNoteText="Text"+String(self.numberAllNote-1)
                    self.userDefaultsNote.removeObject(forKey:deleteLastNoteText)
                    self.userDefaultsNote.removeSuite(named: deleteLastNoteText)
                    
                    self.numberAllNote-=1
                    self.userDefaultsNote.setValue(self.numberAllNote, forKey: "AllNote")
                    
                }
 
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction(forRowAt: indexPath)])
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 

   
}
