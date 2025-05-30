# 🤖 SmartSkin – AI-based Skin Problem Detection App

SmartSkin is a Flutter-based mobile application that helps users detect facial skin issues using Artificial Intelligence. By leveraging advanced image processing and AI models, users can simply capture or upload a photo of their face and receive instant feedback on potential skin conditions such as acne, redness, pigmentation, dryness, and more.

---

## 🚀 Features

- 📸 Face Image Scanner
Users can upload or capture an image of their face to scan for skin problems.
- 🤖 AI-Powered Skin Analysis with CNN
Detects various skin issues like acne, redness, pores, blackheads, dryness, and more using a trained Convolutional Neural Network (CNN) model.
- ✨ Shimmer Placeholder While Loading
Displays elegant shimmer animations as placeholders while content or analysis results are loading, improving user experience.
- 📄 Detailed Results with Recommendations
After scanning, users receive a clear summary of their skin condition along with personalized skincare tips.
- 🔁 "View More" Button Always Visible
Ensures navigation remains intuitive by keeping the "View More" button visible even during data loading.
- 🌐 API-based AI Model Integration
Integrates with an AI backend via REST API (e.g., Python Flask serving the CNN model) for real-time skin analysis and scalable deployment.

---

## 🧠 Technologies Used

| Technology                            | Role                                                                                      |
| ------------------------------------- | ----------------------------------------------------------------------------------------- |
| **Flutter**                           | Cross-platform mobile app framework                                                       |
| **Dart**                              | Programming language for Flutter                                                          |
| **Shimmer**                           | For loading animation placeholders                                                        |
| **Image Picker / Camera**             | For capturing or selecting facial images                                                  |
| **CNN-based AI Model (Python/Flask)** | Convolutional Neural Network for skin problem detection, hosted as a REST API backend     |
| **REST API**                          | Communication between Flutter app and AI backend for image analysis and results retrieval |
| **Material UI**                       | For clean and responsive design                                                           |

---

## 📲 How It Works

1. The user opens the app and uploads or captures a photo of their face.
2. The image is sent via HTTP API to a backend server running a Python-based CNN model for skin problem detection.
3. The backend AI analyzes the image using the Convolutional Neural Network (CNN) and returns the detected skin conditions.
4. The app displays the results clearly and intuitively to the user.
5. The View More button remains visible at all times, allowing users to access additional information or features easily.

---

## 📦 Dependencies

```yaml
dependencies:
  cupertino_icons: ^1.0.8
  flutter:
    sdk: flutter
  shimmer: ^3.0.0
  permission_handler: ^11.0.0
  image_picker: ^1.0.7
  google_fonts: ^6.1.0
  http: ^1.2.1
  html: ^0.15.0
  flutter_native_splash: ^2.3.10
  flutter_launcher_icons: ^0.13.1

flutter_native_splash:
  color: "#ffffff"
  image: assets/img/logo_smartskin.png
  fullscreen: true
  android: true
  ios: true
  web: false

flutter_icons:
  android: true
  ios: true
  image_path: "assets/img/logo_smartskin.png"
```

---
  
## 📷 Screenshots App
<p align="center"> <img src="https://github.com/user-attachments/assets/b3b6655d-3d8e-4d35-b3b2-a948c481e74f" width="250" /> <img src="https://github.com/user-attachments/assets/cc1d1a61-4d0c-4a78-9a5e-1c78d5acd27d" width="250" /> <img src="https://github.com/user-attachments/assets/12972df1-be1e-45af-b54b-7e73004e706b" width="250" /> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/64135250-d530-4642-8dc8-c482b0687fd2" width="250" /> <img src="https://github.com/user-attachments/assets/f803c288-3c12-48f8-bf1f-83114819abe4" width="250" /> <img src="https://github.com/user-attachments/assets/7bb39bb7-0127-448c-a9df-13cc6c5e537e" width="250" /> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/89b5c842-fe6f-4ffc-8846-4b6298605b9d" width="250" /> <img src="https://github.com/user-attachments/assets/a5fd84a4-785c-439b-be35-8f4cb848c6f1" width="250" /> <img src="https://github.com/user-attachments/assets/338afb37-82b8-47e4-817e-4cf171c959e4" width="250" /> </p> <p align="center"> <img src="https://github.com/user-attachments/assets/93f2cbf5-4451-48f6-907d-ec289acb45a3" width="250" /> <img src="https://github.com/user-attachments/assets/af90ff78-5d91-414c-a9bc-ea1b0e4e6770" width="250" /> </p>



---

## 🛠️ Setup Instructions

1. Clone Repo
```bash
git clone https://github.com/KREESS/detection_of_facial_acne.git
cd detection_of_facial_acne
```
2. Install Dependencies
```bash
flutter pub get
flutter pub run flutter_native_splash:create
flutter pub run flutter_launcher_icons:main
```
3. Run App
```bash
flutter run
```
4. Backend AI API (Face Acne Detector)
- This app integrates with the AI backend available at the repository: KREESS/ai-face-acne-detector.
- The AI model is based on YOLOv5, trained specifically to detect acne and various facial skin issues.
- The backend is built using Python and Flask, which accepts HTTP POST requests containing face images as input.
- After processing, the backend returns detection results including labels and bounding box coordinates in JSON format.
- The Flutter app sends images via http.MultipartRequest and parses the JSON response to display detection results to the user.

---

## 👤 Author
- **Aditya Putra Sholahuddin (a.k.a Kreess)**
- GitHub: @KREESS
- Email: adityasholahuddin@gmail.com
- Instagram: @adityasholahuddin

