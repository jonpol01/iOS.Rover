//
//  socketsController.swift
//  Sockets.Monitor
//
//  Created by John Paul Soliva on 6/9/16.
//  Copyright © 2016 Soliva John Paul. All rights reserved.
//

import UIKit
import Foundation

class socketsController: UIViewController {

    @IBOutlet weak var netData: UILabel!

    var timer = Timer()
    var inp : InputStream?
    var out : OutputStream?

    override func viewDidLoad() {
        super.viewDidLoad()
        sockets();
        //scheduledTimerWithTimeInterval()
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButton(_ sender: AnyObject) {
        let inputCloseStream : InputStream = inp!
        let outputCloseStream : OutputStream = out!
        inputCloseStream.close()
        outputCloseStream.close()
    }

    @IBAction func fwdButton(_ sender: AnyObject) {
        socketWrite("1\n")
    }
    @IBAction func buttonReleased(_ sender: AnyObject) {
        socketWrite("0\n")
    }

    @IBAction func bckButton(_ sender: AnyObject) {
        socketWrite("-1\n");
    }

    @IBAction func leftButton(_ sender: AnyObject) {
        socketWrite("3\n")
    }

    @IBAction func rightButton(_ sender: AnyObject) {
        socketWrite("4\n")
    }

    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(socketsController.sockets), userInfo: nil, repeats: true)
    }

    func sockets(){
        // debug
        Stream.getStreamsToHost(withName: "localhost", port: 10000, inputStream: &inp, outputStream: &out)
        // Rovers IP address
        //Stream.getStreamsToHost(withName: "192.168.42.1", port: 10000, inputStream: &inp, outputStream: &out)
    }

    func socketWrite(_ queryString: String) -> String {
        if inp != nil && out != nil {

            let inputStream : InputStream = inp!
            inputStream.open()
            let outputStream : OutputStream = out!
            outputStream.open()

            if outputStream.streamError == nil {
                let queryData: Data = queryString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
                DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
                    outputStream.write((queryData as NSData).bytes.bindMemory(to: UInt8.self, capacity: queryData.count),maxLength:queryData.count)
                })
            }else {
                print ("could not create socket")
            }
        }else{
            print ("could not initialize stream")
        }

        return queryString
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
