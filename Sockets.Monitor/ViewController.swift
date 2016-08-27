//
//  ViewController.swift
//  Sockets.Monitor
//
//  Created by John Paul Soliva on 6/8/16.
//  Copyright © 2016 Soliva John Paul. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

//    let urlString = "http://localhost/usr/demo/iosmysql.php"

    @IBOutlet weak var addr_Input: UITextField!
    @IBOutlet weak var data1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        data1.text = "test"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var inp : NSInputStream?
    var out : NSOutputStream?
    @IBAction func connectButton(sender: AnyObject) {
    }

    @IBAction func connectButton_up(sender: AnyObject) {
//        let addr = "localhost"
//        let addr = "192.9.200.125"
//        let port = 50000
//        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
//        sockets()
        let urlstring = addr_Input.text


    }


}

