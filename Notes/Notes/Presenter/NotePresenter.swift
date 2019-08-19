//
//  NotePresenter.swift
//  Notes
//
//  Created by Alekx Zaliva on 1/15/19.
//  Copyright © 2019 ZalivaCor. All rights reserved.
//

import Foundation

class NotePresenter : NSObject {

    private let notesService : NotesService
    weak private var listNoteView: ListNoteView?
    weak private var noteView : NoteView?
    
    init(notesService: NotesService) {
        self.notesService = notesService
        
    }
    
    func attachView(view: ListNoteView) {
        self.listNoteView = view
        self.listNoteView?.createTable()
        self.updateData()
    }
    
    func attachNoteView(view: NoteView)  {
        self.noteView = view
        self.noteView?.createTextView()
        self.noteView?.updateData()
    }
    
    func updateData ()
    {
         self.listNoteView?.updateView()
    }

    func showNoteViewController(controller : Any, note : Notes) {
        let ctrl = NoteViewController()
        ctrl.note = note
        let listNoteCtrl = controller as! ListNoteViewController
        listNoteCtrl.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func showNewNote(controller : Any) {
        let ctrl = NoteViewController()
        let listNoteCtrl = controller as! ListNoteViewController
        listNoteCtrl.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func backToPrevView (controller : Any)
    {
        let listNoteCtrl = controller as! NoteViewController
        listNoteCtrl.navigationController?.popViewController(animated: true)
    }
    
}
