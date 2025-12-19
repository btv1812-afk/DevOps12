import requests
import json

BASE_URL = "http://127.0.0.1:5000"
RESULTS_FILE = "results.txt"

# 1. GET all students
response = requests.get(f"{BASE_URL}/students")
print("1. GET all students")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("1. GET all students\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 2. POST create three students
response = requests.post(
    f"{BASE_URL}/students",
    json={"first_name": "Alice", "last_name": "Johnson", "age": 20}
)
print("2. POST student 1")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("2. POST student 1\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


response = requests.post(
    f"{BASE_URL}/students",
    json={"first_name": "Bob", "last_name": "Smith", "age": 22}
)
print("2. POST student 2")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("2. POST student 2\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


response = requests.post(
    f"{BASE_URL}/students",
    json={"first_name": "Charlie", "last_name": "Brown", "age": 25}
)
print("2. POST student 3")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("2. POST student 3\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 3. GET all students
response = requests.get(f"{BASE_URL}/students")
print("3. GET all students")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("3. GET all students\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 4. PATCH update age of second student
response = requests.patch(
    f"{BASE_URL}/students/2",
    json={"age": 30}
)
print("4. PATCH second student")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("4. PATCH second student\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 5. GET second student
response = requests.get(f"{BASE_URL}/students/2")
print("5. GET second student")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("5. GET second student\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 6. PUT update third student
response = requests.put(
    f"{BASE_URL}/students/3",
    json={"first_name": "Chris", "last_name": "Evans", "age": 35}
)
print("6. PUT third student")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("6. PUT third student\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 7. GET third student
response = requests.get(f"{BASE_URL}/students/3")
print("7. GET third student")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("7. GET third student\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 8. GET all students
response = requests.get(f"{BASE_URL}/students")
print("8. GET all students")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("8. GET all students\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 9. DELETE first student
response = requests.delete(f"{BASE_URL}/students/1")
print("9. DELETE first student")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("9. DELETE first student\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")


# 10. GET all students
response = requests.get(f"{BASE_URL}/students")
print("10. GET all students")
print(response.status_code, response.json())

with open(RESULTS_FILE, "a") as f:
    f.write("10. GET all students\n")
    f.write(str(response.status_code) + "\n")
    f.write(json.dumps(response.json(), indent=2) + "\n\n")

