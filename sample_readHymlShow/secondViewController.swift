//
//  secondViewController.swift
//  sample_readHymlShow
//
//  Created by test on 2015/02/18.
//  Copyright (c) 2015年 Noriyasu Katano. All rights reserved.
//

import CoreText
import UIKit

class secondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = View()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    class View: UIView {
       var htmlText = "" //HTMLのテキスト初期化
        override func drawRect(rect: CGRect) {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                .UserDomainMask, true) as Array<String>
            let filePath = String(paths[0]) + "data.html"
            if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? Array<String>{
                htmlText = array[0]
            }
            
            
            var height = 28.0
            var settings = [
                CTParagraphStyleSetting(
                    spec: .MinimumLineHeight,
                    valueSize: UInt(sizeofValue(height)),
                    value: &height)
            ]
            let style = CTParagraphStyleCreate(settings, UInt(settings.count))
        
            
            var err:NSError?
            var nsstringHtml = NSMutableAttributedString(
                data: htmlText.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType ],
                documentAttributes: nil,
                error: &err)
            
            let attributedText = NSMutableAttributedString(attributedString: nsstringHtml!)

           attributedText.addAttributes([
                NSFontAttributeName: UIFont(name: "HiraMinProN-W3", size: 14.0)!,
                NSVerticalGlyphFormAttributeName: true,
                kCTParagraphStyleAttributeName: style,
                ],
                range: NSMakeRange(0, attributedText.length))

            let context = UIGraphicsGetCurrentContext()
            
            CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0) //塗りつぶしの色を設定します。
            CGContextAddRect(context, rect) //要素の追加
            CGContextFillPath(context) //面の塗りつぶし
            
            CGContextRotateCTM(context, CGFloat(M_PI_2)) //横置きと縦置きの設定
            CGContextTranslateCTM(context, 30.0, 35.0)
            CGContextScaleCTM(context, 1.0, -1.0) //開始点の設定
            
            let framesetter = CTFramesetterCreateWithAttributedString(attributedText)
            let path = CGPathCreateWithRect(CGRectMake(0.0, 0.0, rect.height, rect.width), nil)
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
            CTFrameDraw(frame, context)
        }
    }
}