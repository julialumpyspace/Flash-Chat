//
//  ViewController.swift
//  Flash Chat
//
//  Created by Юлія Воробей on 17.04.2024.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let authManager = AuthManager()
    let fstoreManager = FStoreManager()
    let messageManager = MessageManager()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.AppTitle
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.CellNib_ID, bundle: nil), forCellReuseIdentifier: K.TableCell_ID)
        
        authManager.addObserver(self)
        fstoreManager.addObserver(self)
        
        fstoreManager.get()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        authManager.removeObserver(self)
        fstoreManager.removeObserver(self)
    }
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        authManager.logout()
    }
    
    @IBAction func sendPressed(_ sender: UIButton)  {
        if let message = messageManager.createMessage(message: messageTextField.text) {
            fstoreManager.add(message: message)
        }
    }
}


// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCell_ID, for: indexPath) as! MessageCell
        cell.emailLabel.text = messages[indexPath.row].sender
        cell.messageLabel.text = messages[indexPath.row].body
        setUserTheme(cell: cell, message: messages[indexPath.row])
        return cell
    }
    
    func setUserTheme (cell: MessageCell, message: Message) {
        let emailText = cell.emailLabel.text
        
        if message.sender == authManager.getAuthorizedUser() {
            cell.messageBubble.backgroundColor = UIColor(named: "BrandBlue")
            cell.timeLabel.textAlignment = NSTextAlignment.left
            cell.emailLabel.textAlignment = NSTextAlignment.right
            cell.emailLabel.text = "me: " + emailText!
            
            cell.leftBubbleConstraint.constant = 60
            cell.leftTimeConstraint.constant = 60
        
        } else {
            cell.emailLabel.text = "user: " + emailText!
            
            cell.rightBubbleConstraint.constant = 60
            cell.rightTimeConstraint.constant = 60
        }
    }
}


// MARK: - AuthObserver

extension ChatViewController: AuthObserver {
    func logoutDidFinish(response: AuthResponse) {
        if response.error.error {
            print(response.error.message)
        } else {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}


// MARK: - FStoreObserver

extension ChatViewController: FStoreObserver {
    func addMessageDidFinish(response: FStoreMessageResponse) {
        if response.error.error {
            print(response.error.message)
        } else {
            DispatchQueue.main.async {
                self.messageTextField.text = ""
            }
        }
    }
    
    func getMessagesDidFinish(response: FStoreMessageResponse) {
        if response.error.error {
            print(response.error.message)
        } else {
            if response.result != nil {
                DispatchQueue.main.async {
                    self.messages = response.result!
                    self.tableView.reloadData()
                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            }
        }
    }
}

