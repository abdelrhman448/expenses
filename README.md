# 💰 Expense Tracker Lite

A lightweight Flutter expense tracking mobile app with offline support, currency conversion, pagination, and custom UI. Built with **Clean Architecture**, **Cubit**, **SQLite**, and **open.er-api.com** for real-time exchange rates.

---

## 🧠 Architecture

This app follows a **Clean Architecture + MVVM** structure:


State management is handled using **Cubit (Bloc)**.

---

## 🧩 Features

### ✅ Core Screens

* **Dashboard**

  * Welcome message and profile image
  * Total Balance / Income / Expenses
  * Recent expenses with infinite scroll
  * Filter by: This Month, Last 7 Days
  * Currency displayed in both local and USD
  * Pagination with loading + empty state

* **Add Expense**

  * Category, Amount, Date
  * Currency dropdown
  * Upload receipt image
  * Converts to USD on save using `open.er-api.com`
  * Category icon picker

### 💾 Local Storage

* All expenses are persisted locally using **SQLite**
* Filtered + paginated from local DB only

### 🌍 Currency Conversion

* API Used: [`https://open.er-api.com/v6/latest/USD`](https://open.er-api.com/v6/latest/USD)
* Converts any selected currency to USD
* Conversion rate is stored with the expense

### 📑 Pagination

* 10 expenses per page
* Implemented with infinite scroll
* Pagination supports active filters

### 🎨 UI/UX

* Matches provided Dribbble design
* Includes shadows, spacing, icon styling
* Animated transitions and smooth scrolling

---

## 🧪 Testing

* **Unit Test** included for:

  * Currency conversion logic
  * Expense validation logic



## ⚙️ Tech Stack

* Flutter 3.19+
* Cubit (Bloc)
* SQLite (local storage)
* `http` package for API calls
* `image_picker`, `path_provider`
* `flutter_bloc`, `equatable`

---

## 🚀 CI/CD

GitHub Actions configured to:

* Run tests on push and PR

File: `.github/workflows/flutter.yml`

---

