Program Sports_Day_Funds_Calculator;
Var
  alpha, beta, gamma, delta: real;
  stud_id, x : integer;
  stud_name, stud_house, stud_regi: string;

Begin
  for x := 1 to 12 do
  begin
    Writeln('Welcome to the Sports Day Funds Calculator');
    Write('Please enter the student ID: ');
    Readln(stud_id);
    Write('Please enter student full name: ');
    Readln(stud_name);
    Write('Please enter the student house name: ');
    Readln(stud_house);
    stud_house := UpCase(stud_house);
    Write('Please enter the resgistration type (Field/Track): ');
    Readln(stud_regi);
    stud_regi := UpCase(stud_regi);
    Writeln('----------------------------------------');
    Writeln(' Data Entered:');
    Writeln;
    Writeln('Student Name: ', stud_name);
    Writeln('Student House: ', stud_house);
    Writeln('----------------------------------------');
  end;
end.
