//
//  ViewController.swift
//  Kakao_Test
//
//  Created by synlex on 2018. 4. 14..
//  Copyright © 2018년 synlex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var inputBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    var chatData: NSMutableArray! = ["Hi", "oh Hi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 외부에서 만든 셀 등록
        chatTableView.register(UINib(nibName: "MyBubbleTableViewCell", bundle: nil), forCellReuseIdentifier: "MyBubbleCell")
        
        chatTableView.register(UINib(nibName: "YourBubbleTableViewCell", bundle: nil), forCellReuseIdentifier: "YourBubbleCell")
        
        // 테이블 행 높이 자동 설정 되게 셋팅
        chatTableView.rowHeight = UITableViewAutomaticDimension
        
        // 키보드가 나올때 입력 텍스트뷰가 보이도록 하기 위한 처리
        // 키보드의 노티피케이션 등록 - 키보드가 보이기 진적
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
  
        // 키보드가 사라지기 직전
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // 키보드가 보일때 처리
    @objc func keyboardWillShow(noti: NSNotification) {
        // 키보드의 높이를 가져옴
        let notiInfo = noti.userInfo! as NSDictionary
        let keyboardFrame = notiInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let height = keyboardFrame.size.height
        
        // 키보드의 높이 만큼 텍스트뷰의 마진을 셋팅, 텍스트뷰가 자리잡고 나서 키보드가 올라옴 -> 부자연스러움
        inputBottomMargin.constant = height
        
        // 애니메이션 추가
        // 키보드의 움직이는 시간을 가져와서 그 시간만큼 텍스트뷰를 올라오게 하면 -> 자연스러움
        let animationDuration = notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            // 실시간 화면 업데이트
            self.view.layoutIfNeeded()
        }
    }
    
    // 키보드 사라질 경우 처리
    @objc func keyboardWillHide(noti: NSNotification) {
        
        inputBottomMargin.constant = 0
        
        let notiInfo = noti.userInfo! as NSDictionary
        let animationDuration = notiInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 입력 후 테이블에 반영
    @IBAction func textInputDone(_ sender: Any) {
        if inputTextView.hasText {
            chatData.add(inputTextView.text)
            
            chatTableView.reloadData()
            
            // 테이블 마지막 행으로 스크롤
            let lastIndexPath = NSIndexPath(row: chatData.count - 1, section: 0) as IndexPath
            
            // 중요 - 가끔 스크롤 이동이 안될 경우 있어서 넣는다
            // 레이아웃 업데이트가 자동적으로 잘 적용이 안될 경우가 있어서 필요함
            // 아래에서 함
            //self.view.layoutIfNeeded()
            
            chatTableView.scrollToRow(at: lastIndexPath, at: UITableViewScrollPosition.bottom, animated: false)
            
            inputTextView.text = ""
            
            //입력창 1줄로 다시 셋팅
            // 전송되면 높이 계산 다시함
            textViewDidChange(inputTextView)
            
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        print("textview height: \(textView.contentSize.height)")
        
        //4줄까지만 늘어나도록(스크롤) 함 ---- TODO 가변적으로 처리해야 할듯....
        if textView.contentSize.height < 83 {
            textViewHeight.constant = textView.contentSize.height
        
            //스크롤 될때, 맨 위가 첫번째 행에 맞춰 나오도록 - 적절한 위치 지정
            textView.setContentOffset(CGPoint.zero, animated: false)
        }
        
        self.view.layoutIfNeeded()
        
    }
    
    
    // 키보드 사라지게 함 - 이렇게 잘 사용안함, 그럼 어떻게??
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    
    // 테이블 행 높이 자동 설정 되게 셋팅
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell: UITableViewCell
        
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourBubbleCell", for: indexPath) as! YourBubbleTableViewCell
            
            cell.bubbleText.text = (chatData[indexPath.row] as! String)
            
            defaultCell = cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyBubbleCell", for: indexPath) as! MyBubbleTableViewCell
            
            cell.bubbleText.text = (chatData[indexPath.row] as! String)
            
            defaultCell = cell
        }
        
        defaultCell.selectionStyle = UITableViewCellSelectionStyle.none
    
        return defaultCell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

