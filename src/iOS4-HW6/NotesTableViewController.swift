//
//  NotesTableViewController.swift
//  iOS4-HW6
//
//  Created by Kathryn Rotondo on 2/15/16.
//  Copyright © 2016 Kathryn Rotondo. All rights reserved.
//

// @TODO 1: In the .xcdatamodeld file, create an entity "Note" with one attribute, "text" which is a String.
// @TODO 2: Create an NSManagedObject subclass (Editor > )
// @TODO 3: Add context helper function to AppDelegate.swift

import UIKit
// @TODO 4: import CoreData
import CoreData

class NotesTableViewController: UITableViewController, NoteDelegate {
    
    // @TODO 5: add a reference to the sharedContext
    let managedContext = sharedContext()
    
    // @TODO: note! you'll need to change this app from using Strings to using Notes
    var notes:[Note] = []
    // var notes:[Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Core Data
    
    // @TODO 6: save the data to disk
    func saveData(note:String) {
        // create a new managed object
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: managedContext)
        
        // and insert it into the context
        let noteToSave = Note(entity:entity!, insertIntoManagedObjectContext: managedContext)
        
        // set its attributes
        noteToSave.text = note
        
        // commit changes to disk
        do {
            try managedContext.save()
            notes.append(noteToSave)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // @TODO 7: load the data from disk
    func loadData() {
        // create fetch request
        let fetchRequest = NSFetchRequest(entityName: "Note")
        
        // ask managedcontext to make the request
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
        // if successful store result
            notes = results as! [Note]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    // MARK: - Note Delegate
    
    func saveNote(note: String) {
        saveData(note)
        // @TODO: n.b. these two lines may move
//        notes.append(note)
        tableView.reloadData()
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCellIdentifier", forIndexPath: indexPath)
        
        // Configures the cell...
        
        // @TODO: once you change the notes array to use Note instead of String, you'll need to toggle the below two blocks

        // @TODO: USE THIS BLOCK WITH STRING
//        let note = notes[indexPath.row]
//        let minimum = min(20, note.characters.count)
//        let breakIndex = note.startIndex.advancedBy(minimum)
//        cell.textLabel?.text = note.substringToIndex(breakIndex)
//        cell.detailTextLabel?.text = note.substringFromIndex(breakIndex)
        
        // @TODO USE THIS BLOCK WITH NOTE
        if let text = notes[indexPath.row].text {
            let minimum = min(20, text.characters.count)
            let breakIndex = text.startIndex.advancedBy(minimum)
            cell.textLabel?.text = text.substringToIndex(breakIndex)
            cell.detailTextLabel?.text = text.substringFromIndex(breakIndex)
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            managedContext.deleteObject(notes[indexPath.row])
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not delete. Error: \(error)")
            }
            notes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            
        case .Insert:
            break
             
        default:
            break
        }
        
        
    }
   
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Gets the new view controller
        let addNoteVC = segue.destinationViewController as! AddNoteViewController
        
        // Passes self as NoteDelegate to the new view controller
        addNoteVC.delegate = self
    }
    
}
