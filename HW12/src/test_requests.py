import requests

BASE_URL = 'http://127.0.0.1:5000'
RESULTS_FILE = 'results.txt'

def log_result(title, response):
    output = f"\n--- {title} ---\nStatus Code: {response.status_code}\nResponse: {response.json()}\n"
    print(output)
    with open(RESULTS_FILE, 'a') as f:
        f.write(output)

def main():
    open(RESULTS_FILE, 'w').close()

    res = requests.get(f'{BASE_URL}/students')
    log_result("GET all students (initial)", res)

    students_to_create = [
        {'first_name': 'John', 'last_name': 'Doe', 'age': 20},
        {'first_name': 'Jane', 'last_name': 'Smith', 'age': 22},
        {'first_name': 'Alice', 'last_name': 'Johnson', 'age': 19},
    ]
    for i, student in enumerate(students_to_create, 1):
        res = requests.post(f'{BASE_URL}/students', json=student)
        log_result(f"POST student #{i}", res)

    res = requests.get(f'{BASE_URL}/students')
    log_result("GET all students (after POST)", res)
    all_students = res.json()

    second_student_id = int(all_students[1]['id'])
    res = requests.patch(f'{BASE_URL}/students/{second_student_id}', json={'age': 23})
    log_result("PATCH student #2 (update age)", res)

    res = requests.get(f'{BASE_URL}/students/{second_student_id}')
    log_result("GET student #2 (after PATCH)", res)

    third_student_id = int(all_students[2]['id'])
    res = requests.put(f'{BASE_URL}/students/{third_student_id}', json={
        'first_name': 'Alicia', 'last_name': 'Johnson-Smith', 'age': 21
    })
    log_result("PUT student #3 (update all fields)", res)

    res = requests.get(f'{BASE_URL}/students/{third_student_id}')
    log_result("GET student #3 (after PUT)", res)

    res = requests.get(f'{BASE_URL}/students')
    log_result("GET all students (final state)", res)

    first_student_id = int(all_students[0]['id'])
    res = requests.delete(f'{BASE_URL}/students/{first_student_id}')
    log_result("DELETE student #1", res)

    res = requests.get(f'{BASE_URL}/students')
    log_result("GET all students (after DELETE)", res)

if __name__ == '__main__':
    main()
