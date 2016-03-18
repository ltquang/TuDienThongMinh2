//
//  ViewController.swift
//  TuDienThongMinh
//
//  Created by namlongIOS on 3/18/16.
//  Copyright © 2016 namlong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var result:[String] = []
    
    @IBOutlet weak var tvInputtext: UITextView!
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var lineBreak: UIView!
    
    @IBOutlet weak var tbResult: UITableView!
    
    
    //API key = RQLHQA-T595KWKR8Q
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lineBreak.backgroundColor = UIColor(patternImage: UIImage(named: "line_Left_Menu")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func parseNLP(inputString: String)
    {
        let options = NSLinguisticTaggerOptions.OmitWhitespace.rawValue | NSLinguisticTaggerOptions.JoinNames.rawValue
        let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemesForLanguage("en"), options: Int(options))
        
        
        tagger.string = inputString
        
        let range = NSMakeRange(0, inputString.characters.count)
        
        self.result.removeAll()
        
        tagger.enumerateTagsInRange(range, scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass, options: NSLinguisticTaggerOptions(rawValue: options)) { tag, tokenRange, sentenceRange, stop in
            let token = (inputString as NSString).substringWithRange(tokenRange)
            print("\(token): \(tag)")
            self.result.append("\(token): \(tag)")
        }
    }
    
//    func rangeFromNSRange(nsRange: NSRange, forString str: String) -> Range<String.Index>? {
//        if let from = String.Index(str.utf16.startIndex + nsRange.location, within: str),
//            let to = String.Index(str.utf16.startIndex + nsRange.location + nsRange.length, within: str) {
//                return from ..< to
//        }
//        
//        return nil
//    }
    
    @IBAction func touchOnTran(sender: AnyObject) {
        let inputString = tvInputtext.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if inputString.isEmpty
        {
            return
        }
        //        let token = inputString.substringWithRange(rangeFromNSRange(tokenRange, forString: inputString)!)
        self.parseNLP(inputString)
        self.tbResult.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! UITVCellCustomResult
        cell.lbResult.text = result[indexPath.row]
        cell.lineBreak.backgroundColor = UIColor(patternImage: UIImage(named: "line_Left_Menu")!)
        return cell
    }
}

