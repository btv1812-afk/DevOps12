from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)

CSV_FILE = "students.csv"
FIELDS = ["id", "first_name", "last_name", "age"]

# --- Read students from CSV ---
def read_students():
    # If file doesn't exist, create it with header
    if not os.path.exists(CSV_FILE):
        with open(CSV_FILE, "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=FIELDS)
            writer.writeheader()

    with open(CSV_FILE, "r", newline="") as f:
        reader = csv.DictReader(f)
        return list(reader)

# --- Write students to CSV ---
def write_students(students):
    with open(CSV_FILE, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=FIELDS)
        writer.writeheader()
        writer.writerows(students)


# --- Routes ---
@app.route("/")
def home():
    return jsonify({"message": "API is working"})

# GET all students
@app.route("/students", methods=['GET'])
def ge_all_students():
    students = read_students()
    return jsonify(students), 200


# --- POST add student ---
@app.route('/students', methods=['POST'])
def add_student():
    data = request.json
    if not data:
        return jsonify({"error": "No JSON provided"}), 400

    # check fields
    required = ["first_name", "last_name", "age"]
    if not all(field in data for field in required):
        return jsonify({"error": f"Missing required fields: {required}"}), 400

    students = read_students()

    # generate a new ID:
    new_id = max([int(s["id"]) for s in students], default=0) + 1

    new_student = {
        "id": str(new_id),
        "first_name": data["first_name"],
        "last_name": data["last_name"],
        "age": str(data["age"])
    }

    students.append(new_student)
    write_students(students)

    return jsonify(new_student), 201


# GET student by ID
@app.route('/students/<int:student_id>', methods=['GET'])
def get_student_by_id(student_id):
    students = read_students()
    for student in students:
        if student ['id']== str(student_id):
            return jsonify(student), 200

    return  jsonify({'error':f'Student with id {student_id} not found'}), 404


#GET students by last name
@app.route('/students/lastname/<last_name>', methods=['GET'])
def get_students_by_last_name(last_name):
    students = read_students()
    matched = [s for s in students if s['last_name'].lower() == last_name.lower()]
    if matched:
        return jsonify(matched), 200
    return jsonify({'error': f'No students found with last name {last_name}'}), 404

# PUT method
@app.route('/students/<int:student_id>', methods=['PUT'])
def update_student(student_id):
    data = request.json
    if not data:
        return jsonify({"error": "No JSON provided"}), 400

    required = ["first_name", "last_name", "age"]
    if not all(field in data for field in required):
        return jsonify({"error": f"Missing required fields: {required}"}), 400

    students = read_students()
    for student in students:
        if student['id'] == str(student_id):
            student['first_name'] = data['first_name']
            student['last_name'] = data['last_name']
            student['age'] = str(data['age'])
            write_students(students)
            return jsonify(student), 200

    return jsonify({"error": f"Student with id {student_id} not found"}), 404


# Patch method
@app.route('/students/<int:student_id>', methods=['PATCH'])
def patch_student_age(student_id):
    data = request.json
    if not data or 'age' not in data:
        return jsonify({"error": "Field 'age' is required"}), 400

    students = read_students()
    for student in students:
        if student['id'] == str(student_id):
            student['age'] = str(data['age'])
            write_students(students)
            return jsonify(student), 200

    return jsonify({"error": f"Student with id {student_id} not found"}), 404

# DELETE method
@app.route('/students/<int:student_id>', methods=['DELETE'])
def delete_student(student_id):
    students = read_students()
    new_students = [s for s in students if s['id'] != str(student_id)]

    if len(new_students) == len(students):
        return jsonify({"error": f"Student with id {student_id} not found"}), 404

    write_students(new_students)
    return jsonify({"message": f"Student with id {student_id} has been deleted"}), 200


# --- Run server ---
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

