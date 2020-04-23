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
    @IBOutlet weak var lbMensaje: UILabel!
    @IBOutlet weak var tfRespuesta: UITextField!
    
    
    //Variables
    var arrDiccionarios : NSArray!
    var nFormula : Int!
    let path = Bundle.main.path(forResource: "CompuestosBinariosIonicos", ofType: "plist")
    var nombresFormula: [String]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrDiccionarios = NSArray(contentsOfFile: path!)
        nFormula = Int.random(in: 0 ..< 20)
        let dic = arrDiccionarios[nFormula] as! NSDictionary
        lbFormula.text = dic["Formula"] as? String
        nombresFormula = dic["Nombres"] as? [String]
        nombresFormula = nombresFormula.map{$0.map{$0.lowercased()}}
        // For debug purposes
        print(nombresFormula!)
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
        tfRespuesta.text = ""
        nFormula = Int.random(in: 0 ..< 20)
        let dic = arrDiccionarios[nFormula] as! NSDictionary
        lbFormula.text = dic["Formula"] as? String
        nombresFormula = dic["Nombres"] as? [String]
        // For debug purposes
        print(nombresFormula!)
    }
    
    @IBAction func verificarRespuesta(_ sender: UIButton) {
        let respuesta = tfRespuesta.text!
        print(respuesta.lowercased())
        if nombresFormula.contains(respuesta.lowercased()) {
            lbMensaje.text = "Respuesta correcta"
        } else {
            lbMensaje.text = "Respuesta incorrecta"
        }
    }
    
}
