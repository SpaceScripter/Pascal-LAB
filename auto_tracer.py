from tabulate import tabulate
import csv

# Sample student data
students = [
    {"Student": 1, "ID": "ST001", "Name": "Alice", "houseChoice": 1, "regChoice": 1},
    {"Student": 2, "ID": "ST002", "Name": "Bob", "houseChoice": 1, "regChoice": 2},
    {"Student": 3, "ID": "ST003", "Name": "Cara", "houseChoice": 2, "regChoice": 1},
    {"Student": 4, "ID": "ST004", "Name": "David", "houseChoice": 3, "regChoice": 1},
    {"Student": 5, "ID": "ST005", "Name": "Eva", "houseChoice": 3, "regChoice": 2},
    {"Student": 6, "ID": "ST006", "Name": "Frank", "houseChoice": 2, "regChoice": 2},
    {"Student": 7, "ID": "ST007", "Name": "Grace", "houseChoice": 4, "regChoice": 1},
    {"Student": 8, "ID": "ST008", "Name": "Henry", "houseChoice": 4, "regChoice": 2},
    {"Student": 9, "ID": "ST009", "Name": "Isla", "houseChoice": 1, "regChoice": 1},
    {"Student": 10, "ID": "ST010", "Name": "Jack", "houseChoice": 2, "regChoice": 2},
    {"Student": 11, "ID": "ST011", "Name": "Kira", "houseChoice": 3, "regChoice": 2},
    {"Student": 12, "ID": "ST012", "Name": "Liam", "houseChoice": 4, "regChoice": 1}
]

# Initialize variables in the order they appear in the executable code
variables = [
    'alphaTrack', 'alphaField', 'betaTrack', 'betaField',
    'deltaTrack', 'deltaField', 'gammaTrack', 'gammaField',
    'x', 'id', 'name', 'houseChoice', 'house', 'regChoice', 'regType',
    'totalAlpha', 'totalBeta', 'totalDelta', 'totalGamma'
]
state = {
    'alphaTrack': 0, 'alphaField': 0, 'betaTrack': 0, 'betaField': 0,
    'deltaTrack': 0, 'deltaField': 0, 'gammaTrack': 0, 'gammaField': 0,
    'x': None, 'id': None, 'name': None, 'houseChoice': None,
    'house': None, 'regChoice': None, 'regType': None,
    'totalAlpha': None, 'totalBeta': None, 'totalDelta': None, 'totalGamma': None
}

# Store trace table rows: [line_number, variable_states, expected_output]
trace_table = []

# Current line number
line_number = 0

# Helper function to add a state to the trace table
def add_state(line, output=""):
    global line_number
    line_number += 1
    current_state = [line_number] + [state[var] for var in variables] + [output]
    trace_table.append(current_state)

# Simulate the Pascal program
# Initial assignments
state['alphaTrack'] = 0
add_state(1)
state['alphaField'] = 0
add_state(2)
state['betaTrack'] = 0
add_state(3)
state['betaField'] = 0
add_state(4)
state['deltaTrack'] = 0
add_state(5)
state['deltaField'] = 0
add_state(6)
state['gammaTrack'] = 0
add_state(7)
state['gammaField'] = 0
add_state(8)

# Welcome messages
add_state(9, "-------------------------------------------------")
add_state(10, "     Welcome to the Sports Registration       ")
add_state(11, "-------------------------------------------------")
add_state(12, "")

# For loop (12 iterations based on sample data)
for student in students:
    state['x'] = student["Student"]
    add_state(13, f"─[ Registering Student {student['Student']} of 12 ]─")

    # Set inputs from sample data
    state['id'] = student["ID"]
    state['name'] = student["Name"]
    state['houseChoice'] = student["houseChoice"]
    state['regChoice'] = student["regChoice"]

    add_state(14, "Enter Student ID: ")
    add_state(15, f"Student ID entered: {state['id']}")
    add_state(16, "Enter Full Name: ")
    add_state(17, f"Full Name entered: {state['name']}")

    # House selection loop
    add_state(18, "Select House:")
    add_state(19, "  1. Alpha")
    add_state(20, "  2. Beta")
    add_state(21, "  3. Delta")
    add_state(22, "  4. Gamma")
    add_state(23, f"House choice entered: {state['houseChoice']}")
    if state['houseChoice'] == 1:
        state['house'] = "ALPHA"
    elif state['houseChoice'] == 2:
        state['house'] = "BETA"
    elif state['houseChoice'] == 3:
        state['house'] = "DELTA"
    elif state['houseChoice'] == 4:
        state['house'] = "GAMMA"
    add_state(24, f"House set to: {state['house']}")

    # Registration type loop
    add_state(25, "Select Registration Type:")
    add_state(26, "  1. Track")
    add_state(27, "  2. Field")
    add_state(28, f"Registration choice entered: {state['regChoice']}")
    if state['regChoice'] == 1:
        state['regType'] = "TRACK"
    else:
        state['regType'] = "FIELD"
    add_state(29, f"Registration type set to: {state['regType']}")

    # Update totals
    add_state(30, f"If (house = {state['house']}) Then")
    if state['house'] == "ALPHA":
        if state['regType'] == "TRACK":
            state['alphaTrack'] += 50
            add_state(31, f"alphaTrack updated to {state['alphaTrack']}")
        else:
            state['alphaField'] += 40
            add_state(31, f"alphaField updated to {state['alphaField']}")
    elif state['house'] == "BETA":
        if state['regType'] == "TRACK":
            state['betaTrack'] += 50
            add_state(31, f"betaTrack updated to {state['betaTrack']}")
        else:
            state['betaField'] += 40
            add_state(31, f"betaField updated to {state['betaField']}")
    elif state['house'] == "DELTA":
        if state['regType'] == "TRACK":
            state['deltaTrack'] += 50
            add_state(31, f"deltaTrack updated to {state['deltaTrack']}")
        else:
            state['deltaField'] += 40
            add_state(31, f"deltaField updated to {state['deltaField']}")
    elif state['house'] == "GAMMA":
        if state['regType'] == "TRACK":
            state['gammaTrack'] += 50
            add_state(31, f"gammaTrack updated to {state['gammaTrack']}")
        else:
            state['gammaField'] += 40
            add_state(31, f"gammaField updated to {state['gammaField']}")

    add_state(32, "")
    add_state(33, " Registration Successful!")
    add_state(34, f"  Name : {state['name']}")
    add_state(35, f"  House: {state['house']}")
    add_state(36, "-------------------------------------------------")
    add_state(37, "")

# Compute totals
state['totalAlpha'] = state['alphaTrack'] + state['alphaField']
add_state(38, f"totalAlpha := {state['alphaTrack']} + {state['alphaField']} = {state['totalAlpha']}")
state['totalBeta'] = state['betaTrack'] + state['betaField']
add_state(39, f"totalBeta := {state['betaTrack']} + {state['betaField']} = {state['totalBeta']}")
state['totalDelta'] = state['deltaTrack'] + state['deltaField']
add_state(40, f"totalDelta := {state['deltaTrack']} + {state['deltaField']} = {state['totalDelta']}")
state['totalGamma'] = state['gammaTrack'] + state['gammaField']
add_state(41, f"totalGamma := {state['gammaTrack']} + {state['gammaField']} = {state['totalGamma']}")

# Summary (abbreviated for brevity)
add_state(42, "-------------------------------------------------")
add_state(43, "           FINAL REGISTRATION SUMMARY            ")
add_state(44, "-------------------------------------------------")
add_state(45, f"  ALPHA HOUSE - Track Athletes: {int(state['alphaTrack'] / 50)}, Field Athletes: {int(state['alphaField'] / 40)}, Total: ${state['totalAlpha']:0.2f}")
add_state(46, f"  BETA HOUSE - Track Athletes: {int(state['betaTrack'] / 50)}, Field Athletes: {int(state['betaField'] / 40)}, Total: ${state['totalBeta']:0.2f}")
add_state(47, f"  DELTA HOUSE - Track Athletes: {int(state['deltaTrack'] / 50)}, Field Athletes: {int(state['deltaField'] / 40)}, Total: ${state['totalDelta']:0.2f}")
add_state(48, f"  GAMMA HOUSE - Track Athletes: {int(state['gammaTrack'] / 50)}, Field Athletes: {int(state['gammaField'] / 40)}, Total: ${state['totalGamma']:0.2f}")
add_state(49, "      Thank you for using the system. Goodbye!   ")
add_state(50, "-------------------------------------------------")

# Create table headers
headers = ['Line #'] + variables + ['Expected Output']

# Print the trace table
print(tabulate(trace_table, headers=headers, tablefmt='grid', stralign='center', numalign='center', floatfmt='.2f'))

# Export to CSV
with open('trace_table.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(headers)  # Write headers
    writer.writerows(trace_table)  # Write all rows

print("Trace table has been exported to 'trace_table.csv'")