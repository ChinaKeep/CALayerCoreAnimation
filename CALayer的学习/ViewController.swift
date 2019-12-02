//
//  ViewController.swift
//  CALayer的学习
//
//  Created by apple on 2019/11/28.
//  Copyright © 2019年 apple. All rights reserved.
//

import UIKit

let WIDTH : CGFloat = 150

class ViewController: UIViewController ,CALayerDelegate,UITableViewDelegate,UITableViewDataSource{
  
    var tableView : UITableView?
    var funcNamesArray : Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        self.tableView?.register(UINib.init(nibName: "FuncTableViewCell", bundle: nil), forCellReuseIdentifier: "FuncTableViewCell")
        self.funcNamesArray = ["基础动画","改变基础动画位置和动画组","CALayer显示视图 翻转问题","关键帧动画","动画组","转场动画","逐帧动画","UIView动画的封装"];
        let view = SFView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
//        self.view.addSubview(view)
        
// ------------------ 视图控制器 --------------------------
        let image = UIImage.init(named: "girl.png")
        let imageView = UIImageView.init(image: image)
        imageView.frame = CGRect.init(x: 120, y: 14, width: 80, height: 80)
//        self.view.addSubview(imageView)
        
        UIView .animate(withDuration: 1, delay: 2, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
            imageView.frame = CGRect.init(x: 80, y: 100, width: 160, height: 160)
        }) { (Bool) in
            
        }
        // ------------------ 视图控制器 --------------------------

      
    }
    

}


extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.funcNamesArray?.count ?? 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FuncTableViewCell") as? FuncTableViewCell
            else{
            return UITableViewCell()
        }
        cell.funcName?.text = self.funcNamesArray?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let basicVC = BasesicAnimationVC()
            self.navigationController?.pushViewController(basicVC, animated: true)
        case 1:
            let changeVC = ChangeAnimationLocationVC()
            self.navigationController?.pushViewController(changeVC, animated: true)
        case 2:
            let layerVC = LayerDrawVC()
            self.navigationController?.pushViewController(layerVC, animated: true)
        case 3:
            let keyframeVC = KeyFrameViewController()
            self.navigationController?.pushViewController(keyframeVC, animated: true)
        case 4:
            let groupVC = GroupAnimationViewController()
            self.navigationController?.pushViewController(groupVC, animated: true)
        case 5:
            let transitionVC = TransitionAnimationVC()
            self.navigationController?.pushViewController(transitionVC, animated: true)
        case 6:
            let displayVC = CADisplayLinkVC()
            self.navigationController?.pushViewController(displayVC, animated: true)
        case 7:
            let uiviewVC = UIVIewAnimationVC()
            self.navigationController?.pushViewController(uiviewVC, animated: true)
        default:
            print("没有了。。。。。。")
        }
    }
}
