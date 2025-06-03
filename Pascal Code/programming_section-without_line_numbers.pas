{Authors: Joshua Samuel, Shiva Beharry, Aadi Boodoosingh, Gerrard Ramcharan, Kemarley Pierre, Jahmarley Ellis
  Date of completion: 30/05/2025

  Description: A simple sports registration system for a school.
  This program allows students to register for sports in different houses and types.}

Program SportsRegistrationSystem;

Uses Crt;

Var
  x, houseChoice, regChoice, id: Integer;
  name: String;
  alphaTrack, alphaField, betaTrack, betaField: Real;
  deltaTrack, deltaField, gammaTrack, gammaField: Real;
  totalAlpha, totalBeta, totalDelta, totalGamma: Real;
  totalAlphaPersons, totalBetaPersons, totalDeltaPersons, totalGammaPersons: Integer;

Begin

  { Initialize all totals }
  alphaTrack := 0; 
  alphaField := 0;
  betaTrack := 0;  
  betaField := 0;
  deltaTrack := 0; 
  deltaField := 0;
  gammaTrack := 0; 
  gammaField := 0;

  Writeln('-------------------------------------------------');
  Writeln('     Welcome to the Sports Registration          ');
  Writeln('-------------------------------------------------');
  Writeln;

  For x := 1 To 12 Do
  Begin
    Writeln('─[ Registering Student ', x, ' of 12 ]─');
    Write('Enter Student ID: ');
    Readln(id);

    Write('Enter Full Name: ');
    Readln(name);

    { House Selection }
    Repeat
      Writeln('Select House:');
      Writeln('  1. Alpha');
      Writeln('  2. Beta');
      Writeln('  3. Delta');
      Writeln('  4. Gamma');
      Write('Enter choice (1-4): ');
      Readln(houseChoice);
    Until houseChoice in [1..4];

    { Registration Type Selection }
    Repeat
      Writeln('Select Registration Type:');
      Writeln('  1. Track');
      Writeln('  2. Field');
      Write('Enter choice (1-2): ');
      Readln(regChoice);
    Until regChoice in [1, 2];

    { Update totals based on house and registration type }
    Case houseChoice Of
      1: If regChoice = 1 Then
            alphaTrack := alphaTrack + 50
         Else
            alphaField := alphaField + 40;
      2: If regChoice = 1 Then
            betaTrack := betaTrack + 50
         Else
            betaField := betaField + 40;
      3: If regChoice = 1 Then
            deltaTrack := deltaTrack + 50
         Else
            deltaField := deltaField + 40;
      4: If regChoice = 1 Then
            gammaTrack := gammaTrack + 50
         Else
            gammaField := gammaField + 40;
    End;

    { Confirmation }
    Writeln;
    Writeln('Registration Successful!');
    Writeln('  Name : ', name);
    Writeln('  House: ', 
      Case houseChoice of
        1: 'ALPHA';
        2: 'BETA';
        3: 'DELTA';
        4: 'GAMMA';
      End
    );

    Writeln('-------------------------------------------------');
    Writeln;
  End;

  { Calculate totals }
  totalAlpha := alphaTrack + alphaField;
  totalBeta := betaTrack + betaField;
  totalDelta := deltaTrack + deltaField;
  totalGamma := gammaTrack + gammaField;

  totalAlphaPersons := Trunc(alphaTrack / 50) + Trunc(alphaField / 40);
  totalBetaPersons := Trunc(betaTrack / 50) + Trunc(betaField / 40);
  totalDeltaPersons := Trunc(deltaTrack / 50) + Trunc(deltaField / 40);
  totalGammaPersons := Trunc(gammaTrack / 50) + Trunc(gammaField / 40);

  { Summary Output }
  Writeln;
  Writeln('-------------------------------------------------');
  Writeln('           FINAL REGISTRATION SUMMARY            ');
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  ALPHA HOUSE');
  Writeln('  Number of Persons in House: ', totalAlphaPersons);
  Writeln('  Total: $', totalAlpha:0:2, ' USD');
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  BETA HOUSE');
  Writeln('  Number of Persons in House: ', totalBetaPersons);
  Writeln('  Total: $', totalBeta:0:2, ' USD');
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  DELTA HOUSE');
  Writeln('  Number of Persons in House: ', totalDeltaPersons);
  Writeln('  Total: $', totalDelta:0:2, ' USD');
  Writeln('-------------------------------------------------');

  Writeln;
  Writeln('  GAMMA HOUSE');
  Writeln('  Number of Persons in House: ', totalGammaPersons);
  Writeln('  Total: $', totalGamma:0:2, ' USD');
  Writeln('-------------------------------------------------');

  Writeln('-------------------------------------------------');
  Writeln('      Thank you for using the system. Goodbye!   ');
  Writeln('-------------------------------------------------');
  Readln;
End.
