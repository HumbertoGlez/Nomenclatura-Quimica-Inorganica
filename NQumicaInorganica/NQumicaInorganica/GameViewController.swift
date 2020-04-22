//
//  GameViewController.swift
//  NQumicaInorganica
//
//  Created by Melba Consuelos on 22/04/20.
//  Copyright © 2020 Humberto Gonzalez Sanchez. All rights reserved.
//

import UIKit

class GameViewController: ViewController {
    
    // Outlets
    @IBOutlet weak var lbFormula: UILabel!
    
    
    //Variables
    var arrDiccionarios : NSArray!
    var nFormula : Int!
    let path = Bundle.main.path(forResource: "CompuestosBinariosIonicos", ofType: "plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrDiccionarios = NSArray(contentsOfFile: path!)
        nFormula = Int.random(in: 0 ..< 20)
        let dic = arrDiccionarios[nFormula] as! NSDictionary
        lbFormula.text = dic["Formula"] as? String
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sigFormula(_ sender: Any) {
        nFormula = Int.random(in: 0 ..< 20)
        let dic = arrDiccionarios[nFormula] as! NSDictionary
        lbFormula.text = dic["Formula"] as? String
        
    }
    

}
