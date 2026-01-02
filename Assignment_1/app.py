from flask import Flask, render_template, request, redirect, session, flash, url_for
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = 'super_secret_key_for_session'  # Required for session security

# --- Database Connection Configuration ---
db_config = {
    'host': 'localhost',
    'user': 'root',          # CHANGE THIS to your MySQL username
    'password': 'talha',  # CHANGE THIS to your MySQL password
    'database': 'user_system'
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

# --- Routes ---

@app.route('/')
def home():
    return redirect(url_for('login'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        # Get form data
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        phone = request.form['phone']
        gender = request.form['gender']

        # Hash password for security
        hashed_password = generate_password_hash(password)

        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            
            # Check if email already exists
            cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
            if cursor.fetchone():
                flash("Error: Email already registered!", "danger")
            else:
                # Insert new user
                query = "INSERT INTO users (name, email, password, phone, gender) VALUES (%s, %s, %s, %s, %s)"
                cursor.execute(query, (name, email, hashed_password, phone, gender))
                conn.commit()
                flash("Registration successful! Please login.", "success")
                return redirect(url_for('login'))
                
        except mysql.connector.Error as err:
            flash(f"Database Error: {err}", "danger")
        finally:
            if 'cursor' in locals(): cursor.close()
            if 'conn' in locals(): conn.close()

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True) # Dictionary cursor makes accessing data easier
        
        cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
        user = cursor.fetchone()
        
        cursor.close()
        conn.close()

        # Verify user exists and password matches hash
        if user and check_password_hash(user['password'], password):
            # Create Session
            session['user_id'] = user['id']
            session['user_name'] = user['name']
            return redirect(url_for('dashboard'))
        else:
            flash("Invalid email or password", "danger")

    return render_template('login.html')

@app.route('/dashboard')
def dashboard():
    # Session Management: Prevent access if not logged in
    if 'user_id' not in session:
        flash("Please login to access the dashboard", "warning")
        return redirect(url_for('login'))

    # Retrieve real-time data from DB to prove connectivity
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # Query 1: Get current user details
    cursor.execute("SELECT * FROM users WHERE id = %s", (session['user_id'],))
    user_info = cursor.fetchone()
    
    # Query 2: Get total user count (Extra feature for dashboard)
    # Total users
    cursor.execute("SELECT COUNT(*) as count FROM users")
    total_users = cursor.fetchone()['count']

    # Male users
    cursor.execute("SELECT COUNT(*) as count FROM users WHERE gender = 'Male'")
    total_users_male = cursor.fetchone()['count']

    # Female users
    cursor.execute("SELECT COUNT(*) as count FROM users WHERE gender = 'Female'")
    total_users_female = cursor.fetchone()['count']

    # Prevent division by zero
    if total_users > 0:
        male_percentage = round((total_users_male / total_users) * 100, 2)
        female_percentage = round((total_users_female / total_users) * 100, 2)
    else:
        male_percentage = 0
        female_percentage = 0

    cursor.close()
    conn.close()

    return render_template(
        'dashboard.html',
        user=user_info,
        total_users=total_users,
        total_users_male=total_users_male,
        total_users_female=total_users_female,
        male_percentage=male_percentage,
        female_percentage=female_percentage
    )


@app.route('/logout')
def logout():
    session.clear()
    flash("You have been logged out.", "info")
    return redirect(url_for('login'))

@app.route('/change_password', methods=['GET', 'POST'])
def change_password():
    if 'user_id' not in session:
        flash("Please login first", "warning")
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Get user password
    cursor.execute("SELECT password FROM users WHERE id = %s", (session['user_id'],))
    user = cursor.fetchone()

    if request.method == 'POST':
        # STEP 1: Verify old password
        if 'old_password' in request.form:
            old_password = request.form['old_password']

            if not check_password_hash(user['password'], old_password):
                cursor.close()
                conn.close()
                session.clear()
                flash("Incorrect password. You have been logged out.", "danger")
                return redirect(url_for('login'))

            # Old password correct → show new password form
            cursor.close()
            conn.close()
            return render_template('change_pass.html', step=2)

        # STEP 2: Update new password
        if 'new_password' in request.form:
            new_password = request.form['new_password']
            confirm_password = request.form['confirm_password']

            if new_password != confirm_password:
                flash("Passwords do not match", "danger")
                cursor.close()
                conn.close()
                return render_template('change_pass.html', step=2)

            hashed_password = generate_password_hash(new_password)
            cursor.execute(
                "UPDATE users SET password = %s WHERE id = %s",
                (hashed_password, session['user_id'])
            )
            conn.commit()

            cursor.close()
            conn.close()

            flash("Password changed successfully!", "success")
            return redirect(url_for('dashboard'))

    cursor.close()
    conn.close()
    return render_template('change_pass.html', step=1)

if __name__ == '__main__':
    app.run(debug=True)
