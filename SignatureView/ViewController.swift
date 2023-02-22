//
//  ViewController.swift
//  SignatureView
//
//  Created by Hidayat Abisena on 22/02/23.
//

import UIKit
import SwiftSignatureView

class ViewController: UIViewController {

    @IBOutlet weak var signatureView: SwiftSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func saveSignature() {
        let signatureImage = signatureView.signature
        guard let imageData = signatureImage?.pngData() else { return }

        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        let uniqueFileName = "\(UUID().uuidString).png"
        let fileUrl = documentDirectory.appendingPathComponent(uniqueFileName)

        do {
            try imageData.write(to: fileUrl)
            print("Saved signature image to: \(fileUrl.path)")
        } catch let error {
            let alert = UIAlertController(title: "Error", message: "Unable to save signature image.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("Error saving signature image: \(error.localizedDescription)")
        }
    }
    
    @IBAction func saveSignatureButtonTapped(_ sender: Any) {
        saveSignature()
    }
    
}

