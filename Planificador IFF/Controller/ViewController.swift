//
//  ViewController.swift
//  Planificador IFF
//
//  Created by ivan on 04/05/2021.
//

import UIKit
import MLKit

import AVFoundation



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPhotoButton.layer.cornerRadius = 10
        rebootButton.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 10
        manualButton.layer.cornerRadius = 10
        recognizerButton.layer.cornerRadius = 10
        sendButton.layer.cornerRadius = 10
        scheduleButton.layer.cornerRadius = 10
        
        
        ciclos.append(ciclo1)
        ciclos.append(ciclo2)
        ciclos.append(ciclo3)
        ciclos.append(ciclo4)
        
        
        
        transition.startProgress = 0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.duration = 0.2
        
        //print(ciclos)
        
        // Do any additional setup after loading the view.
    }


    // MARK: - Variables
    let transition = CATransition()
    struct viewGlobal {
        static var firstDay = ""
        
        static var currentMonth = [""]
        
        
    }
    @IBOutlet var stackManual: UIStackView!
    
    @IBOutlet var stackPhoto: UIStackView!
    
    var window: UIWindow?
    
    var resultsText = ""
    var imagePicked: UIImageView!
    
    var ciclos = [[String]]()
    
    var ciclo1 = ["M","M","T","T","N","N","N","D","D"]
    var ciclo2 = ["M","M","T","T","T","N","N","D","D"]
    var ciclo3 = ["M","M","M","T","T","N","N","D","D"]
    var ciclo4 = ["D","D","D","D","D","D","D","D"]
    
    var meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    
    //var imagePicked: UIImage?
    private var lastFrame: CMSampleBuffer?
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    // MARK: - Oulets
    
    @IBOutlet var textDetected: UITextField!
    

    @IBOutlet var imageView: UIImageView!
    
    
    @IBOutlet var rebootButton: UIButton!
    
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var manualButton: UIButton!
    
    @IBOutlet var selectPhotoButton: UIButton!
    
    @IBOutlet var recognizerButton: UIButton!
    
    @IBOutlet weak var recognizeButton: UIBarButtonItem!
    
    @IBOutlet var manualTextButton: UITextField!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var scheduleButton: UIButton!
    // MARK: - Outlet Button Methods
    
    @IBAction func scheduleAction(_ sender: Any) {
        if textDetected.text! >= "1" && textDetected.text! <= "31" {
            //viewGlobal.firstDay = manualTextButton.text!
//            textDetected.text = manualTextButton.text
            var dia = Int(viewGlobal.firstDay)
            print("FIRST DAY: "+String(dia!))
            var mes = 0
            for item in ciclos{
                for subItem in item{
                    if dia! <= 31 {
                        var h = " \n dia: " + String(dia!) + " de " + meses[mes] + " con horario: " + String(subItem)
                        viewGlobal.currentMonth.append(h)
                        if dia == 31{
                            mes += 1
                            dia = 0
                        }
                        dia! += 1
                        print(h)
                       
                    }
                    
                }
            }
            //viewGlobal.init(mes: ["", ""]  )
            
            
            DispatchQueue.main.async {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let vc = MainInterface()

                self.window?.layer.add(self.transition, forKey: "transition")
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
            }
            
            
        }
        else{
            textDetected.text = manualTextButton.text! + "is a wrong value!"
        }
    }
    @IBAction func reiniciarAction(_ sender: Any) {
        
        textDetected.text = ""
        viewGlobal.firstDay = ""
        
    }
    
    @IBAction func selectButtonAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let vc = MainInterface()

            self.window?.layer.add(self.transition, forKey: "transition")
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func recognizeButtonAction(_ sender: Any) {
        clearResults()
        
        textRecognize(image: imageView.image)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
        if manualTextButton.text! >= "1" && manualTextButton.text! <= "31" {
            viewGlobal.firstDay = manualTextButton.text!
            textDetected.text = manualTextButton.text
            
        }
        else{
            textDetected.text = manualTextButton.text! + "is a wrong value!"
        }
        
    }
    
    @IBAction func endEdit(_ sender: Any) {
        self.resignFirstResponder()
    }
    

    
    @IBAction func manualAction(_ sender: Any) {
        if stackPhoto.isHidden == true {
            stackPhoto.isHidden = false
            stackManual.isHidden = true
        }
        else{
            stackPhoto.isHidden = true
            stackManual.isHidden = false
        }
    }
    // MARK: - Functions
        
    
    
    func textRecognize(image: UIImage?){
        guard let image = image else { return }
    
        let onDeviceTextRecognizer = TextRecognizer.textRecognizer()
        
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        
        print("Running On-Device Text Recognition...\n")

        
        extractedFunc(visionImage, onDeviceTextRecognizer)
    }
    
    func scheduleFromPhoto(text: String) {
        let textSplit = text.split(separator: "\n")
        var i = 0
        print(text)
        
        var dias = ["0" ]
        var horario = ["" ]
        
        var dia: String
        var horario1: String
        
        //turno = String(textSplit[0])
        for item in textSplit {
            if item.count <= 5 || item.count > 12 {
                horario1 = String(item)
                horario.append(horario1)
                //print("horario: ", item)
            }
            else if item.count == 10{
                dia = String(item)
                //print("dia: ", dia)
            }
            else{
                //print("else " + item)
            }
            
        }
        i = 1 // 4 calendar (?
        while i <= 31 {
            dias.append(String(i))
            
            
            i += 1
        }
        i=0
        
        
        var descanso = ""
        var contDesc = 0
        var conjunto = [""]
        

        while i < horario.count {
            if dias.count >= horario.count{
                conjunto.append(dias[i] + "-> " + horario[i])
                if horario[i] == "D" {
                    contDesc += 1
                }
                else{
                    //print("non " + descanso)
                    contDesc = 0
                }
                
                if contDesc == 3 {
                    descanso = dias[i]
                    //print("descanso: " + descanso)
                }
            }
            
            
            i += 1
        }
        i=0
        
        
        print(descanso)
        //print("hola")
        
        
        
        if descanso != "" {
            var firstDay = Int(descanso)
            firstDay! += 8
            let firstDayStr = String(firstDay!)
            textDetected.text = firstDayStr
            viewGlobal.firstDay = firstDayStr
        }
        else{
            textDetected.text = "Repite la foto"
            print("Descanso: ", descanso)
        }
        
        

        
        
        
        
        
    }
    
    // MARK: - PROCESS METHOD
    
    private func process(_ visionImage: VisionImage, with textRecognizer: TextRecognizer?) {
      weak var weakSelf = self
      textRecognizer?.process(visionImage) { text, error in
        guard let strongSelf = weakSelf else {
          print("Self is nil!")
          return
        }
        guard error == nil, let text = text else {
          let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
          strongSelf.resultsText = "Text recognizer failed with error: \(errorString)"
          strongSelf.showResults()
          return
        }
        // Blocks.
        for block in text.blocks {
          let transformedRect = block.frame.applying(strongSelf.transformMatrix())
          UIUtilities.addRectangle(
            transformedRect,
            to: strongSelf.annotationOverlayView,
            color: UIColor.purple
          )

          // Lines.
          for line in block.lines {
            let transformedRect = line.frame.applying(strongSelf.transformMatrix())
            UIUtilities.addRectangle(
              transformedRect,
              to: strongSelf.annotationOverlayView,
              color: UIColor.orange
            )

            // Elements.
            for element in line.elements {
              let transformedRect = element.frame.applying(strongSelf.transformMatrix())
              UIUtilities.addRectangle(
                transformedRect,
                to: strongSelf.annotationOverlayView,
                color: UIColor.green
              )
              let label = UILabel(frame: transformedRect)
              label.text = element.text
              label.adjustsFontSizeToFitWidth = true
              strongSelf.annotationOverlayView.addSubview(label)
            }
          }
        }
//        strongSelf.resultsText += "'\(text.text)'\n"
        //strongSelf.showResults()
        
        //print("'", text.text, "'")
        self.textDetected.text = text.text
        
        self.scheduleFromPhoto(text: text.text)
      }
    }
    
    
    
    private func transformMatrix() -> CGAffineTransform {
      guard let image = imageView.image else { return CGAffineTransform() }
      let imageViewWidth = imageView.frame.size.width
      let imageViewHeight = imageView.frame.size.height
      let imageWidth = image.size.width
      let imageHeight = image.size.height

      let imageViewAspectRatio = imageViewWidth / imageViewHeight
      let imageAspectRatio = imageWidth / imageHeight
      let scale =
        (imageViewAspectRatio > imageAspectRatio)
        ? imageViewHeight / imageHeight : imageViewWidth / imageWidth

      // Image view's `contentMode` is `scaleAspectFit`, which scales the image to fit the size of the
      // image view by maintaining the aspect ratio. Multiple by `scale` to get image's original size.
      let scaledImageWidth = imageWidth * scale
      let scaledImageHeight = imageHeight * scale
      let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
      let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)

      var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
      transform = transform.scaledBy(x: scale, y: scale)
      return transform
    }
    private lazy var annotationOverlayView: UIView = {
      precondition(isViewLoaded)
      let annotationOverlayView = UIView(frame: .zero)
      annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
      annotationOverlayView.clipsToBounds = true
      return annotationOverlayView
    }()
    
    // MARK: - Private Functions
    fileprivate func extractedFunc(_ visionImage: VisionImage, _ onDeviceTextRecognizer: TextRecognizer) {
        process(visionImage, with: onDeviceTextRecognizer)
    }
    
    private func recognizeTextOnDevice(in image: VisionImage, width: CGFloat, height: CGFloat) {

      var recognizedText: Text

      do {
        recognizedText = try TextRecognizer.textRecognizer().results(in: image)
    
        
        print("ci")
      } catch let error {
        print("Failed to recognize text with error: \(error.localizedDescription).")
        return
      }
        
      DispatchQueue.main.sync {
        
        self.updatePreviewOverlayView()
        self.removeDetectionAnnotations()

        // Blocks.
        for block in recognizedText.blocks {
          let points = self.convertedPoints(from: block.cornerPoints, width: width, height: height)
          UIUtilities.addShape(
            withPoints: points,
            to: self.annotationOverlayView,
            color: UIColor.purple
          )

          // Lines.
          for line in block.lines {
            let points = self.convertedPoints(from: line.cornerPoints, width: width, height: height)
            UIUtilities.addShape(
              withPoints: points,
              to: self.annotationOverlayView,
              color: UIColor.orange
            )

            // Elements.
            for element in line.elements {
              let normalizedRect = CGRect(
                x: element.frame.origin.x / width,
                y: element.frame.origin.y / height,
                width: element.frame.size.width / width,
                height: element.frame.size.height / height
              )

              let convertedRect = self.previewLayer.layerRectConverted(
                fromMetadataOutputRect: normalizedRect
              )
              UIUtilities.addRectangle(
                convertedRect,
                to: self.annotationOverlayView,
                color: UIColor.green
              )
              let label = UILabel(frame: convertedRect)

              label.text = element.text
              label.adjustsFontSizeToFitWidth = true
              self.annotationOverlayView.addSubview(label)
            }
          }
        }
      }
    }

    
    private func convertedPoints(
      from points: [NSValue]?,
      width: CGFloat,
      height: CGFloat
    ) -> [NSValue]? {
      return points?.map {
        let cgPointValue = $0.cgPointValue
        let normalizedPoint = CGPoint(x: cgPointValue.x / width, y: cgPointValue.y / height)
        
        let cgPoint = previewLayer.layerPointConverted(fromCaptureDevicePoint: normalizedPoint)
        let value = NSValue(cgPoint: cgPoint)
        return value
      }
        
    }
    
    
    private func updatePreviewOverlayView() {
      guard let lastFrame = lastFrame,
        let imageBuffer = CMSampleBufferGetImageBuffer(lastFrame)
      else {
        return
      }
    }
    
    private func showResults() {
      let resultsAlertController = UIAlertController(
        title: "Detection Results",
        message: nil,
        preferredStyle: .actionSheet
      )
      resultsAlertController.addAction(
        UIAlertAction(title: "OK", style: .destructive) { _ in
          resultsAlertController.dismiss(animated: true, completion: nil)
        }
      )
      resultsAlertController.message = resultsText
      resultsAlertController.popoverPresentationController?.barButtonItem = recognizeButton
      resultsAlertController.popoverPresentationController?.sourceView = self.view
      present(resultsAlertController, animated: true, completion: nil)
      print(resultsText)
    }
    private func removeDetectionAnnotations() {
      for annotationView in annotationOverlayView.subviews {
        annotationView.removeFromSuperview()
      }
    }
    private func clearResults() {
      removeDetectionAnnotations()
      self.resultsText = ""
    }

}

// MARK: - Extension


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("\(info)")
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage{
            imageView.image = image
            //self.imagePicked.image = image
            //self.imageView.isHidden = false
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Constants
public enum Detector: String {
case onDeviceBarcode = "On-Device Barcode Scanner"
case onDeviceFace = "On-Device Face Detection"
case onDeviceText = "On-Device Text Recognition"
case onDeviceObjectProminentNoClassifier = "ODT, single, no labeling"
case onDeviceObjectProminentWithClassifier = "ODT, single, labeling"
case onDeviceObjectMultipleNoClassifier = "ODT, multiple, no labeling"
case onDeviceObjectMultipleWithClassifier = "ODT, multiple, labeling"
case onDeviceObjectCustomProminentNoClassifier = "ODT, custom, single, no labeling"
case onDeviceObjectCustomProminentWithClassifier = "ODT, custom, single, labeling"
case onDeviceObjectCustomMultipleNoClassifier = "ODT, custom, multiple, no labeling"
case onDeviceObjectCustomMultipleWithClassifier = "ODT, custom, multiple, labeling"
case poseAccurate = "Pose, accurate"
case poseFast = "Pose, fast"
}

private enum Constant {
static let alertControllerTitle = "Vision Detectors"
static let alertControllerMessage = "Select a detector"
static let cancelActionTitleText = "Cancel"
static let videoDataOutputQueueLabel = "com.google.mlkit.visiondetector.VideoDataOutputQueue"
static let sessionQueueLabel = "com.google.mlkit.visiondetector.SessionQueue"
static let noResultsMessage = "No Results"
static let localModelFile = (name: "bird", type: "tflite")
static let labelConfidenceThreshold: Float = 0.75
static let smallDotRadius: CGFloat = 4.0
static let lineWidth: CGFloat = 3.0
static let originalScale: CGFloat = 1.0
static let padding: CGFloat = 10.0
static let resultsLabelHeight: CGFloat = 200.0
static let resultsLabelLines = 5
}
private enum Constants {
static let images = [
"grace_hopper.jpg", "barcode_128.png", "qr_code.jpg", "beach.jpg",
"image_has_text.jpg", "liberty.jpg", "bird.jpg",
]

static let detectionNoResultsMessage = "No results returned."
static let failedToDetectObjectsMessage = "Failed to detect objects in image."
static let localModelFile = (name: "bird", type: "tflite")
static let labelConfidenceThreshold = 0.75
static let smallDotRadius: CGFloat = 5.0
static let largeDotRadius: CGFloat = 10.0
static let lineColor = UIColor.yellow.cgColor
static let lineWidth: CGFloat = 3.0
static let fillColor = UIColor.clear.cgColor
static let segmentationMaskAlpha: CGFloat = 0.5
}

