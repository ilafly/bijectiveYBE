Read("lib.g");


# Here we create the file contaning the constrains using.

create_file := function(n)
  local f,k,lines;

  lines := [ 
  "language ESSENCE' 1.0\n",
  Concatenation("letting n be ", String(n), "\n"),
    "find S,T : matrix indexed by [int(1..n), int(1..n)] of int(1..n)\n",
     "such that\n",
    "forAll x,y,z : int(1..n) .", 
     "  S[x,S[y,z]]=S[S[x,y],S[T[y,x],z]],",
     "forAll x,y,z : int(1..n) .", 
    "  T[z,T[y,x]]=T[T[z,y],T[S[y,z],x]],",
    "forAll x,y,z : int(1..n) .", 
    "  S[T[S[y,z],x],T[z,y]]=T[S[T[y,x],z],S[x,y]],",
  "forAll x,y : int(1..n).  exists t,u : int(1..n) .",
  " S[t,u]=x /\\ T[u,t]=y,"
  ];
  Add(lines, "\ntrue\n");
  return lines;
end;




keep_solutions := function(n, filename)
  local s, t, l, k, x, y, z, tmp, f, done;
    
  l := [];
  k := 0;

  f := IO_File(filename, "r");
  done := false;

  while not done do
    x := IO_ReadLine(f);
    if StartsWith(x, "Created information file") then
      done := true;
    elif StartsWith(x, "Solution") then
      y := ReplacedString(x, "Solution: language ESSENCE' 1.0 letting S be","");
      z := ReplacedString(y, "letting T be", "&");
      tmp := SplitString(z, "&");
      s := EvalString(tmp[1]);
      t := EvalString(tmp[2]);
      k := k+1;
      Add(l, [s,t]);
    fi;
  od; 
  Print("I found ", k, " solutions\n");  
  IO_Close(f);
  return l; 
end;




construct := function(n)
  local y,m,l,T,k,s,f,x,t,output, t0, t1, mytime;

  t0 := NanosecondsSinceEpoch();

  k := 0;
  m := 0;
  s := "savilerow -run-solver -all-solutions -solutions-to-stdout-one-line ";
  LogTo();
  LogTo(Concatenation("log/solutions", String(n), ".log"));

  l := create_file(n);
  f := IO_File(Concatenation("eprime/solutions", String(n), ".eprime"), "w");
  k := k+1;
  for x in l do
    IO_WriteLine(f, x);
  od;
  IO_Flush(f);
  IO_Close(f);

  t := [];

  Print("Running savilerow. ");
  output := Concatenation("output/output", String(n));
  Exec(Concatenation(s, "eprime/solutions", String(n), ".eprime >", output));
  for x in keep_solutions(n, output) do 
    Add(t, x);
    m := m+1;
  od;

  t1 := NanosecondsSinceEpoch();
  mytime := Int(Float((t1-t0)/10^6));
  Print("I constructed ", m, " solutions in ", mytime, "ms (=", StringTime(mytime), ")\n");
  
  f := IO_File(Concatenation("solutions", String(n), ".g"), "w");
    
  IO_WriteLine(f, Concatenation("sols", " := ["));
  for x in t do
    IO_WriteLine(f, Concatenation(String(x),",")); 
  od;
  IO_WriteLine(f, "];\n\n");
  IO_Flush(f);
  IO_Close(f);
end;


