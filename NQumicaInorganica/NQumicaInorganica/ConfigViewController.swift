//
//  ConfigViewController.swift
//  NQumicaInorganica
//
//  Created by Melba Consuelos on 22/04/20.
//  Copyright © 2020 Humberto Gonzalez Sanchez. All rights reserved.
//

import UIKit

class ConfigViewController: ViewController {

    @IBOutlet weak var swAcidos: UISwitch!
    @IBOutlet weak var swIbin: UISwitch!
    @IBOutlet weak var swIPoli: UISwitch!
    @IBOutlet weak var swMol: UISwitch!
    @IBOutlet weak var swCVar: UISwitch!
    
    
    var lista : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lista = []
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(btGuardar), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        if FileManager.default.fileExists(atPath: dataFileURL().path) {
            obtenerConfiguracion()
        }
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
            lista = try PropertyListDecoder().decode([String].self, from: data)
            if !lista.contains("Acidos") {
                swAcidos.isOn = false
            }
            if !lista.contains("CompuestosBinariosIonicos") {
                swIbin.isOn = false
            }
            if !lista.contains("CompuestosIonicosPoliatomicos") {
                swIPoli.isOn = false
            }
            if !lista.contains("CompuestosMolecularesInorganicos") {
                swMol.isOn = false
            }
            if !lista.contains("CVar") {
                swCVar.isOn = false
            }
        }
        catch {
            print("Error al cargar los datos del archivo")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btGuardar(_ sender: Any) {
        lista = []
        if swAcidos.isOn {
            lista.append("Acidos")
        }
        if swIbin.isOn {
            lista.append("CompuestosBinariosIonicos")
        }
        if swIPoli.isOn {
            lista.append("CompuestosIonicosPoliatomicos")
        }
        if swMol.isOn {
            lista.append("CompuestosMolecularesInorganicos")
        }
        if swCVar.isOn {
            lista.append("CVar")
        }
        
        if lista.count == 0 {
            let alerta = UIAlertController(title: "Error", message: "Se debe incluir por lo menos un tipo de compuesto", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
        else {
            do {
                let data = try PropertyListEncoder().encode(lista)
                try data.write(to: dataFileURL())
            }
            catch {
                print("Error al guardar los datos")
            }
            
            navigationController?.popViewController(animated: true)
        }
    }
    
}
