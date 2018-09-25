//
//  ViewController.swift
//  TestProject
//
//  Created by Alex Liu on 2017-10-16.
//  Copyright © 2017 Alex Liu. All rights reserved.
//

import UIKit
extension String {
    func indexDistance(of character: Character) -> Int? {
        guard let index = index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.imageView.setImage(str: "AL", bgColor: UIColor.red)
//        self.setLabel2Content()
//        self.bgLabel1.text = "123 \n 123"
        
        Loader()
    }
    
    @IBOutlet weak var bgLabel2: UILabel!
    @IBOutlet weak var bgLabel1: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    let content: [String] = ["Consent line 1 \nConsent line 2", "This is first line this is second line. what is the second line \nLast updated Jan 9, 2018, 200"]
    var myMutableString = NSMutableAttributedString()
    
    func setLabel2Content()
    {
        myMutableString = NSMutableAttributedString(string: content[1], attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 13.0)!])
        let indexOfNewLine = content[1].indexDistance(of: "\n")
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.yellow, range: NSRange(location:indexOfNewLine!, length:13))
        // set label Attribute
        self.contentLabel.attributedText = myMutableString
    }
    
    @IBAction func animate(_ sender: Any) {
        self.animate1()
    }
    func animate2()
    {
        let fadeTransition = CATransition()
        fadeTransition.duration = 0.5
        fadeTransition.type = kCATransitionPush
        fadeTransition.subtype = kCATransitionFromBottom
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            if self.bgLabel1.text == self.content[0]
            {
                self.bgLabel1.text = self.content[1]
            }
            else
            {
                self.bgLabel1.text = self.content[0]
            }
            if self.bgLabel2.text == ""
            {
                self.setLabel2Content()
            }
            else
            {
                self.bgLabel2.text = ""
            }
            self.bgView.layer.add(fadeTransition, forKey: kCATransition)
        })
        
        CATransaction.commit()
    }
    func animate1()
    {
        let fadeTransition = CATransition()
        fadeTransition.duration = 1.0
        fadeTransition.type = kCATransitionPush
        fadeTransition.subtype = kCATransitionFromBottom
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            if self.contentLabel.text == self.content[0]
            {
                self.setLabel2Content()
            }
            else
            {
                self.contentLabel.text = self.content[0]
            }
            self.contentLabel.layer.add(fadeTransition, forKey: kCATransition)
        })
        
        CATransaction.commit()
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.widthAnchor.constraint(equalToConstant: 90).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        
    }

    var cellExpanded: [Bool] = [true, true ,true]
    var tripsArray = ["Trip1","Trip2","Trip3","Trip4","Trip5","Trip6"]
    var dataArray = [["Trip1", "expense1", "expense2", "total1"],
                     ["Trip2", "expense1", "expense2", "total2"],
                     ["Trip3", "expense1", "expense2", "total3"]]
    func setupData(index: Int, newState:Bool)
    {
        if newState // means cellExpanded, then reload this index section
        {
            let nameArray = ["Trip1", "total1"]
            dataArray[index] = nameArray
        }
        else
        {
            let nameArray = ["Trip1", "expense1", "expense2", "total1"]
            dataArray[index] = nameArray
        }
    }
}
extension ViewController: UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataArray[indexPath.section][indexPath.row]
        if indexPath.row == 0
        {
            cell.backgroundColor = UIColor.lightGray
        }
        
        if indexPath.row == self.dataArray[indexPath.section].count - 1
        {
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            cellExpanded[indexPath.section] = !cellExpanded[indexPath.section]
            self.setupData(index: indexPath.section, newState: cellExpanded[indexPath.section])
            self.tableView.beginUpdates()
            let indexSets: IndexSet = IndexSet(integer: indexPath.section)
            self.tableView.reloadSections(indexSets, with: .fade)
            self.tableView.endUpdates()
        }
    }
}

extension UIImageView {
    private func imageCroppingBezierPath(text: String, backgroundColor: UIColor, textAttributes: [NSAttributedStringKey : Any]?) -> UIImage? {
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let newPath = CGPath(ellipseIn: self.bounds, transform: nil)
        context?.addPath(newPath)
        context?.clip()
        self.draw(frame)
        context?.setFillColor(backgroundColor.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        context?.restoreGState()
        
        let bounds = self.bounds
        let drawText = text as NSString
        let textSize = drawText.size(withAttributes: textAttributes)

        drawText.draw(in: CGRect(x: bounds.width/2 - textSize.width/2, y: bounds.height/2 - textSize.height/2, width: textSize.width, height: textSize.height), withAttributes: textAttributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func setImage(str: String, textAttributes: [NSAttributedStringKey : Any]? = nil)
    {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map({ String($0) })
        let hexColorArray = ["F44336", "E91E63", "9C27B0", "673AB7", "3F51B5", "2196F3", "00BCD4", "009688", "4CAF50", "8BC34A", "CDDC39", "FFC107", "FF9800", "FF5722", "795548", "B71C1C", "880E4F", "4A148C", "311B92", "827717", "0D47A1", "33691E", "004D40", "FF6F00", "E65100", "5D4037", "616161"]
        var color = UIColor.gray
        if str.count != 0
        {
            //let firstLetter = str[0]
            let index = alphabet.index(of: str)
        }
        
        self.setImage(str: str, bgColor: color, textAttributes: textAttributes)
    }
    
    func setImage(str: String, bgColor: UIColor, textAttributes: [NSAttributedStringKey : Any]? = nil)
    {
        if textAttributes == nil
        {
            let textFontAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            self.image = self.imageCroppingBezierPath(text: str, backgroundColor: bgColor, textAttributes: textFontAttributes)
        }
        else
        {
            self.image = self.imageCroppingBezierPath(text: str, backgroundColor: bgColor, textAttributes: textAttributes)
        }
    }
    
}
