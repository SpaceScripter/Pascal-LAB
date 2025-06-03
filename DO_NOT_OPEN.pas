Program SportsRegistrationSystem;

Uses Crt;

Const
  NumStudents = 12;
  NumHouses = 4;
  HouseNames: array[1..NumHouses] of String = ('ALPHA', 'BETA', 'DELTA', 'GAMMA');
  TrackFee = 50;
  FieldFee = 40;

Var
  x, id, houseChoice, regChoice: Integer;
  name, regType: String;
  trackTotals, fieldTotals, personCounts: array[1..NumHouses] of Real;
  totalFees: array[1..NumHouses] of Real;

Begin
  ClrScr;

  // Initialize totals
  For x := 1 To NumHouses Do
  Begin
    trackTotals[x] := 0;
    fieldTotals[x] := 0;
    personCounts[x] := 0;
  End;

  Writeln('-------------------------------------------------');
  Writeln('     Welcome to the Sports Registration          ');
  Writeln('-------------------------------------------------');
  Writeln;

  For x := 1 To NumStudents Do
  Begin
    Writeln('─[ Registering Student ', x, ' of ', NumStudents, ' ]─');

    Write('Enter Student ID: ');
    Readln(id);

    Write('Enter Full Name: ');
    Readln(name);

    Repeat
      Writeln('Select House:');
      Writeln('  1. Alpha');
      Writeln('  2. Beta');
      Writeln('  3. Delta');
      Writeln('  4. Gamma');
      Write('Enter choice (1-4): ');
      Readln(houseChoice);
    Until (houseChoice >= 1) And (houseChoice <= 4);

    Repeat
      Writeln('Select Registration Type:');
      Writeln('  1. Track');
      Writeln('  2. Field');
      Write('Enter choice (1-2): ');
      Readln(regChoice);
    Until (regChoice = 1) Or (regChoice = 2);

    If regChoice = 1 Then
    Begin
      regType := 'TRACK';
      trackTotals[houseChoice] := trackTotals[houseChoice] + TrackFee;
    End
    Else
    Begin
      regType := 'FIELD';
      fieldTotals[houseChoice] := fieldTotals[houseChoice] + FieldFee;
    End;

    personCounts[houseChoice] := personCounts[houseChoice] + 1;

    Writeln;
    Writeln(' Registration Successful!');
    Writeln('  Name : ', name);
    Writeln('  House: ', HouseNames[houseChoice]);
    Writeln;
    ClrScr;
  End;

  // Calculate total fees per house
  For x := 1 To NumHouses Do
    totalFees[x] := trackTotals[x] + fieldTotals[x];

  // Display Summary
  Writeln;
  Writeln('-------------------------------------------------');
  Writeln('           FINAL REGISTRATION SUMMARY            ');
  Writeln('-------------------------------------------------');

  For x := 1 To NumHouses Do
  Begin
    Writeln;
    Writeln('  ', HouseNames[x], ' HOUSE');
    Writeln('  Number of Persons in House: ', Trunc(personCounts[x]));
    Writeln('  Total: $', totalFees[x]:0:2, ' USD');
    Writeln('-------------------------------------------------');
  End;

  Writeln('      Thank you for using the system. Goodbye!   ');
  Writeln('-------------------------------------------------');
  Readln;
End.
