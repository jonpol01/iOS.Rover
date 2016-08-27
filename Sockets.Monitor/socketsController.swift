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

    let urlString = "http://localhost/usr/demo/iosmysql.php"

    @IBOutlet weak var netData: UILabel!


    var timer = NSTimer()
    var inp : NSInputStream?
    var out : NSOutputStream?


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
    
    @IBAction func closeButton(sender: AnyObject) {
    }

    @IBAction func fwdButton(sender: AnyObject) {
        socketWrite("1\n")
    }
    @IBAction func buttonReleased(sender: AnyObject) {
        socketWrite("0\n")
    }

    @IBAction func bckButton(sender: AnyObject) {
    }

    @IBAction func leftButton(sender: AnyObject) {
        socketWrite("3\n")
    }

    @IBAction func rightButton(sender: AnyObject) {
        socketWrite("4\n")
    }

    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("sockets"), userInfo: nil, repeats: true)
    }

    func loopData(){
 //       let test = NSUserDefaults.standardUserDefaults().stringForKey("readString");
 //       netData.text = test
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        request.HTTPMethod = "POST"

        let postString = "username=root&password=root&tablename=module_1"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                //Execute UI code immediately
                dispatch_async(dispatch_get_main_queue(), {
                    //                    self.labelRead.text = result as String
                    let teststring = result as String
                    var array = [Character](teststring.characters)
                    let strsplit = array.split("\t")
                    //print(strsplit[0])
                    var ip = String(strsplit[0])

                    self.netData.text = ip

                })
            } else {
                print(error)
            }
        })
        task.resume()
    }

    func sockets(){
        //        var ar: [String] = []
        //var buffer = [UInt8](count: 255, repeatedValue: 0)

        NSStream.getStreamsToHostWithName("192.168.42.1", port: 10000, inputStream: &inp, outputStream: &out)
//        if inp != nil && out != nil {
//            let inputStream : NSInputStream = inp!
//            inputStream.open()
//            let outputStream : NSOutputStream = out!
//            outputStream.open()

//            if outputStream.streamError == nil {
//                let queryString: String = "cmd> "
 //               let queryData: NSData = queryString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
 //               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                    while true {
//                        outputStream.write(UnsafePointer(queryData.bytes),maxLength:queryData.length)

/*                        if (readChars > 0) {
                        } else {
                            print ("server closed connection")
                            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "readString");
                            inputStream.close()
                            outputStream.close()
                            break
                        }*/
//                    }
//                })
//            } else {
//                print ("could not create socket")
//            }
//        } else {
//            print ("could not initialize stream")
//        }
        
    }

    func socketWrite(queryString: String) -> String {
        if inp != nil && out != nil {

            let inputStream : NSInputStream = inp!
            inputStream.open()
            let outputStream : NSOutputStream = out!
            outputStream.open()

            if outputStream.streamError == nil {
                let queryData: NSData = queryString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    outputStream.write(UnsafePointer(queryData.bytes),maxLength:queryData.length)
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
