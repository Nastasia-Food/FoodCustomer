# FoodCustomer

https://api.codemagic.io/apps/67a0ca6b18ca6800775873c9/67a0ca6b18ca6800775873c8/status_badge.svg

[![Codemagic build status](https://api.codemagic.io/apps/67a0ca6b18ca6800775873c9/67a0ca6b18ca6800775873c8/status_badge.svg)](https://codemagic.io/app/67a0ca6b18ca6800775873c9/67a0ca6b18ca6800775873c8/latest_build)

```markdown
# FoodCustomer 🍕📱

FoodCustomer is a **Flutter mobile app** designed for customers to order food from local restaurants, track deliveries in real-time, and manage their accounts. Built with scalability and user experience in mind, it integrates seamlessly with Firebase for backend operations.

## Features ✨

- **User Authentication**: Sign up/login with email, Google, or phone.
- **Restaurant Discovery**: Browse restaurants by cuisine, ratings, or distance.
- **Menu & Cart**: View menus, customize items, and add to cart.
- **Order Tracking**: Real-time updates on order preparation and delivery.
- **Payment Integration**: Secure payments via Stripe, Razorpay, or PayPal.
- **Reviews & Ratings**: Rate restaurants and delivery partners.
- **Dark Mode**: User-friendly dark/light theme support.

## Technologies Used 🛠️

- **Frontend**: Flutter, Dart
- **Backend**: Firebase (Auth, Firestore, Cloud Functions)
- **State Management**: Provider/Riverpod
- **Payment Gateway**: Stripe/Razorpay
- **Real-Time Updates**: Firebase Realtime Database
- **Analytics**: Firebase Analytics/Crashlytics
- **Deployment**: Google Play Store, Apple App Store

## Installation 🚀

### Prerequisites
- Flutter SDK (version 3.0.0 or higher)
- Firebase project setup (for Auth and Firestore)

### Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/Nastasia-Food/FoodCustomer.git
   cd FoodCustomer
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) from your Firebase Console.
   - Place them in:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Run the app**:
   ```bash
   flutter run
   ```

## Folder Structure 📂
```plaintext
lib/
├── models/          # Data models (User, Restaurant, Order)
├── services/        # Firebase and API handlers
├── widgets/         # Reusable UI components
├── screens/         # App screens (Home, Cart, Profile)
├── utils/           # Constants, helpers, and themes
└── main.dart        # App entry point
```

## Contributing 🤝
1. Fork the repository.
2. Create a branch: `git checkout -b feature/your-feature`.
3. Commit changes: `git commit -m 'Add your feature'`.
4. Push to the branch: `git push origin feature/your-feature`.
5. Submit a **Pull Request** with a clear description.

## License 📄
Licensed under the [MIT License](LICENSE).

## Contact 📧
For questions, partnerships, or support:
- **Website**: [food.natalee.pro](https://food.natalee.pro)
- **Email**: support@rechain.network 

---

⭐ **Star this repo** if you find it helpful!  
🐛 Report bugs or suggest features [here](https://github.com/Nastasia-Food/FoodCustomer/issues).
```

The heart of the ecosystem lies in Nastasia Still Food, a curated line of food products and culinary experiences inspired by Nastasia's passion for gastronomy and innovation. 
