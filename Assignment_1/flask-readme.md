# 🧑‍💻 Flask User Management System

A **Flask-based user authentication and dashboard system** integrated with **MySQL**.  
This project supports user registration, login, password hashing, session management, secure password change, and basic gender-based dashboard statistics.

---

## 🚀 Features

- ✅ User Registration  
- ✅ Secure Login & Logout  
- ✅ Password Hashing (Werkzeug)  
- ✅ Session Management  
- ✅ User Dashboard  
- ✅ Gender-based Statistics  
- ✅ Percentage Calculation (Male/Female)  
- ✅ Secure Change Password (Old password verification)  
- ✅ Forced Logout on Incorrect Password  
- ✅ Bootstrap 5 UI  

---

## 🛠️ Technologies Used

- **Backend:** Python, Flask  
- **Frontend:** HTML, Bootstrap 5  
- **Database:** MySQL  
- **Security:** Werkzeug Password Hashing  

---

## 📁 Project Structure

```text
project/
│
├── app.py
├── README.md
│
├── templates/
│   ├── login.html
│   ├── register.html
│   ├── dashboard.html
│   └── change_password.html
│
└── static/ (optional)
```

---

## ⚙️ Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/flask-user-system.git
cd flask-user-system
```

### 2️⃣ Create Virtual Environment (Recommended)

```bash
python -m venv venv
```

Activate it:

- **Windows**
  ```bash
  venv\Scripts\activate
  ```

- **Linux / macOS**
  ```bash
  source venv/bin/activate
  ```

### 3️⃣ Install Dependencies

```bash
pip install flask mysql-connector-python werkzeug
```

---

## 🗄️ Database Setup (MySQL)

### Create Database

```sql
CREATE DATABASE user_system;
USE user_system;
```

### Create Table

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    phone VARCHAR(20),
    gender VARCHAR(10)
);
```

---

## 🔐 Configuration (`app.py`)

Update your MySQL credentials inside `app.py`:

```python
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'your_password',
    'database': 'user_system'
}
```

---

## ▶️ Running the Application

```bash
python app.py
```

Now open your browser and visit:  
[http://127.0.0.1:5000](http://127.0.0.1:5000)

---

## 📊 Dashboard Features

- View logged-in user profile  
- Total registered users  
- Total male users  
- Total female users  
- Gender percentage calculation  
- Clean Bootstrap card layout  

---

## 🔒 Change Password Flow

1. User clicks **Change Password**.  
2. Enters **current password**.  
3. ❌ Incorrect password → session logout.  
4. ✅ Correct password → new password form.  
5. Password updated securely using hashing.  

---

## 🧠 Security Measures

- Passwords stored as hashes  
- Session-based authentication  
- SQL injection prevention using placeholders  
- Auto logout on password verification failure  

---

## 🎨 UI & Styling

- Bootstrap 5  
- Responsive layout  
- Colored statistic cards  
- Clean navbar with actions  

---

## 📌 Future Enhancements

- Password strength validation  
- Email verification  
- Forgot password feature  
- Admin dashboard  
- Chart visualization (Pie/Bar charts)  

---

## 📄 License

This project is for **educational purposes** and free to use or modify.

---

## 🙌 Author

**Developed by Talha**  
Flask | Python | MySQL