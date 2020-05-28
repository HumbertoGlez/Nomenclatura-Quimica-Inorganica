//
//  GameViewController.swift
//  NQumicaInorganica
//
//  Created by Melba Consuelos on 22/04/20.
//  Copyright © 2020 Humberto Gonzalez Sanchez. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: ViewController {
    
    // Outlets
    @IBOutlet weak var lbFormula: UILabel!
    @IBOutlet weak var lbMensaje: UILabel!
    @IBOutlet weak var tfRespuesta: UITextField!
    @IBOutlet weak var lbCorrectas: UILabel!
    @IBOutlet weak var lbIntentos: UILabel!
    @IBOutlet weak var lbPorcentaje: UILabel!
    
    
    //Variables
    var arrDiccionarios = NSArray()
    var nFormula : Int!
    var ntipo: Int!
    let path = Bundle.main.path(forResource: "Acidos", ofType: "plist")
    var nombresFormula: [String]!
    var intentos = 0
    var correctas = 0
    // El usurario ya hizo un intento para el compuesto actual
    var intentoHecho = false
    var audioPlayer: AVAudioPlayer!
    var archivos: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        arrDiccionarios = NSArray(contentsOfFile: path!)
//        getDicts()
        obtenerConfiguracion()
        obtieneCompuesto()
        
        // Agrega valores al puntuaje
        lbCorrectas.attributedText = NSAttributedString(string: "0", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        lbIntentos.text = "0"
        lbPorcentaje.text = "= 0%"
    }
    
    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("configuracion.plist")
        print(pathArchivo.path)
        return pathArchivo
    }
    
    func obtenerConfiguracion() {
        do {
            let data = try Data.init(contentsOf: dataFileURL())
            archivos = try PropertyListDecoder().decode([String].self, from: data)
        }
        catch {
            archivos = ["Acidos", "CompuestosBinariosIonicos", "CompuestosMolecularesInorganicos", "CompuestosIonicosPoliatomicos"]
        }
        for archivo in archivos {
            print(archivo)
            let path = Bundle.main.path(forResource: archivo, ofType: "plist")
            arrDiccionarios = arrDiccionarios.adding(NSArray(contentsOfFile: path!)!) as NSArray
            print(arrDiccionarios)
        }
        
        print(arrDiccionarios)
    }
    
    func obtieneCompuesto() {
        ntipo = Int.random(in: 0 ..< arrDiccionarios.count)
        nFormula = Int.random(in: 0 ..< (arrDiccionarios[ntipo] as! NSArray).count)
        let dic = (arrDiccionarios[ntipo] as! NSArray)[nFormula] as! NSDictionary
        lbFormula.text = dic["Formula"] as? String
        nombresFormula = dic["Nombres"] as? [String]
        // Convierte los nombres a Minusculas
        nombresFormula = nombresFormula.map{$0.map{$0.lowercased()}}
        // For debug purposes, comment when not needed
        print(nombresFormula!)
        //tfRespuesta.text = nombresFormula[0]
    }
    
    func calculaPuntuacion() {
        let porcentaje = Double(correctas) / Double(intentos) * 100
        
        lbCorrectas.attributedText = NSAttributedString(string: "\(correctas)", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        lbIntentos.text = "\(intentos)"
        lbPorcentaje.text = "= \(Int(porcentaje.rounded()))%"
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
        tfRespuesta.isEnabled = true
        tfRespuesta.text = ""
        lbMensaje.text = ""
        intentoHecho = false
        obtieneCompuesto()
    }
    
    @IBAction func verificarRespuesta(_ sender: UIButton) {
        if !intentoHecho {
            intentos = intentos + 1
        }
        let respuesta = tfRespuesta.text!
        if nombresFormula.contains(respuesta.lowercased()) {
            // Play correct sound
            if let correctSound = NSDataAsset(name: "correctSnd") {
                do {
                    audioPlayer = try AVAudioPlayer(data: correctSound.data, fileTypeHint: AVFileType.wav.rawValue)
                } catch let error as NSError {
                   // couldn't load file :(
                    print(error.localizedDescription)
                }
                audioPlayer.play()
            }
            // show correct message
            // hexcode for color: A7EA4F
            let r, g, b, a: CGFloat
            let scanner = Scanner(string: "A7EA4FFF")
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
            }
            else {
                r = 1
                g = 1
                b = 1
                a = 1
            }
            lbMensaje.textColor = UIColor.init(red: r, green: g, blue: b, alpha: a)
            lbMensaje.text = "Respuesta correcta"
            // update score
            if !intentoHecho {
                correctas = correctas + 1
            }
        } else {
            // Play wrong sound
            if let wrongSound = NSDataAsset(name: "incorrectSnd") {
                do {
                    audioPlayer = try AVAudioPlayer(data: wrongSound.data, fileTypeHint: AVFileType.wav.rawValue)
                } catch let error as NSError {
                   // couldn't load file :(
                    print(error.localizedDescription)
                }
                audioPlayer.play()
            }
            // show wrong message
            lbMensaje.textColor = UIColor.red
            lbMensaje.text = "Respuesta incorrecta"
        }
        // solo nos interesa recalcular la puntuacion en el primer intento
        if !intentoHecho {
            intentoHecho = true
            calculaPuntuacion()
        }
    }
    
    @IBAction func mostrarRespuesta(_ sender: UIButton) {
        // Deshabilita el campo de texto
        tfRespuesta.isEnabled = false
        // Muestra la respuesta en el campo de texto
        tfRespuesta.text = nombresFormula.randomElement()
        // Si no se ha hecho intento, se calcula como incorrecta
        if !intentoHecho {
            intentos = intentos + 1
            calculaPuntuacion()
        }
        
    }
}
