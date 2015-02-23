//
//  ViewController.swift
//  sample_readHymlShow
//
//  Created by test on 2015/02/17.
//  Copyright (c) 2015年 Noriyasu Katano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //ダウンロードボタン
    @IBAction func Download(sender: AnyObject) {
        
        println("ボタン押下")
        
        //阿呆の一生をダウンロードURL
        let newsUrlString = "http://www.aozora.gr.jp/cards/000879/files/19_14618.html"
        
        //NSURLを作る
        var url = NSURL(string: newsUrlString)!
        var request = NSURLRequest(URL: url)
        
        //データをダウンロードする
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse:nil, error:nil)
        var htmlString = NSString(data:data!, encoding:NSShiftJISStringEncoding)!
        
        //パスの取得
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as Array<String>
        
        //保存するファイルの名前
        let filePath = String(paths[0]) + "data.html"
        
        //保存するデータ
        let array = [htmlString]
        //.componentsJoinedByString("\n")
        
        //アーカイブしてdata.datというファイル名で保存する
        let successful = NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
        /*if successful{
            println("成功")
        }*/
        
    }
    
    //ファイルを開く
    @IBAction func openFile(sender: AnyObject) {

        //performSegueWithIdentifier("goSecondViewSegue", sender: filePath)
    }
    
    
    /*
    * SecondViewから戻ってきた時の処理
    */
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        NSLog("FirstViewController#backFromSecondView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //画面遷移
    var paramText:String = "aaaa"
}

