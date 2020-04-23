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
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbIntentos: UILabel!
    @IBOutlet weak var lbPorcentaje: UILabel!
    
    
    //Variables
    var arrDiccionarios : NSArray!
    var nFormula : Int!
    let path = Bundle.main.path(forResource: "CompuestosBinariosIonicos", ofType: "plist")
    var nombresFormula: [String]!
    var intentos = 0
    var correctas = 0
    // El usurario ya hizo un intento para el compuesto actual
    var intentoHecho = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrDiccionarios = NSArray(contentsOfFile: path!)
        nFormula = Int.random(in: 0 ..< 20)
        let dic = arrDiccionarios[nFormula] as! NSDictionary
        lbFormula.text = dic["Formula"] as? String
        nombresFormula = dic["Nombres"] as? [String]
        // Convierte los nombres a Minusculas
        nombresFormula = nombresFormula.map{$0.map{$0.lowercased()}}
        // For debug purposes
        print(nombresFormula!)
        
        // Agrega valores al puntuaje
        lbCorrectas.attributedText = NSAttributedString(string: "0", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        lbIntentos.text = "0"
        lbPorcentaje.text = "= 0%"
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
        intentoHecho = false
        nFormula = Int.random(in: 0 ..< 20)
        let dic = arrDiccionarios[nFormula] as! NSDictionary
        lbFormula.text = dic["Formula"] as? String
        nombresFormula = dic["Nombres"] as? [String]
        // Convierte los nombres a Minusculas
        nombresFormula = nombresFormula.map{$0.map{$0.lowercased()}}
        // For debug purposes, comment when not needed
        print(nombresFormula!)
        tfRespuesta.text = nombresFormula[0]
    }
    
    @IBAction func verificarRespuesta(_ sender: UIButton) {
        if !intentoHecho {
            intentos = intentos + 1
        }
        let respuesta = tfRespuesta.text!
        print(respuesta.lowercased())
        if nombresFormula.contains(respuesta.lowercased()) {
            lbMensaje.text = "Respuesta correcta"
            if !intentoHecho {
                correctas = correctas + 1
            }
        } else {
            lbMensaje.text = "Respuesta incorrecta"
        }
        intentoHecho = true
        
        let porcentaje = Double(correctas) / Double(intentos) * 100
        
        lbCorrectas.attributedText = NSAttributedString(string: "\(correctas)", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        lbIntentos.text = "\(intentos)"
        lbPorcentaje.text = "= \(Int(porcentaje.rounded()))%"
    }
    
}
