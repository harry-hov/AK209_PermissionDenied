import os
import flask
from flask import request, jsonify, flash, request, redirect, url_for
from werkzeug.utils import secure_filename
import numpy as np
import pickle
import csv
import random
from flask import send_from_directory
from flask_cors import CORS
import pandas as pd

# model = pickle.load(open('model.pkl', 'rb'))

UPLOAD_FOLDER = 'raw-logs'
ALLOWED_EXTENSIONS = {'txt', 'csv', 'log'}
app = flask.Flask(__name__)
CORS(app)
app.config["DEBUG"] = True
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
# Create some test data for our catalog in the


# A route to return all of the available entries in our catalog.
@app.route('/', methods=['GET','POST'])
def api_all():  
    if request.method == 'POST':
        # session['username'] = request.form['username']
        return ''
    return '''
        SIH - 2020
    '''

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        print(request.form)
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return filename + " uploaded success fully"
            # return redirect(url_for('uploaded_file',
            #                         filename=filename))
    return '''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form method=post enctype=multipart/form-data>
      <input type=file name=file>
      <input type=submit value=Upload>
      <p>logtype:</p>
     <select name="logtype">
        <option value="logtype1">23</option>
        <option value="logtype2">24</option>
        <option value='"logtype3">25</option>
     </select>
    </form>
    '''
@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'],
                               filename)
@app.route('/dummydata', methods=['GET','POST'])
def dummy_data():  
    if request.method == 'GET':
        with open('main.csv') as csv_file:
            filesize = 10000                 #size of the really big file
            offset = random.randrange(filesize)
            csv_reader = csv.DictReader(csv_file, delimiter=',')
            firstRow = next(csv_reader)
            csv_file.seek(offset)                  #go to random position
            csv_file.readline()

            head = []
            for x in range(10):
                row = next(csv_reader)
                row['Status'] = row['Threat']
                if len(row['Date']) == 5: row['Date'] = '0'+ row['Date']
                row['Date'] = f"{row['Date'][0:2]}/{row['Date'][2:4]}/{row['Date'][4:6]}"
                row['Time'] = f"{row['Time'][0:2]}:{row['Time'][2:4]}:{row['Time'][4:6]}"
                head.append(row)
        # session['username'] = request.form['username']
        return jsonify(head)
    return '''
        SIH - 2020
    '''

@app.route('/predict',methods=['POST'])
def predict():

    int_features = [int(x) for x in request.form.values()]
    final_features = [np.array(int_features)]
    prediction = model.predict(final_features)

    output = round(prediction[0], 2)

    return render_template('index.html', prediction_text='Sales should be $ {}'.format(output))

@app.route('/results',methods=['POST'])
def results():
    data = request.get_json(force=True)
    prediction = model.predict([np.array(list(data.values()))])

    output = prediction[0]
    return jsonify(output)

@app.route('/getservers',methods=['GET'])
def server():
    if request.method == 'GET':
        df =pd.read_csv('main.csv')
        df = df.groupby('Server')['Threat'].value_counts()
        servers = []
        for key, value in df.iteritems():
            servers.append([key[0],key[1],value])
        return jsonify({'servers' : servers})
    return '''
        SIH - 2020
    '''

app.run()