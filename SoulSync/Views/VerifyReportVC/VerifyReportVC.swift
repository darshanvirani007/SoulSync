import UIKit
import PDFKit

class VerifyReportVC: UIViewController {

    // Positive and negative symptoms lists
    let positiveSymptoms = [
        "Further evaluation recommended for detected polyp.",
                  "Mild inflammation noted, likely due to diverticulosis.",
                  "Polyp removed and submitted for histopathological examination.",
                  "Biopsy specimens obtained for further analysis.",
                  "Follow-up colonoscopy recommended based on clinical findings.",
                  "Biopsies taken from suspicious areas for pathological assessment.",
                  "Polyp resected completely, no residual tissue observed.",
                  "Polypoid lesions excised completely, no residual tissue present.",
                  "Tissue samples collected for histological analysis.",
                  "Tissue samples sent for pathological examination.",
                  "Results pending",
                  "No evidence of active bleeding or vascular abnormalities seen.",
                  "No evidence of active inflammation or other acute abnormalities seen.",
                  "No significant deviations from expected findings, no further intervention required.",
                  "Polyps removed successfully, no complications encountered during the procedure.",
                  "No concerning features noted, patient advised to maintain regular follow-up appointments.",
                  "Colonoscopy results within expected range, no significant abnormalities detected.",
                  "Tissue samples obtained for pathological assessment, results pending.",
                  "Colonoscopy results within normal limits, no worrisome findings detected.",
                  "Normal post-procedure impression, patient discharged home.",
                  "No significant pathology identified, routine follow-up recommended.",
                  "Impression unchanged from previous exams, no new concerns.",
                  "Colonoscopy findings stable, no evidence of disease recurrence.",
                  "Impression benign, no indication of significant mucosal abnormalities.",
                  "No concerning lesions identified, patient advised to continue regular care.",
                  "No need for immediate intervention, plan for routine follow-up.",
                  "Impression normal, no evidence of significant colonic disease.",
                  "Colonoscopy findings unremarkable, no new abnormalities detected.",
                  "No features concerning for high-grade dysplasia or malignancy.",
                  "Polyps removed completely, no residual adenomas visualized.",
                  "No signs of procedural complications observed.",
                  "Impression consistent with benign colorectal findings.",
                  "Colonoscopy results negative for significant pathology.",
                  "Findings consistent with normal colonic mucosa.",
                  "No significant deviations from expected findings, no further intervention required.",
                  "Polyps removed successfully, no complications encountered during the procedure.",
                  "No concerning features noted, patient advised to maintain regular follow-up appointments.",
                  "Colonoscopy results within expected range, no significant abnormalities detected.",
                  "No evidence of dysplasia or malignancy, patient advised to continue surveillance as scheduled."
        // Positive symptoms list from Streamlit code
    ]

    let negativeSymptoms = [
        "No significant abnormalities detected.",
                  "Normal colonoscopy findings, no further action required.",
                  "Impression consistent with routine colonoscopic examination.",
                  "No concerning pathology identified, follow-up not necessary.",
                  "Benign findings observed, no need for additional intervention.",
                  "Colonoscopy results negative for significant abnormalities.",
                  "No evidence of malignancy detected, routine surveillance recommended.",
                  "No concerning features identified, ongoing surveillance advised.",
                  "No acute abnormalities detected, continue with standard care.",
                  "Normal post-procedure impression, no complications identified.",
                  "Impression consistent with expected post-procedure course.",
                  "No suspicious lesions seen, regular screening advised.",
                  "No pathology requiring immediate attention identified.",
                  "Colonoscopy results reassuring, no further action needed.",
                  "No concerning features noted, plan for routine follow-up.",
                  "No acute abnormalities seen, continue with standard follow-up.",
                  "Impression normal, no pathology requiring further investigation.",
                  "Colonoscopy results negative for high-risk lesions.",
                  "No need for immediate intervention, continue with standard care.",
                  "Impression unremarkable, no need for immediate intervention.",
                  "No evidence of inflammatory bowel disease detected.",
                  "Impression unchanged from prior examinations, no new pathology identified.",
                  "No evidence of dysplasia or carcinoma detected.",
                  "No evidence of ischemia or vascular abnormalities detected.",
                  "Impression benign, no indication of significant pathology.",
                  "No features suggestive of advanced neoplasia seen.",
                  "No evidence of dysplasia or malignancy, continue with regular surveillance.",
                  "Normal post-procedure impression, patient can resume normal activities.",
                  "No features suggestive of advanced neoplasia seen.",
                  "No evidence of malignancy or dysplasia, continue with routine surveillance.",
                  "Normal post-procedure impression, patient discharged home.",
                  "No significant pathology identified, routine follow-up recommended.",
                  "Impression unchanged from previous exams, no new concerns.",
                  "Colonoscopy findings stable, no evidence of disease recurrence.",
                  "No features suggestive of infectious colitis or other acute pathology.",
                  "Impression benign, no indication of significant mucosal abnormalities.",
                  "Colonoscopy results consistent with expected post-procedure course.",
                  "No concerning lesions identified, patient advised to continue regular care.",
                  "No need for immediate intervention, plan for routine follow-up.",
                  "Impression normal, no evidence of significant colonic disease.",
                  "Colonoscopy findings unremarkable, no evidence of disease progression.",
                  "No features concerning for malignancy detected.",
                  "Polyps removed with clear margins, no residual adenomatous tissue.",
                  "No signs of acute complications following the procedure.",
                  "Impression consistent with benign colorectal changes.",
                  "Colonoscopy results negative for advanced neoplasia.",
                  "No evidence of active bleeding or vascular abnormalities seen.",
                  "Findings consistent with benign mucosal changes.",
                  "No significant deviations from expected findings, no further action needed.",
                  "Polyps removed successfully, no complications encountered.",
                  "No concerning features noted, continue with regular monitoring.",
                  "Tissue samples sent for pathological examination.",
                  "Colonoscopy results within normal limits, no worrisome findings detected.",
                  "No evidence of malignancy or dysplasia, continue with routine surveillance.",
                  "Normal post-procedure impression, patient discharged home.",
                  "No significant pathology identified, routine follow-up recommended.",
                  "Impression unchanged from previous exams, no new concerns.",
                  "Colonoscopy findings stable, no evidence of disease recurrence.",
                  "No features suggestive of infectious colitis or other acute pathology.",
                  "Impression benign, no indication of significant mucosal abnormalities."
        // Negative symptoms list from Streamlit code
    ]

    @IBOutlet weak var btnUploadReport: UIButton! // Outlet for the upload button

    @IBOutlet weak var lblErrorMsg: UILabel!
    // Function to classify report as normal or abnormal
    func classifyReport(reportText: String) -> String {
        if positiveSymptoms.contains(where: { reportText.contains($0) }) {
            return "Positive Symptoms"
        } else if negativeSymptoms.contains(where: { reportText.contains($0) }) {
            return "Negative Symptoms"
        } else {
            return "Unknown"
        }
    }

    // Function to extract text from PDF files
    func extractText(from pdfURL: URL) -> String? {
        do {
            let pdfDocument = PDFDocument(url: pdfURL)
            var extractedText = ""
            guard let pageCount = pdfDocument?.pageCount else {
                return nil
            }
            for i in 0..<pageCount {
                if let page = pdfDocument?.page(at: i) {
                    extractedText += page.string ?? ""
                }
            }
            return extractedText
        } catch {
            print("Error occurred while processing PDF: \(error)")
            return nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        btnUploadReport.addTarget(self, action: #selector(btnUploadReportTapped(_:)), for: .touchUpInside)
        hideError()
    }
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?() // Execute the completion closure if provided
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func showError(message: String) {
        lblErrorMsg.text = message
        lblErrorMsg.isHidden = false
    }

    func hideError() {
        lblErrorMsg.isHidden = true
    }

    @IBAction func btnUploadReportTapped(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.adobe.pdf"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
}

extension VerifyReportVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
           guard let selectedFileURL = urls.first else {
               // Handle error
               return
           }

           if let reportText = extractText(from: selectedFileURL) {
               let classificationResult = classifyReport(reportText: reportText)
               print("Classification Result: \(classificationResult)")
               hideError() // Hide error label initially

               switch classificationResult {
               case "Positive Symptoms":
                   showAlert(title: "Report Valid", message: "You can log in.") {
                       self.dismiss(animated: true, completion: nil)
                   }

               case "Negative Symptoms":
                   showError(message: "Negative symptoms detected. You can't log in.")
               default:
                   showError(message: "Unknown report classification. You can't log in.")
               }
           } else {
               // Handle error while processing PDF
               print("Error: Unable to process PDF document.")
               showError(message: "Error: Unable to process PDF document.")
           }
       }
}
