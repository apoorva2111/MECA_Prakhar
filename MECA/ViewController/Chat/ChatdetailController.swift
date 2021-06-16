//
//  ChatViewController.swift
//  MECA
//
//  Created by Macbook  on 25/05/21.
//

import UIKit
import Firebase
import JSQMessagesViewController
import SDWebImage
import FirebaseAuth


class bottomCorners: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:[.bottomRight, .bottomLeft], cornerRadii: CGSize(width: 11, height: 11))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        
    }
}


class ChatdetailController: UIViewController {
    
    var param : [String:Any] = [:]
    var chatvalue:[Chat] = []
    //var chatvalue = [chatdetailsdata]()
    @IBOutlet weak var  topview:UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var chatCollView: bottomCorners!
    @IBOutlet var inputViewContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet var chatTF: UITextField!
    var myArray = [Any]()
    public var chatsArray: [Chat] = []
    var  message: String = ""
    var basetype : String =  ""
    var chatroomid : Int =  0
    var chat_type : Int = 0
    var chatroom_id:Int = 0
    
    var oppName :String = ""
    var oppImage: String = ""
    var oppId: Int = 0
    var isOneToOne = true
    let selfID =  userDef.string(forKey: UserDefaultKey.userId)!
    
    var observe: UInt?
    @IBOutlet weak var titlelbl:UILabel!
    @IBOutlet weak var titleimg:UIImageView!
    @IBOutlet weak var titleview:RCustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlelbl.text! = oppName
        if oppImage != "" {
            let imgurl = BaseURL + oppImage
            self.titleimg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.titleimg.sd_setImage(with: URL.init(string: imgurl), completed: nil)
        }
        self.assignDelegates()
        self.manageInputEventsForTheSubViews()
        let fireemail = userDef.string(forKey: UserDefaultKey.firebaseemail)
        let fireepass = userDef.string(forKey: UserDefaultKey.firebasepassword)
        Auth.auth().signIn(withEmail: fireemail!,
                           password: fireepass!)
        getFollowingData()
        setupUI()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI()  {
        
        topview.layer.cornerRadius = topview.frame.size.width/2
        topview.clipsToBounds = true
        titleimg.layer.borderWidth = 1
        titleimg.layer.masksToBounds = false
        titleimg.layer.borderColor = UIColor.white.cgColor
        titleimg.layer.cornerRadius = titleimg.frame.height/2 //This will change with corners of image and height/2 will make this circle shape
        titleimg.clipsToBounds = true
        
        //topview shadow
        
        topview.layer.borderColor = UIColor.hexStringToUIColor(hex:"#26478D").cgColor
        topview.layer.borderWidth = 2.0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.fetchChatData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let ref = Database.database().reference().child(basetype).child(String(chatroom_id))
        ref.removeAllObservers()
    }
    
    
    func makeItems(from snapshot: DataSnapshot) -> [chatdetailsdata] {
        let items = [chatdetailsdata]()
        if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
            for snap in snapshots {
                if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                    print(postDictionary)
                }
            }
        }
        return items
    }
    
    private func manageInputEventsForTheSubViews() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardFrameChangeNotfHandler(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            inputViewContainerBottomConstraint.constant = isKeyboardShowing ? keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                if isKeyboardShowing {
                    self.scrollToBottom()
                }
            })
        }
    }
    
    func scrollToBottom() {
        let y = self.chatCollView.contentSize.height - self.chatCollView.frame.height
        self.chatCollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
    }
    
    func getFollowingData() {
        print("chat-type... \(basetype)...\(chatroom_id)")
        let ref = Database.database().reference().child(basetype).child(String(chatroom_id))
        observe = ref.observe(DataEventType.value) {(snapshot) in
            guard snapshot.childrenCount > 0 else { return }
            for transactions in snapshot.children.allObjects as! [DataSnapshot] {
                print("transactions....\(transactions)")
                
                let position = transactions
                
                guard let positionsInfo = position.value as? [String: Any] else { continue }
                print("position.key ... \(position.key)")
                let obj = positionsInfo as NSDictionary
                print("positionsInfo....\(obj)")
                
                print("positionsInfo(position.key)....\((positionsInfo[position.key] as? [String:Any])?.description ?? "")")
                if let objDict = Chat(dictionary: obj), self.chatvalue.firstIndex(where: {$0.created_at == objDict.created_at}) == nil {
                    self.chatvalue.append(objDict)
                }
            }
            self.chatCollView.reloadData()
            DispatchQueue.main.async {
                self.scrollToBottom()
            }
            ref.child("unread").child(self.selfID).setValue(0)
        }
    }
    
    private func assignDelegates() {
        self.chatCollView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        self.chatCollView.dataSource = self
        self.chatCollView.delegate = self
        
        self.chatTF.delegate = self
    }
    
    @IBAction func onSendChat(_ sender: UIButton?) {
        
        guard let chatText = chatTF.text, chatText.count >= 1 else { return }
        chatTF.text = ""
//        let chat = Chat.init(user_name: "Krish", user_image_url: "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2552&q=80", is_sent_by_me: false, text: chatText)
        let loggedinusername = userDef.string(forKey: UserDefaultKey.loggedusername)!
        
        let timestamp = Date().currentTimeMillis()
        let loggedinavatar =  userDef.string(forKey: UserDefaultKey.firebaseavatar)!
        
        let userData = ["user_id": Int(selfID)!  ,
                        "message": chatText as String,
                        "username": loggedinusername,
                        "isadmin" : 0,
                        "avatar" : loggedinavatar,
                        "isfile" : "",
                        "fileurl" : "",
                        "created_at" : timestamp
        ] as [String : Any]
        
        print("userData ...\(userData)")
        let ref = Database.database().reference()
        ref.child(basetype).child(String(chatroom_id)).childByAutoId().setValue(userData)
        ref.child(basetype).child(String(chatroom_id)).child("unread").child("\(oppId)").setValue(ServerValue.increment(1))
        
//        self.fetchChatData()
//
//        self.chatsArray.append(chat)
//        self.chatCollView.reloadData()
//
//        let lastItem = self.chatvalue.count - 1
//        let indexPath = IndexPath(item: lastItem, section: 0)
//        self.chatCollView.insertItems(at: [indexPath])
        
        scrollToBottom()
        CallWebserviceChatroomupdateapicall(id: chatroom_id, type: chat_type)
    }
    
    //chatroom api call
    func CallWebserviceChatroomupdateapicall(id: Int,type: Int) {
        
        param = [ :
        ]
        print("param\(param)")
        //param["keyword": "", "type": "", "sortorder": "", "sortkey": ""]
        
//        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForChatrroomupdate(id:id, type: type, params: param) { (result) in
            
            if let respCode = result.resp_code{
                
                if respCode == 200{
//                    GlobalObj.displayLoader(true, show: false)
                } else {
//                    GlobalObj.displayLoader(true, show: false)
                }
            }
//            GlobalObj.displayLoader(true, show: false)
        }
    }
}


extension ChatdetailController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.chatvalue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = chatCollView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell else { return ChatCell() }
            
        let chatdetailvalue = self.chatvalue[indexPath.item]
        
        let message = chatdetailvalue.message ?? ""
        let username = chatdetailvalue.user_name ?? ""
        let avatar = chatdetailvalue.avatar
        cell.messageTextView.text = message
        cell.nameLabel.text = username
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        var estimatedFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        estimatedFrame.size.height += 18
        
        let nameSize = NSString(string: username).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
        
        let maxValue = max(estimatedFrame.width, nameSize.width)
        estimatedFrame.size.width = maxValue
        
        
        let user_id = chatdetailvalue.user_id!
        
        userDef.setValue(avatar, forKey: UserDefaultKey.firebaseavatar)
        
        cell.nameLabel.isHidden = isOneToOne
        cell.profileImageView.isHidden = isOneToOne
        //cell.profileImageURL = URL.init(string: chat.user_image_url)!
        
        let userid = Int(selfID)!
        print("username\(username)", "databse ...\(user_id) loginuser \(userid)")
        if user_id != userid {
            print("username\(username)", "receiver...\(String(describing: message))")
            cell.bubbleImageView.image = ChatCell.grayBubbleImage
            cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
            cell.messageTextView.textColor = UIColor.black
            
            cell.nameLabel.textAlignment = .right
            cell.nameLabel.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: 18)
            cell.profileImageView.frame = CGRect(x: 8, y: estimatedFrame.height - 8, width: 30, height: 30)
           
            if isOneToOne {
                cell.messageTextView.frame = CGRect(x: 18 + 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: 18 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
            } else {
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
            }
        } else {
            print("username...\(username)", "sender... \(String(describing: message))")
//            let message = chatdetailvalue.message
//            let username = chatdetailvalue.user_name
//            let avatar = chatdetailvalue.avatar
//            print("username\(username)")
//            cell.messageTextView.text = message
//            cell.nameLabel.text = username
//            let size = CGSize(width: 250, height: 1000)
//            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//            var estimatedFrame = NSString(string: message!).boundingRect(with: size, options: options,
//                                        attributes: [.font: UIFont.systemFont(ofSize: 18)], context: nil)
//            let nameSize = NSString(string: username!).boundingRect(with: size, options: options,
//                                    attributes: [.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
//            estimatedFrame.size.height += 18
//            estimatedFrame.size.width = max(estimatedFrame.width, nameSize.width
            userDef.setValue(avatar, forKey: UserDefaultKey.firebaseavatar)
            cell.bubbleImageView.image = ChatCell.blueBubbleImage
            cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
            cell.messageTextView.textColor = UIColor.white
            
            cell.nameLabel.textAlignment = .left
            cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 10 - 16 - 8 - 30 - 12, y: 0, width: estimatedFrame.width + 16, height: 18)
            cell.profileImageView.frame = CGRect(x: self.chatCollView.bounds.width - 38, y: estimatedFrame.height - 8, width: 30, height: 30)
            
            if isOneToOne {
                cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
            } else {
                cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let chatdetailvalue = self.chatvalue[indexPath.item]
        
        let avatar = chatdetailvalue.avatar
        
        if let chatCell = cell as? ChatCell {
            if avatar != "" {
                let imgUrl = BaseURL + (avatar!)
//                chatCell.profileImageURL.sd_imageIndicator = SDWebImageActivityIndicator.gray
//                chatCell.profileImageURL.sd_setImage(with: URL(string: imgUrl), completed: nil)
                chatCell.profileImageURL = URL.init(string: imgUrl)!
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chatdetailvalue = self.chatvalue[indexPath.item]
        
        message = chatdetailvalue.message ?? ""
        
        // let chat = myArray[indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        var estimatedFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        estimatedFrame.size.height += 18
        
        return CGSize(width: chatCollView.frame.width, height: estimatedFrame.height + 20)
    }
}

extension ChatdetailController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txt = textField.text, txt.count >= 1 {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        onSendChat(nil)
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

extension UICollectionView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

