from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)
CSV_FILE = 'students.csv'
FIELDS = ['id', 'first_name', 'last_name', 'age']

def read_students():
    if not os.path.exists(CSV_FILE):
        return []
    with open(CSV_FILE, mode='r') as file:
        return list(csv.DictReader(file))

def write_students(students):
    with open(CSV_FILE, mode='w', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=FIELDS)
        writer.writeheader()
        writer.writerows(students)

def get_next_id(students):
    if not students:
        return 1
    return max(int(s['id']) for s in students) + 1

@app.route('/students', methods=['GET'])
def get_students():
    students = read_students()
    return jsonify(students), 200

@app.route('/students/<int:student_id>', methods=['GET'])
def get_student_by_id(student_id):
    students = read_students()
    for s in students:
        if int(s['id']) == student_id:
            return jsonify(s), 200
    return jsonify({'error': 'Student not found'}), 404

@app.route('/students/lastname/<string:last_name>', methods=['GET'])
def get_students_by_lastname(last_name):
    students = read_students()
    matched = [s for s in students if s['last_name'].lower() == last_name.lower()]
    if not matched:
        return jsonify({'error': 'No student found with that last name'}), 404
    return jsonify(matched), 200

@app.route('/students', methods=['POST'])
def add_student():
    data = request.json
    if not data or set(data.keys()) != {'first_name', 'last_name', 'age'}:
        return jsonify({'error': 'Invalid fields'}), 400
    students = read_students()
    student = {
        'id': str(get_next_id(students)),
        'first_name': data['first_name'],
        'last_name': data['last_name'],
        'age': str(data['age'])
    }
    students.append(student)
    write_students(students)
    return jsonify(student), 201

@app.route('/students/<int:student_id>', methods=['PUT'])
def update_student(student_id):
    data = request.json
    if not data or set(data.keys()) != {'first_name', 'last_name', 'age'}:
        return jsonify({'error': 'Invalid fields'}), 400
    students = read_students()
    for student in students:
        if int(student['id']) == student_id:
            student.update({
                'first_name': data['first_name'],
                'last_name': data['last_name'],
                'age': str(data['age'])
            })
            write_students(students)
            return jsonify(student), 200
    return jsonify({'error': 'Student not found'}), 404

@app.route('/students/<int:student_id>', methods=['PATCH'])
def patch_student(student_id):
    data = request.json
    if not data or set(data.keys()) != {'age'}:
        return jsonify({'error': 'Invalid fields'}), 400
    students = read_students()
    for student in students:
        if int(student['id']) == student_id:
            student['age'] = str(data['age'])
            write_students(students)
            return jsonify(student), 200
    return jsonify({'error': 'Student not found'}), 404

@app.route('/students/<int:student_id>', methods=['DELETE'])
def delete_student(student_id):
    students = read_students()
    new_students = [s for s in students if int(s['id']) != student_id]
    if len(students) == len(new_students):
        return jsonify({'error': 'Student not found'}), 404
    write_students(new_students)
    return jsonify({'message': 'Student deleted successfully'}), 200

if __name__ == '__main__':
    app.run(debug=True)
