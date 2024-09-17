from flask import Flask, Response, jsonify, render_template, request, redirect, url_for, session ,flash , send_file
import pandas as pd
from werkzeug.utils import secure_filename
from werkzeug.security import check_password_hash,generate_password_hash
from werkzeug.utils import secure_filename
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
import bcrypt 

app = Flask(__name__)
app.secret_key = 'xyzsdfg'

app.config['MYSQL_HOST'] = 'localhost'    #10.102.145.1
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'amt'
mysql = MySQL(app)

@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('email', None)
    return redirect(url_for('login'))

@app.route('/')
@app.route('/login', methods=['GET', 'POST'])
def login():
    message = ''
    if request.method == 'POST' and 'email' in request.form and 'password' in request.form:
        email = request.form['email']
        password = request.form['password']

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM user WHERE email = %s', (email,))
        user = cursor.fetchone()

        if user is None:
            message = 'No user found with this email address.'
        elif user['status'] == 'Not_Approved':
            message = 'Your Account has not been approved. Contact your reporting manager.'
        elif user['status'] == 'rejected':
            message = 'Your Account has been rejected. Contact your reporting manager.'
        elif bcrypt.checkpw(password.encode('utf-8'), user['password'].encode('utf-8')):
            session['loggedin'] = True
            session['id'] = user['id']
            session['uname'] = user['uname']
            session['email'] = user['email']
            session['type'] = user['type']
            session['tname'] = user['tname']
            flash("Login Successful")
            return redirect(url_for('device_tracking'))
        else:
            message = 'Please enter correct email/password!'

    return render_template('login.html', message=message)
app.config['UPLOAD_FOLDER3'] = 'static/img/posigned/'  # Your desired path
app.config['ALLOWED_EXTENSIONS'] = {'pdf','jpg','png'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

@app.route('/upload_poc_signed', methods=['POST'])
def upload_poc_signed():
    id = request.form['id']
    project_details = request.form['project_details']
    
    
    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    
    file = request.files['file']
    
    if file.filename == '':
        flash('No selected file')
        return redirect(request.url)
    
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        upload_path = os.path.join(app.config['UPLOAD_FOLDER3'], filename)
        file.save(upload_path)
        
        # Update database with the file path
        cur = mysql.connection.cursor()
        cur.execute("UPDATE device_tracking SET posigneddoc=%s,pdesc=%s,status='Delivered' WHERE id=%s", (upload_path, project_details,id))
        mysql.connection.commit()
        cur.close()
        
        flash('File successfully uploaded and database updated')
        return redirect('/device_tracking')  # Change 'index' to your desired redirect page
    
    flash('Allowed file type is pdf')
    return redirect(request.url)  

@app.route('/device_tracking')
def device_tracking():
    cur = mysql.connection.cursor()

    # Fetch all device tracking data
    cur.execute('SELECT * FROM device_tracking')
    data = cur.fetchall()

    # Fetch the required project start data
    cur.execute('SELECT MAX(completion_percentage) as project_start, did FROM comments GROUP BY did')
    project_start_data = cur.fetchall()

    # Fetch usernames (if needed)
    cur.execute('SELECT uname FROM user')
    users = cur.fetchall()

    mysql.connection.commit()
    cur.close()

    # Convert project_start_data to a dictionary for easy lookup
    project_start_dict = {row[1]: row[0] for row in project_start_data}

    # Render the template
    if 'loggedin' in session:
        return render_template('device_tracking.html', data=data, users=users, project_start_dict=project_start_dict)
    return redirect('/login')

app.config['UPLOAD_FOLDER2'] = 'static/img/po/'
app.config['ALLOWED_EXTENSIONS'] = {'pdf'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

@app.route('/addtracking', methods=['POST','GET'])
def addtracking():
    if request.method == 'POST':
        pid = request.form['pid']
        pname = request.form['pname']
        pono = request.form['pono']
        assigned_engineer = request.form['Assigned_Engineer']
        location = request.form['location']

        # Handle file upload
        if 'Po_Upload' not in request.files:
            return redirect(request.url)
        file = request.files['Po_Upload']
        if file and allowed_file(file.filename):
            filename = file.filename
            file_path = os.path.join(app.config['UPLOAD_FOLDER2'], filename)
            file.save(file_path)

            # Insert data into MySQL database
            cur = mysql.connection.cursor()
            cur.execute("""
                INSERT INTO device_tracking (pid, pname, pono, assigned_engineer, location, Po_Upload)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (pid, pname, pono, assigned_engineer, location, file_path))
            mysql.connection.commit()
            cur.close()
    return redirect('/device_tracking')     
@app.route('/add_comment', methods=['POST'])
def add_comment():
    
    if request.method == 'POST':
        did=request.form['did']
        comment = request.form['comment']
        completion_percentage = request.form['completion_percentage']
 
        # Handle file upload
        if 'comment_file' in request.files:
            file = request.files['comment_file']
            if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                upload_path = os.path.join(app.config['UPLOAD_FOLDER3'], filename)
                file.save(upload_path)
            else:
                upload_path = None
        else:
            upload_path = None
 
        # Insert data into the comments table
        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO comments (did, comment, completion_percentage, comment_file)
            VALUES (%s, %s, %s, %s)
        """, (did, comment, completion_percentage, upload_path))
        mysql.connection.commit()
        cur.close()
 
        
        return redirect('/device_tracking')

@app.route('/get_comments/<int:did>', methods=['GET'])
def get_comments(did):
    try:
        cur = mysql.connection.cursor()
        query = '''
            SELECT c.comment, c.comment_file, c.completion_percentage, dt.assigned_engineer, c.created_at
            FROM comments c
            INNER JOIN device_tracking dt ON c.did = dt.id
            WHERE c.did = %s
            LIMIT 0, 25
        '''
        cur.execute(query, (did,))
        comments = cur.fetchall()
    except Exception as e:
        cur.close()
        return jsonify({'error': str(e)}), 500
 
    cur.close()
 
    comments_list = [
        {'serial_no': idx + 1,
         'comment': row[0],
         'file': row[1],
         'percentage': row[2],
         'assigned_engineer': row[3],
         'created_at': row[4]}
        for idx, row in enumerate(comments)]
 
    return jsonify(comments_list)    

if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0', port=5000)