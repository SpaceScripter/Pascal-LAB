import csv

# Sample student data (all 12 students)
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
    {"Student": 12, "ID": "ST012", "Name": "Liam", "houseChoice": 4, "regChoice": 1},
]

# Initialize variables in the order they appear in the executable code
variables = [
    'alphaTrack', 'alphaField', 'betaTrack', 'betaField',
    'deltaTrack', 'deltaField', 'gammaTrack', 'gammaField',
    'x', 'id', 'name', 'houseChoice', 'house', 'regChoice', 'regType',
    'totalAlpha', 'totalBeta', 'totalDelta', 'totalGamma',
    'totalAlphaPersons', 'totalBetaPersons', 'totalDeltaPersons', 'totalGammaPersons'
]
state = {
    'alphaTrack': 0, 'alphaField': 0, 'betaTrack': 0, 'betaField': 0,
    'deltaTrack': 0, 'deltaField': 0, 'gammaTrack': 0, 'gammaField': 0,
    'x': None, 'id': None, 'name': None, 'houseChoice': None,
    'house': None, 'regChoice': None, 'regType': None,
    'totalAlpha': None, 'totalBeta': None, 'totalDelta': None, 'totalGamma': None,
    'totalAlphaPersons': None, 'totalBetaPersons': None, 'totalDeltaPersons': None, 'totalGammaPersons': None
}

# Store trace table rows: [line_number, variable_states, expected_output]
trace_table = []

# Helper function to add a state to the trace table
def add_state(line, output=""):
    current_state = [line] + [state.get(var, None) for var in variables] + [output]
    trace_table.append(current_state)

# Simulate the Pascal program
# Initial assignments (lines 1-9)
add_state(1, "")  # ClrScr (no output or variable change)
state['alphaTrack'] = 0
add_state(2, "")
state['alphaField'] = 0
add_state(3, "")
state['betaTrack'] = 0
add_state(4, "")
state['betaField'] = 0
add_state(5, "")
state['deltaTrack'] = 0
add_state(6, "")
state['deltaField'] = 0
add_state(7, "")
state['gammaTrack'] = 0
add_state(8, "")
state['gammaField'] = 0
add_state(9, "")

# Welcome messages (lines 10-13)
add_state(10, "-------------------------------------------------")
add_state(11, "     Welcome to the Sports Registration       ")
add_state(12, "-------------------------------------------------")
add_state(13, "")

# For loop (12 full iterations)
for student in students:
    state['x'] = student["Student"]
    add_state(14, "")  # For x := 1 To 12 Do Begin
    add_state(15, f"─[ Registering Student {student['Student']} of 12 ]─")

    add_state(16, "Enter Student ID: ")  # Write
    state['id'] = student["ID"]
    add_state(17, f"Student ID entered: {state['id']}")  # Readln

    add_state(18, "Enter Full Name: ")  # Write
    state['name'] = student["Name"]
    add_state(19, f"Full Name entered: {state['name']}")  # Readln

    # House Selection (lines 20-27)
    add_state(20, "Select House:")
    add_state(21, "  1. Alpha")
    add_state(22, "  2. Beta")
    add_state(23, "  3. Delta")
    add_state(24, "  4. Gamma")
    add_state(25, "Enter choice (1-4): ")  # Write
    state['houseChoice'] = student["houseChoice"]
    add_state(26, f"House choice entered: {state['houseChoice']}")  # Readln
    add_state(27, "")  # Until ((houseChoice >= 1) And (houseChoice <= 4))

    # Case statement (lines 28-32)
    add_state(28, "")  # Case houseChoice Of
    if state['houseChoice'] == 1:
        state['house'] = "ALPHA"
        add_state(29, "")  # 1: house := 'ALPHA'
    elif state['houseChoice'] == 2:
        state['house'] = "BETA"
        add_state(30, "")  # 2: house := 'BETA'
    elif state['houseChoice'] == 3:
        state['house'] = "DELTA"
        add_state(31, "")  # 3: house := 'DELTA'
    elif state['houseChoice'] == 4:
        state['house'] = "GAMMA"
        add_state(32, "")  # 4: house := 'GAMMA'
    add_state(33, "")  # End (implicit end of Case)

    # Registration Type (lines 34-38)
    add_state(34, "Select Registration Type:")
    add_state(35, "  1. Track")
    add_state(36, "  2. Field")
    add_state(37, "Enter choice (1-2): ")  # Write
    state['regChoice'] = student["regChoice"]
    add_state(38, f"Registration choice entered: {state['regChoice']}")  # Readln

    # Case statement (lines 39-41)
    add_state(39, "")  # Case regChoice Of
    if state['regChoice'] == 1:
        state['regType'] = "TRACK"
        add_state(40, "")  # 1: regType := 'TRACK'
    else:
        state['regType'] = "FIELD"
        add_state(41, "")  # 2: regType := 'FIELD'
    add_state(42, "")  # End (implicit end of Case)

    # Update house totals (lines 43-57)
    add_state(43, "")  # If (regType = 'TRACK') Then
    if state['house'] == "ALPHA":
        if state['regType'] == "TRACK":
            state['alphaTrack'] += 50
            add_state(44, f"alphaTrack updated to {state['alphaTrack']}")
        else:
            state['alphaField'] += 40
            add_state(45, f"alphaField updated to {state['alphaField']}")
    add_state(46, "")  # Else If (house = 'BETA') Then
    if state['house'] == "BETA":
        if state['regType'] == "TRACK":
            state['betaTrack'] += 50
            add_state(48, f"betaTrack updated to {state['betaTrack']}")
        else:
            state['betaField'] += 40
            add_state(49, f"betaField updated to {state['betaField']}")
    add_state(50, "")  # Else If (house = 'DELTA') Then
    if state['house'] == "DELTA":
        if state['regType'] == "TRACK":
            state['deltaTrack'] += 50
            add_state(52, f"deltaTrack updated to {state['deltaTrack']}")
        else:
            state['deltaField'] += 40
            add_state(53, f"deltaField updated to {state['deltaField']}")
    add_state(54, "")  # Else If (house = 'GAMMA') Then
    if state['house'] == "GAMMA":
        if state['regType'] == "TRACK":
            state['gammaTrack'] += 50
            add_state(56, f"gammaTrack updated to {state['gammaTrack']}")
        else:
            state['gammaField'] += 40
            add_state(57, f"gammaField updated to {state['gammaField']}")

    add_state(58, "")
    add_state(59, " Registration Successful!")
    add_state(60, f"  Name : {state['name']}")
    add_state(61, f"  House: {state['house']}")
    add_state(62, "")  # ClrScr (no output)
    add_state(63, "-------------------------------------------------")
    add_state(64, "")  # Return to line 14 for next student

# Compute totals (lines 65-68)
state['totalAlpha'] = state['alphaTrack'] + state['alphaField']
add_state(65, f"totalAlpha := {state['alphaTrack']} + {state['alphaField']} = {state['totalAlpha']}")
state['totalBeta'] = state['betaTrack'] + state['betaField']
add_state(66, f"totalBeta := {state['betaTrack']} + {state['betaField']} = {state['totalBeta']}")
state['totalDelta'] = state['deltaTrack'] + state['deltaField']
add_state(67, f"totalDelta := {state['deltaTrack']} + {state['deltaField']} = {state['totalDelta']}")
state['totalGamma'] = state['gammaTrack'] + state['gammaField']
add_state(68, f"totalGamma := {state['gammaTrack']} + {state['gammaField']} = {state['totalGamma']}")

# Compute total persons (lines 69-72)
state['totalAlphaPersons'] = int(state['alphaTrack'] / 50) + int(state['alphaField'] / 40)
add_state(69, f"totalAlphaPersons := {int(state['alphaTrack'] / 50)} + {int(state['alphaField'] / 40)} = {state['totalAlphaPersons']}")
state['totalBetaPersons'] = int(state['betaTrack'] / 50) + int(state['betaField'] / 40)
add_state(70, f"totalBetaPersons := {int(state['betaTrack'] / 50)} + {int(state['betaField'] / 40)} = {state['totalBetaPersons']}")
state['totalDeltaPersons'] = int(state['deltaTrack'] / 50) + int(state['deltaField'] / 40)
add_state(71, f"totalDeltaPersons := {int(state['deltaTrack'] / 50)} + {int(state['deltaField'] / 40)} = {state['totalDeltaPersons']}")
state['totalGammaPersons'] = int(state['gammaTrack'] / 50) + int(state['gammaField'] / 40)
add_state(72, f"totalGammaPersons := {int(state['gammaTrack'] / 50)} + {int(state['gammaField'] / 40)} = {state['totalGammaPersons']}")

# Summary (lines 73-100)
add_state(73, "")
add_state(74, "-------------------------------------------------")
add_state(75, "           FINAL REGISTRATION SUMMARY            ")
add_state(76, "-------------------------------------------------")
add_state(77, "")
add_state(78, "  ALPHA HOUSE")
add_state(79, f"  Number of Persons in House: {state['totalAlphaPersons']}")
add_state(80, f"  Total: ${state['totalAlpha']:0.2f} USD")
add_state(81, "-------------------------------------------------")
add_state(82, "")
add_state(83, "  BETA HOUSE")
add_state(84, f"  Number of Persons in House: {state['totalBetaPersons']}")
add_state(85, f"  Total: ${state['totalBeta']:0.2f} USD")
add_state(86, "-------------------------------------------------")
add_state(87, "")
add_state(88, "  DELTA HOUSE")
add_state(89, f"  Number of Persons in House: {state['totalDeltaPersons']}")
add_state(90, f"  Total: ${state['totalDelta']:0.2f} USD")
add_state(91, "-------------------------------------------------")
add_state(92, "")
add_state(93, "  GAMMA HOUSE")
add_state(94, f"  Number of Persons in House: {state['totalGammaPersons']}")
add_state(95, f"  Total: ${state['totalGamma']:0.2f} USD")
add_state(96, "-------------------------------------------------")
add_state(97, "-------------------------------------------------")
add_state(98, "      Thank you for using the system. Goodbye!   ")
add_state(99, "-------------------------------------------------")
add_state(100, "")  # Readln

# Create table headers
headers = ['Line #'] + variables + ['Expected Output']

# Export to CSV
with open('trace_table.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(headers)  # Write headers
    writer.writerows(trace_table)  # Write all rows

print("Trace table has been exported to 'trace_table.csv'")