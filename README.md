---

# IBD Symptom Detection Using Machine Learning

## Overview
This project aims to develop a machine learning-based system for classifying medical reports to detect the presence of Inflammatory Bowel Disease (IBD) symptoms. The system leverages natural language processing (NLP) techniques to analyze textual data from medical reports, offering a non-invasive, automated tool to aid in the early diagnosis of IBD.

### Key Features:
- **Machine Learning Models:** Implementation of Linear Support Vector Classifier (SVC), Multinomial Naive Bayes, and Random Forest Classifier to classify medical reports.
- **Text Preprocessing:** Tokenization, stop words removal, lemmatization, and feature extraction using Term Frequency-Inverse Document Frequency (TF-IDF) vectorization.
- **Cross-Validation:** Performance evaluation using 10-fold stratified cross-validation.
- **Web and Mobile Integration:** Developed a web application using Streamlit and a mobile application prototype for iOS, integrated with Firebase.

## Research Questions
1. How effective are different machine learning algorithms in classifying medical reports for the presence of IBD symptoms?
2. What preprocessing and feature extraction techniques yield the highest classification accuracy for IBD symptom detection?
3. Can a machine learning-based classification system integrated into an application streamline the initial screening process for IBD and improve early diagnosis?
4. What are the future directions for enhancing the accuracy and applicability of machine learning models in medical report classification for IBD?

## Research Objectives
- Develop and implement a machine learning system to classify medical reports for IBD symptom detection.
- Optimize text preprocessing and feature extraction techniques to enhance classification accuracy.
- Deploy the best-performing model in a user-friendly application for early IBD screening.
- Explore future improvements with larger datasets and advanced machine learning methods.

## Installation

### Prerequisites
- Python 3.x
- Libraries: `numpy`, `pandas`, `scikit-learn`, `nltk`, `streamlit`, `firebase-admin`

### Clone the Repository
```bash
git clone https://github.com/your-username/IBD-Detection.git
cd IBD-Detection
```

### Install Dependencies
Install the required Python packages using pip:
```bash
pip install -r requirements.txt
```

### Firebase Setup (for iOS app)
1. Create a Firebase project on the Firebase Console.
2. Add your iOS app to the project.
3. Download the `GoogleService-Info.plist` file and place it in your Xcode project.
4. Initialize Firebase in your app's code.

### Streamlit Web Application
To run the web-based interface using Streamlit:
```bash
streamlit run app.py
```

## Usage

### Training the Model
1. **Preprocess the Data:** Run the preprocessing pipeline to clean and transform the text data.
2. **Train the Models:** Use the scripts provided to train the LinearSVC, Multinomial Naive Bayes, and Random Forest models.
3. **Evaluate Performance:** Perform 10-fold stratified cross-validation to evaluate model performance.
4. **Select the Best Model:** Based on the accuracy scores, select the best-performing model (LinearSVC) for deployment.

### Web Application
- Upload medical reports via the web application interface.
- The model will classify the reports as either positive or negative for IBD symptoms.
- Based on the classification, users will receive recommendations for further action.

### iOS Application
- Upload medical reports through the mobile app.
- The app will connect to the Firebase backend to classify the report and provide relevant resources and recommendations.

## Project Structure
```
IBD-Detection/
│
├── data/                    # Contains medical report datasets
├── models/                  # Trained models and saved checkpoints
├── notebooks/               # Jupyter notebooks for experimentation
├── scripts/                 # Python scripts for preprocessing, training, and evaluation
├── app.py                   # Streamlit web application script
├── ios/                     # iOS application source code
├── requirements.txt         # Python dependencies
└── README.md                # Project documentation
```

## Results
- **Best Model:** Linear Support Vector Classifier (LinearSVC) achieved the highest accuracy in detecting IBD symptoms from medical reports.
- **Web App Deployment:** A functional web interface allows users to upload and classify medical reports, streamlining the initial screening process for IBD.
- **Future Work:** The project will be expanded with larger datasets, additional clinical parameters, and more advanced machine learning techniques.

## Contributing
Contributions are welcome! If you have suggestions, improvements, or additional features you'd like to see, feel free to fork the repository and create a pull request.

### Steps to Contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For any questions or inquiries, please contact:
- **Your Name:** Darshan Virani
- **Email:** darshanvirani2468@gmail.com

---
