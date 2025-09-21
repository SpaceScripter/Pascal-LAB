import csv

# Updated student data (6 students with new names and IDs)
students = [
    {"Student": 1, "ID": "1008", "Name": "Sabrina Harrington", "houseChoice": 1, "regChoice": 2},
    {"Student": 2, "ID": "1011", "Name": "Phoenix Boodoosingh", "houseChoice": 1, "regChoice": 2},
    {"Student": 3, "ID": "2011", "Name": "Fayad Winston", "houseChoice": 2, "regChoice": 1},
    {"Student": 4, "ID": "2010", "Name": "Lora-Leigh Boodoosingh", "houseChoice": 2, "regChoice": 2},
    {"Student": 5, "ID": "3012", "Name": "Tilak Yadav", "houseChoice": 3, "regChoice": 1},
    {"Student": 6, "ID": "4005", "Name": "Jigness Maharaj", "houseChoice": 4, "regChoice": 2},
]

# Initialize variables in the order they appear in the executable code
variables = [
    'alphaTrack', 'alphaField', 'betaTrack', 'betaField',
    'deltaTrack', 'deltaField', 'gammaTrack', 'gammaField',
    'x', 'id', 'name', 'houseChoice', 'house', 'regChoice',
    'totalAlpha', 'totalBeta', 'totalDelta', 'totalGamma',
    'totalAlphaPersons', 'totalBetaPersons', 'totalDeltaPersons', 'totalGammaPersons'
]

state = {
    'alphaTrack': 0, 'alphaField': 0, 'betaTrack': 0, 'betaField': 0,
    'deltaTrack': 0, 'deltaField': 0, 'gammaTrack': 0, 'gammaField': 0,
    'x': None, 'id': None, 'name': None, 'houseChoice': None,
    'house': None, 'regChoice': None,
    'totalAlpha': None, 'totalBeta': None, 'totalDelta': None, 'totalGamma': None,
    'totalAlphaPersons': None, 'totalBetaPersons': None, 'totalDeltaPersons': None, 'totalGammaPersons': None
}

# Store trace table rows: [line_number, variable_states, expected_output]
trace_table = []

# Helper function to add a state to the trace table
def add_state(line, output=""):
    current_state = [line] + [state.get(var, None) for var in variables] + [output]
    trace_table.append(current_state)

# Simulate the Pascal program - ONLY numbered lines {1}-{75}
# Initial assignments (lines {1}-{9})
state['alphaTrack'] = 0
add_state(1, "alphaTrack := 0")
state['alphaField'] = 0
add_state(2, "alphaField := 0")
state['betaTrack'] = 0
add_state(3, "betaTrack := 0")
state['betaField'] = 0
add_state(4, "betaField := 0")
state['deltaTrack'] = 0
add_state(5, "deltaTrack := 0")
state['deltaField'] = 0
add_state(6, "deltaField := 0")
state['gammaTrack'] = 0
add_state(7, "gammaTrack := 0")
state['gammaField'] = 0
add_state(8, "gammaField := 0")
add_state(9, "Writeln('     Welcome to the Sports Registration          ')")

# For loop (6 iterations instead of 12)
for student in students:
    state['x'] = student["Student"]
    add_state(10, f"For x := 1 To 12 Do")  # Note: Pascal says 12, but we have 6 students
    add_state(11, f"Writeln('-----[ Registering Student {student['Student']} of 12 ]-----')")
    
    add_state(12, "Write('Enter Student ID: ')")
    state['id'] = student["ID"]
    add_state(13, f"Readln(id) = {state['id']}")
    
    add_state(14, "Write('Enter Full Name: ')")
    state['name'] = student["Name"]
    add_state(15, f"Readln(name) = {state['name']}")
    
    # House Selection validation loop (lines {16}-{25})
    # First iteration - valid input
    add_state(16, "Writeln('Select House:')")
    add_state(17, "Writeln('  1. Alpha')")
    add_state(18, "Writeln('  2. Beta')")
    add_state(19, "Writeln('  3. Delta')")
    add_state(20, "Writeln('  4. Gamma')")
    add_state(21, "Write('Enter choice (1-4): ')")
    state['houseChoice'] = student["houseChoice"]
    add_state(22, f"Readln(houseChoice) = {state['houseChoice']}")
    
    # Validation check - all our students have valid choices (1-4)
    if state['houseChoice'] < 1 or state['houseChoice'] > 4:
        add_state(23, f"If (houseChoice < 1) OR (houseChoice > 4) Then")
        add_state(24, "Writeln('Invalid choice. Please select a house between 1 and 4.')")
        # Would loop back, but our data is valid so we exit
    add_state(25, f"Until (houseChoice >= 1) AND (houseChoice <= 4)")
    
    # House assignment (lines {26}-{30})
    add_state(26, "Case houseChoice Of")
    if state['houseChoice'] == 1:
        state['house'] = "ALPHA"
        add_state(27, f"1: house := 'ALPHA' = {state['house']}")
    elif state['houseChoice'] == 2:
        state['house'] = "BETA"
        add_state(28, f"2: house := 'BETA' = {state['house']}")
    elif state['houseChoice'] == 3:
        state['house'] = "DELTA"
        add_state(29, f"3: house := 'DELTA' = {state['house']}")
    elif state['houseChoice'] == 4:
        state['house'] = "GAMMA"
        add_state(30, f"4: house := 'GAMMA' = {state['house']}")
    
    # Registration Type validation loop (lines {31}-{38})
    # First iteration - valid input
    add_state(31, "Writeln('Select Registration Type:')")
    add_state(32, "Writeln('  1. Track ($50 USD)')")
    add_state(33, "Writeln('  2. Field ($40 USD)')")
    add_state(34, "Write('Enter choice (1-2): ')")
    state['regChoice'] = student["regChoice"]
    add_state(35, f"Readln(regChoice) = {state['regChoice']}")
    
    # Validation check - all our students have valid choices (1-2)
    if state['regChoice'] < 1 or state['regChoice'] > 2:
        add_state(36, f"If (regChoice < 1) OR (regChoice > 2) Then")
        add_state(37, "Writeln('Invalid choice. Please select a registration type between 1 and 2.')")
        # Would loop back, but our data is valid so we exit
    add_state(38, f"Until (regChoice = 1) OR (regChoice = 2)")
    
    # Update totals based on house and registration type (lines {39}-{51})
    add_state(39, "Case houseChoice Of")
    if state['houseChoice'] == 1:
        add_state(40, "1:")
        if state['regChoice'] == 1:
            state['alphaTrack'] += 50
            add_state(41, f"If regChoice = 1 Then alphaTrack := alphaTrack + 50 = {state['alphaTrack']}")
        else:
            state['alphaField'] += 40
            add_state(42, f"Else alphaField := alphaField + 40 = {state['alphaField']}")
    elif state['houseChoice'] == 2:
        add_state(43, "2:")
        if state['regChoice'] == 1:
            state['betaTrack'] += 50
            add_state(44, f"If regChoice = 1 Then betaTrack := betaTrack + 50 = {state['betaTrack']}")
        else:
            state['betaField'] += 40
            add_state(45, f"Else betaField := betaField + 40 = {state['betaField']}")
    elif state['houseChoice'] == 3:
        add_state(46, "3:")
        if state['regChoice'] == 1:
            state['deltaTrack'] += 50
            add_state(47, f"If regChoice = 1 Then deltaTrack := deltaTrack + 50 = {state['deltaTrack']}")
        else:
            state['deltaField'] += 40
            add_state(48, f"Else deltaField := deltaField + 40 = {state['deltaField']}")
    elif state['houseChoice'] == 4:
        add_state(49, "4:")
        if state['regChoice'] == 1:
            state['gammaTrack'] += 50
            add_state(50, f"If regChoice = 1 Then gammaTrack := gammaTrack + 50 = {state['gammaTrack']}")
        else:
            state['gammaField'] += 40
            add_state(51, f"Else gammaField := gammaField + 40 = {state['gammaField']}")
    
    # Confirmation (lines {52}-{53})
    add_state(52, "Writeln('Registration Successful!')")
    add_state(53, f"Writeln('  Name : ', name, ' | House: ', house) = {state['name']} | {state['house']}")

# Calculate totals (lines {54}-{61})
state['totalAlpha'] = state['alphaTrack'] + state['alphaField']
add_state(54, f"totalAlpha := alphaTrack + alphaField = {state['totalAlpha']}")
state['totalBeta'] = state['betaTrack'] + state['betaField']
add_state(55, f"totalBeta := betaTrack + betaField = {state['totalBeta']}")
state['totalDelta'] = state['deltaTrack'] + state['deltaField']
add_state(56, f"totalDelta := deltaTrack + deltaField = {state['totalDelta']}")
state['totalGamma'] = state['gammaTrack'] + state['gammaField']
add_state(57, f"totalGamma := gammaTrack + gammaField = {state['totalGamma']}")

state['totalAlphaPersons'] = int(state['alphaTrack'] / 50) + int(state['alphaField'] / 40)
add_state(58, f"totalAlphaPersons := Trunc(alphaTrack / 50) + Trunc(alphaField / 40) = {state['totalAlphaPersons']}")
state['totalBetaPersons'] = int(state['betaTrack'] / 50) + int(state['betaField'] / 40)
add_state(59, f"totalBetaPersons := Trunc(betaTrack / 50) + Trunc(betaField / 40) = {state['totalBetaPersons']}")
state['totalDeltaPersons'] = int(state['deltaTrack'] / 50) + int(state['deltaField'] / 40)
add_state(60, f"totalDeltaPersons := Trunc(deltaTrack / 50) + Trunc(deltaField / 40) = {state['totalDeltaPersons']}")
state['totalGammaPersons'] = int(state['gammaTrack'] / 50) + int(state['gammaField'] / 40)
add_state(61, f"totalGammaPersons := Trunc(gammaTrack / 50) + Trunc(gammaField / 40) = {state['totalGammaPersons']}")

# Summary Output (lines {62}-{75})
add_state(62, "Writeln('           FINAL REGISTRATION SUMMARY            ')")
add_state(63, "Writeln('  ALPHA HOUSE')")
add_state(64, f"Writeln('  Number of Persons in House: ', totalAlphaPersons) = {state['totalAlphaPersons']}")
add_state(65, f"Writeln('  Total: $', totalAlpha:0:2, ' USD') = ${state['totalAlpha']:.2f} USD")

add_state(66, "Writeln('  BETA HOUSE')")
add_state(67, f"Writeln('  Number of Persons in House: ', totalBetaPersons) = {state['totalBetaPersons']}")
add_state(68, f"Writeln('  Total: $', totalBeta:0:2, ' USD') = ${state['totalBeta']:.2f} USD")

add_state(69, "Writeln('  DELTA HOUSE')")
add_state(70, f"Writeln('  Number of Persons in House: ', totalDeltaPersons) = {state['totalDeltaPersons']}")
add_state(71, f"Writeln('  Total: $', totalDelta:0:2, ' USD') = ${state['totalDelta']:.2f} USD")

add_state(72, "Writeln('  GAMMA HOUSE')")
add_state(73, f"Writeln('  Number of Persons in House: ', totalGammaPersons) = {state['totalGammaPersons']}")
add_state(74, f"Writeln('  Total: $', totalGamma:0:2, ' USD') = ${state['totalGamma']:.2f} USD")

add_state(75, "Writeln('      Thank you for using the system. Goodbye!   ')")

# Create table headers
headers = ['Line #'] + variables + ['Expected Output']

# Export to CSV
with open('trace_table_updated.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(headers)  # Write headers
    writer.writerows(trace_table)  # Write all rows

print("Updated trace table has been exported to 'trace_table_updated.csv'")
print(f"Total trace entries: {len(trace_table)}")
print("Expected final totals based on 6 students:")
print(f"Alpha: {state['totalAlpha']:.2f} USD, {state['totalAlphaPersons']} persons")
print(f"Beta: {state['totalBeta']:.2f} USD, {state['totalBetaPersons']} persons")
print(f"Delta: {state['totalDelta']:.2f} USD, {state['totalDeltaPersons']} persons")
print(f"Gamma: {state['totalGamma']:.2f} USD, {state['totalGammaPersons']} persons")