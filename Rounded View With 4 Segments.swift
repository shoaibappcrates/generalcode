//
//  ViewController.swift
//  Abc
//
//  Created by Shoaib Akram on 08/03/2021.
//



import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circularView: UIView!
    
    var shapes = [CAShapeLayer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createCircle()
    }

    
    // create rounded view with four segments
    func createCircle(){

        let count: Int = 4
        let gapSize: CGFloat = 0.008
        let segmentAngleSize: CGFloat = (2.0 * CGFloat(3.14) - CGFloat(count) * gapSize) / CGFloat(count)
        let center = CGPoint(x: circularView.frame.size.width / 2.0, y: circularView.frame.size.height / 2.0)
        let radius: CGFloat = 90
        let lineWidth: CGFloat = 60
        let strokeColor = UIColor.lightGray.cgColor
        
        let halfLengthOfSegment = (CGFloat(3.14 / 2.0) / 2)
        
        for i in 0 ..< count {
            
            var start = CGFloat(i) * (segmentAngleSize + gapSize) - CGFloat(3.14 / 2.0)
            start += halfLengthOfSegment
            
            let end = start + segmentAngleSize
            let segmentPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)

            let arcLayer = CAShapeLayer()
            arcLayer.path = segmentPath.cgPath
            arcLayer.fillColor = UIColor.clear.cgColor
            arcLayer.strokeColor = strokeColor
            arcLayer.lineWidth = lineWidth
            
            self.shapes.append(arcLayer)
            self.circularView.layer.addSublayer(arcLayer)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnCircularView(touch:)))
        self.circularView.addGestureRecognizer(tap)
    }
    
    
    @objc func tapOnCircularView(touch: UITapGestureRecognizer) {
        let tapPoint = touch.location(in: self.circularView)
        
        var index = 0
        for shape in shapes {
            if (shape.path!.contains(tapPoint)) {
                
                if index == 0 {
                    print("First button clicked")
                }
                else if index == 1 {
                    print("Second button clicked")
                }
                else if index == 2 {
                    print("Third button clicked")
                }
                else if index == 3 {
                    print("Forth button clicked")
                }
                
                shape.strokeColor = UIColor.green.cgColor
            }
            else {
                shape.strokeColor = UIColor.lightGray.cgColor
            }
            
            index += 1
        }
    }

}

