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
  {1} ClrScr;
  {2} alphaTrack := 0; 
  {3} alphaField := 0;
  {4} betaTrack := 0; 
  {5} betaField := 0;
  {6} deltaTrack := 0; 
  {7} deltaField := 0;
  {8} gammaTrack := 0; 
  {9} gammaField := 0;

  {10} Writeln('-------------------------------------------------');
  {11} Writeln('     Welcome to the Sports Registration       ');
  {12} Writeln('-------------------------------------------------');
  {13} Writeln;

  {14} For x := 1 To 1 Do
  Begin
    {15} Writeln('─[ Registering Student ', x, ' of 12 ]─');

    {16} Write('Enter Student ID: ');
    {17} Readln(id);

    {18} Write('Enter Full Name: ');
    {19} Readln(name);

    {House Selection}
    Repeat
      {20} Writeln('Select House:');
      {21} Writeln('  1. Alpha');
      {22} Writeln('  2. Beta');
      {23} Writeln('  3. Delta');
      {24} Writeln('  4. Gamma');
      {25} Write('Enter choice (1-4): ');
      {26} Readln(houseChoice);
    {27} Until ((houseChoice >= 1) And (houseChoice <= 4));

    {28} Case houseChoice Of
      {29} 1: house := 'ALPHA';
      {30} 2: house := 'BETA';
      {31} 3: house := 'DELTA';
      {32} 4: house := 'GAMMA';
    End;

    {Registration Type}
    Repeat
      {33} Writeln('Select Registration Type:');
      {34} Writeln('  1. Track');
      {35} Writeln('  2. Field');
      {36} Write('Enter choice (1-2): ');
      {37} Readln(regChoice);
    {38} Until ((regChoice = 1) Or (regChoice = 2));

    {39} Case regChoice Of
      {40} 1: regType := 'TRACK';
      {41} 2: regType := 'FIELD';
    End;

    {Update house totals}
    {42} If (house = 'ALPHA') Then
    Begin
      {43} If (regType = 'TRACK') Then
        {44} alphaTrack := alphaTrack + 50
      Else
        {45} alphaField := alphaField + 40;
    End
    {46} Else If (house = 'BETA') Then
    Begin
      {47} If (regType = 'TRACK') Then
        {48} betaTrack := betaTrack + 50
      Else
        {49} betaField := betaField + 40;
    End
    {50} Else If (house = 'DELTA') Then
    Begin
      {51} If (regType = 'TRACK') Then
        {52} deltaTrack := deltaTrack + 50
      Else
        {53} deltaField := deltaField + 40;
    End
    {54} Else If (house = 'GAMMA') Then
    Begin
      {55} If (regType = 'TRACK') Then
        {56} gammaTrack := gammaTrack + 50
      Else
        {57} gammaField := gammaField + 40;
    End;

    {58} Writeln;
    {59} Writeln(' Registration Successful!');
    {60} Writeln('  Name : ', name);
    {61} Writeln('  House: ', house);
    {62} ClrScr;
    {63} Writeln('-------------------------------------------------');
    {64} Writeln;
  End;

  {Compute Totals}
  {65} totalAlpha := alphaTrack + alphaField;
  {66} totalBeta := betaTrack + betaField;
  {67} totalDelta := deltaTrack + deltaField;
  {68} totalGamma := gammaTrack + gammaField;

  {Summary}
  {69} Writeln;
  {70} Writeln('-------------------------------------------------');
  {71} Writeln('           FINAL REGISTRATION SUMMARY            ');
  {72} Writeln('-------------------------------------------------');

  {73} Writeln;
  {74} Writeln('  ALPHA HOUSE');
  {75} Writeln('  Track Athletes: ', Trunc(alphaTrack / 50));
  {76} Writeln('  Field Athletes: ', Trunc(alphaField / 40));
  {77} Writeln('  Total: $', totalAlpha:0:2, ' USD');
  {78} Writeln('-------------------------------------------------');

  {79} Writeln;
  {80} Writeln('  BETA HOUSE');
  {81} Writeln('  Track Athletes: ', Trunc(betaTrack / 50));
  {82} Writeln('  Field Athletes: ', Trunc(betaField / 40));
  {83} Writeln('  Total: $', totalBeta:0:2, ' USD');
  {84} Writeln('-------------------------------------------------');

  {85} Writeln;
  {86} Writeln('  DELTA HOUSE');
  {87} Writeln('  Track Athletes: ', Trunc(deltaTrack / 50));
  {88} Writeln('  Field Athletes: ', Trunc(deltaField / 40));
  {89} Writeln('  Total: $', totalDelta:0:2, ' USD');
  {90} Writeln('-------------------------------------------------');

  {91} Writeln;
  {92} Writeln('  GAMMA HOUSE');
  {93} Writeln('  Track Athletes: ', Trunc(gammaTrack / 50));
  {94} Writeln('  Field Athletes: ', Trunc(gammaField / 40));
  {95} Writeln('  Total: $', totalGamma:0:2, ' USD');
  {96} Writeln('-------------------------------------------------');

  {97} Writeln('-------------------------------------------------');
  {98} Writeln('      Thank you for using the system. Goodbye!   ');
  {99} Writeln('-------------------------------------------------');
  {100} Readln;
End.
