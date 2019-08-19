//
//  NoteView.swift
//  Notes
//
//  Created by Alekx Zaliva on 1/15/19.
//  Copyright © 2019 ZalivaCor. All rights reserved.
//

import UIKit

class NoteView : UIView, UITextViewDelegate {
    
    let textView = UITextView()
    var noteService = NotesService()
    public var note : Notes?
    
    func createTextView() {
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textView)
        createContraint()
    }
    
    fileprivate func createContraint() {
        textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5) .isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5) .isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5) .isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5) .isActive = true
    }
    
    func updateData()  {
        if note != nil {
            textView.text = note?.text
        }
    }
}
