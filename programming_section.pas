{Authors: Joshua Samuel, Shiva Beharry, Aadi Boodoosingh, Gerrard Ramcharan, Kemarley Pierre, Jahmarley Ellis
  Date of completion: 30/05/2025
  Description: A simple sports registration system for a school.
  This program allows students to register for sports in different houses and types.}

Program SportsRegistrationSystem;


Uses Crt;

Var
  x, houseChoice, regChoice: Integer;
  id, name, house, regType: String;
  alphaTrack, alphaField, betaTrack, betaField: Real;
  deltaTrack, deltaField, gammaTrack, gammaField: Real;
  totalAlpha, totalBeta, totalDelta, totalGamma: Real;

Begin
  ClrScr;
  alphaTrack := 0; 
  alphaField := 0;
  betaTrack := 0; 
  betaField := 0;
  deltaTrack := 0; 
  deltaField := 0;
  gammaTrack := 0; 
  gammaField := 0;

  Writeln('-------------------------------------------------');
  Writeln('     Welcome to the Sports Registration       ');
  Writeln('-------------------------------------------------');
  Writeln;

  For x := 1 To 12 Do
  Begin
    Writeln('─[ Registering Student ', x, ' of 12 ]─');

    Write('Enter Student ID: ');
    Readln(id);

    Write('Enter Full Name: ');
    Readln(name);

    {House Selection}
    Repeat
      Writeln('Select House:');
      Writeln('  1. Alpha');
      Writeln('  2. Beta');
      Writeln('  3. Delta');
      Writeln('  4. Gamma');
      Write('Enter choice (1-4): ');
      Readln(houseChoice);
    Until ((houseChoice >= 1) And (houseChoice <= 4));

    Case houseChoice Of
      1: house := 'ALPHA';
      2: house := 'BETA';
      3: house := 'DELTA';
      4: house := 'GAMMA';
    End;

    {Registration Type}
    Repeat
      Writeln('Select Registration Type:');
      Writeln('  1. Track');
      Writeln('  2. Field');
      Write('Enter choice (1-2): ');
      Readln(regChoice);
    Until ((regChoice = 1) Or (regChoice = 2));

    Case regChoice Of
      1: regType := 'TRACK';
      2: regType := 'FIELD';
    End;

    {Update house totals}
    If (house = 'ALPHA') Then
    Begin
      If (regType = 'TRACK') Then
        alphaTrack := alphaTrack + 50
      Else
        alphaField := alphaField + 40;
    End
    Else If (house = 'BETA') Then
    Begin
      If (regType = 'TRACK') Then
        betaTrack := betaTrack + 50
      Else
        betaField := betaField + 40;
    End
    Else If (house = 'DELTA') Then
    Begin
      If (regType = 'TRACK') Then
        deltaTrack := deltaTrack + 50
      Else
        deltaField := deltaField + 40;
    End
    Else If (house = 'GAMMA') Then
    Begin
      If (regType = 'TRACK') Then
        gammaTrack := gammaTrack + 50
      Else
        gammaField := gammaField + 40;
    End;

    Writeln;
    Writeln(' Registration Successful!');
    Writeln('  Name : ', name);
    Writeln('  House: ', house);
    ClrScr;
    Writeln('-------------------------------------------------');
    Writeln;
  End;

  {Compute Totals}
  totalAlpha := alphaTrack + alphaField;
  totalBeta := betaTrack + betaField;
  totalDelta := deltaTrack + deltaField;
  totalGamma := gammaTrack + gammaField;

  {Summary}
  Writeln;
  Writeln('-------------------------------------------------');
  Writeln('           FINAL REGISTRATION SUMMARY            ');
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  ALPHA HOUSE');
  Writeln('  Track Athletes: ', Trunc(alphaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(alphaField / 40));
  Writeln('  Total: $', totalAlpha:0:2);
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  BETA HOUSE');
  Writeln('  Track Athletes: ', Trunc(betaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(betaField / 40));
  Writeln('  Total: $', totalBeta:0:2);
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  DELTA HOUSE');
  Writeln('  Track Athletes: ', Trunc(deltaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(deltaField / 40));
  Writeln('  Total: $', totalDelta:0:2);
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  GAMMA HOUSE');
  Writeln('  Track Athletes: ', Trunc(gammaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(gammaField / 40));
  Writeln('  Total: $', totalGamma:0:2);
  Writeln('-------------------------------------------------');

  Writeln('-------------------------------------------------');
  Writeln('      Thank you for using the system. Goodbye!   ');
  Writeln('-------------------------------------------------');
  Readln;
End.
