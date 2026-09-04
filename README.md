# 🛍️ VogueVault – Fashion Shopping Mobile App

A modern and responsive fashion shopping mobile application built with **Flutter & Dart**. VogueVault allows users to discover fashion products, browse categories and collections, search and filter products, manage their shopping cart, and complete the checkout process.

The application was developed as a **cross-platform mobile application** based on a high-fidelity Figma prototype.

---

## ✨ Features

### 🔐 Authentication

- Splash screen with loading animation
- Three-screen onboarding
- Email and password login
- Google login option
- User registration / Sign Up
- Full name, email, password and confirm password fields

### 🏠 Home & Product Discovery

- Modern fashion-focused home screen
- Featured collection carousel
- Women, Men, Accessories and Beauty categories
- Featured products
- Recommended products
- Top collections
- Collection-based product browsing
- Show All product listings

### 🔍 Search & Filtering

- Search products by name
- Browse products by category
- All products filter
- Women products filter
- Men products filter
- Accessories filter
- Beauty filter
- Price-range slider
- Interactive search results

### 🛍️ Product Details

- Product image and information
- Product name and price
- Size selection
- Quantity selection
- Add to Cart functionality
- Product navigation

### 🛒 Shopping Cart

- Empty cart state
- Added product display
- Product quantity management
- Increase/decrease quantity
- Automatic subtotal calculation
- Shipping cost calculation
- Final total calculation
- Proceed to Checkout

### 💳 Checkout & Orders

- Customer information
- Shipping address
- Shipping method
- Product price summary
- Shipping cost
- Final order total
- Place Order functionality
- Order confirmation screen
- Order ID and total amount display

### 👤 Profile & Navigation

- User profile information
- My Orders
- Shipping Address
- Payment Method
- Profile options
- Bottom navigation
- Side navigation drawer
- Homepage
- Discover
- Settings
- Support
- About Us

### 📱 UI/UX

- Responsive mobile interface
- High-fidelity Figma implementation
- Clean and modern fashion UI
- Consistent typography and spacing
- Interactive navigation
- Cross-platform Flutter application

---

## 🛠️ Tech Stack

| Technology | Usage |
|---|---|
| Flutter | Cross-platform mobile development |
| Dart | Programming language |
| Material Design | UI components |
| Figma | UI/UX prototyping |

---

## 📱 Application Flow

```text
Splash Screen
      ↓
Onboarding
      ↓
Login / Sign Up
      ↓
Home Screen
      ↓
Category / Search / Collection
      ↓
Product Details
      ↓
Add to Cart
      ↓
Shopping Cart
      ↓
Checkout
      ↓
Place Order
      ↓
Order Confirmation




## Project structure

```text
lib/
- core/theme/        Theme and colour system
- core/utils/        Responsive helpers
- data/              Product mock data
- models/            Product and cart models
- state/             Cart state/controller
- widgets/           Small reusable UI components only
- screens/           Feature-based application screens
  - splash/
  - onboarding/
  - auth/
  - home/
  - discover/
  - product/
  - cart/
  - checkout/
  - profile/
  - orders/

## Run

flutter pub get
flutter run

No external packages are required.
