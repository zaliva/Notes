//
//  NoteViewController.swift
//  Notes
//
//  Created by Alekx Zaliva on 1/15/19.
//  Copyright © 2019 ZalivaCor. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    public var note : Notes?
    
    var presenter = NotePresenter(notesService: NotesService())
    var noteView = NoteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        if note != nil {
            noteView.note = self.note
        }
        
        presenter.attachNoteView(view: noteView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
    }
    
    //MARK : - action
    
    @objc func saveData()  {
        let service = NotesService()
        if note != nil {
            service.updateNote(note: note!, text: self.noteView.textView.text)
        } else {
            service.saveNote(text: self.noteView.textView.text)
        }
        
        presenter.backToPrevView(controller: self)
    }
    
    //MARK : - configureView
    
    func configureView () {
        if note != nil {
            self.title = "Edit Note"
        }
        else {
            self.title = "New Note"
        }
        
        self.view.clipsToBounds = true
        
        self.noteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.noteView)
        createConstraint()
    }
    
    func createConstraint() {
        self.noteView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0) .isActive = true
        self.noteView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0) .isActive = true
        self.noteView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0) .isActive = true
        self.noteView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0) .isActive = true
    }
}
