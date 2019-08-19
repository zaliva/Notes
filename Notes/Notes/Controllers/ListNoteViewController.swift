//
//  ListNoteViewController.swift
//  Notes
//
//  Created by Alekx Zaliva on 1/15/19.
//  Copyright © 2019 ZalivaCor. All rights reserved.
//

import UIKit
import ReplayKit

class ListNoteViewController: UIViewController, ListNoteDelegate, RPPreviewViewControllerDelegate {

    var presenter = NotePresenter(notesService: NotesService())
    var listNoteView = ListNoteView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        presenter.attachView(view: listNoteView)
        
//        navigationController?.navigationBar.isHidden = false
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(startRecording))

    }
    
    
    @objc func startRecording() {
        let recorder = RPScreenRecorder.shared()
        
        recorder.startRecording{ [unowned self] (error) in
            if let unwrappedError = error {
                print(unwrappedError.localizedDescription)
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stop", style: .plain, target: self, action: #selector(self.stopRecording))
            }
        }
    }
    
    @objc func stopRecording() {
        let recorder = RPScreenRecorder.shared()
        
        recorder.stopRecording { [unowned self] (preview, error) in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(self.startRecording))
            
            if let unwrappedPreview = preview {
                unwrappedPreview.previewControllerDelegate = self
                self.present(unwrappedPreview, animated: true)
            }
        }
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.updateData()
    }

    //MARK : - configureView
    
    func configureView () {
        self.title = "List of Notes"
        self.view.clipsToBounds = true
        
        self.listNoteView.translatesAutoresizingMaskIntoConstraints = false
        self.listNoteView.delegate = self
        view.addSubview(self.listNoteView)
        createConstraint()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }
    
    func createConstraint() {
        self.listNoteView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0) .isActive = true
        self.listNoteView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0) .isActive = true
        self.listNoteView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0) .isActive = true
        self.listNoteView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0) .isActive = true
    }
    
    //MARK : - ListNoteDelegate
    
    func showNote(note: Notes) {
        presenter.showNoteViewController(controller: self, note: note)
    }
    
    //MARK : - action
    
    @objc func addTapped() {
        presenter.showNewNote(controller: self)
    }
}
