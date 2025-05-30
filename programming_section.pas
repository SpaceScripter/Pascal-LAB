Program Alligator;

Uses Crt;

Var
  x: Integer;
  id, name, house, regType: String;
  alphaTrack, alphaField, betaTrack, betaField, deltaTrack, deltaField, gammaTrack, gammaField: Real;

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

  Writeln('══════════════════════════════════════════════');
  Writeln('     Welcome to the Sports Registration       ');
  Writeln('══════════════════════════════════════════════');
  Writeln;

  For x := 1 To 12 Do
  Begin
    Writeln('─[ Registering Student ', x, ' of 12 ]─');

    Write('Enter Student ID: ');
    Readln(id);

    Write('Enter Full Name: ');
    Readln(name);

    Repeat
      Write('Enter House (Alpha, Beta, Delta, Gamma): ');
      Readln(house);
      house := Upcase(house);
    Until (house = 'ALPHA') Or (house = 'BETA') Or (house = 'DELTA') Or (house = 'GAMMA');

    Repeat
      Write('Enter Registration Type (Track or Field): ');
      Readln(regType);
      regType := Upcase(regType);
    Until (regType = 'TRACK') Or (regType = 'FIELD');

    if house = 'ALPHA' Then
    Begin
      if regType = 'TRACK' Then
        alphaTrack := alphaTrack + 50
      Else
        alphaField := alphaField + 40;
    End
    Else if house = 'BETA' Then
    Begin
      if regType = 'TRACK' Then
        betaTrack := betaTrack + 50
      Else
        betaField := betaField + 40;
    End
    Else if house = 'DELTA' Then
    Begin
      if regType = 'TRACK' Then
        deltaTrack := deltaTrack + 50
      Else
        deltaField := deltaField + 40;
    End
    Else if house = 'GAMMA' Then
    Begin
      if regType = 'TRACK' Then
        gammaTrack := gammaTrack + 50
      Else
        gammaField := gammaField + 40;
    End;

    Writeln;
    Writeln(' Registration Successful!');
    Writeln('  Name : ', name);
    Writeln('  House: ', house);
    Writeln('───────────────────────────────────────────────');
    Writeln;
  End;

  Writeln;
  Writeln('═════════════════════════════════════════════════');
  Writeln('           FINAL REGISTRATION SUMMARY            ');
  Writeln('═════════════════════════════════════════════════');

  Writeln;
  Writeln('  ALPHA HOUSE');
  Writeln('  Track Athletes: ', Trunc(alphaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(alphaField / 40));
  Writeln('  Total: $', alphaTrack + alphaField:0:2);

  Writeln;
  Writeln('  BETA HOUSE');
  Writeln('  Track Athletes: ', Trunc(betaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(betaField / 40));
  Writeln('  Total: $', betaTrack + betaField:0:2);

  Writeln;
  Writeln('  DELTA HOUSE');
  Writeln('  Track Athletes: ', Trunc(deltaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(deltaField / 40));
  Writeln('  Total: $', deltaTrack + deltaField:0:2);

  Writeln;
  Writeln('  GAMMA HOUSE');
  Writeln('  Track Athletes: ', Trunc(gammaTrack / 50));
  Writeln('  Field Athletes: ', Trunc(gammaField / 40));
  Writeln('  Total: $', gammaTrack + gammaField:0:2);

  Writeln('───────────────────────────────────────────────');
  Writeln('     Thank you for using the system. Goodbye!   ');
  Writeln('───────────────────────────────────────────────');
  Readln;
End.