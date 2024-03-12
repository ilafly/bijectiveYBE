is_homomorphism := function(f, x, y)
  local i, j;
  for i in [1..Size(x[1])] do
    for j in [1..Size(x[1])] do
      if f[x[1][i][j]] <> y[1][f[i]][f[j]] then
        return false;
      fi;
       if f[x[2][i][j]] <> y[2][f[i]][f[j]] then
        return false;
      fi;
    od;
  od;
  return true;
end;

are_isomorphic := function(x, y)
  local n,p,f;
  if Size(x[1]) <> Size(y[1]) then
    return false;
  else
    n := Size(x[1]);
    for p in SymmetricGroup(n) do
      if p = [] then
        f := [1..n];
      else
        f := ListPerm(p,n);
      fi;
      if is_homomorphism(f, x, y) then
        return true;
      fi;
    od;
  fi;
  return false;
end;

s_xy := function(obj, x, y)
  return [obj[1][x][y], obj[2][y][x]];
end;

is_bijective := function(obj)
  local c, n, x, y;

  n := Size(obj[1]);
  c := Cartesian([1..n],[1..n]);

  for x in c do
    if not Number(c, z->x=s_xy(obj, z[1], z[2])) = 1 then
      return false;
    fi;
  od;
  return true;
end;

is_involutive := function(obj)
  local t, c, x, y, u, v, n;

  n := Size(obj[1]);

  for x in [1..n] do
    for y in [1..n] do
      t := s_xy(obj, x, y);
      u := t[1];
      v := t[2];
      if not s_xy(obj, u, v) = [x, y] then
        return false;
      fi;
    od;
  od;
  return true;
end;

is_left_nondegenerate := function(obj)
  return not fail in List(obj[1], PermList);
end;

is_right_nondegenerate := function(obj)
  return not fail in List(obj[2], PermList);
end;


is_new := function(list, x)
  local y;
  for y in list do
    if are_isomorphic(x, y) then
      return false;
    fi;
  od;
  return true;
end;

clean := function(list)
  local x, new;
  new := [];
  for x in list do
    if is_new(new, x) then
      Add(new, x);
    fi;
  od;
  return new;
end;

is_nondegenerate:=function(x)
return is_left_nondegenerate(x) and is_right_nondegenerate(x);
end;

filter_degenerate:=function(list)
local x, new;
  new := [];
  for x in list do
    if is_nondegenerate(x) = false then
      Add(new, x);
    fi;
  od;
  return new;
end;

uptoiso:=function(n)
    local sols,new,x,f;
    Read(Concatenation("solutions", String(n), ".g"));
    sols:=EvalString("sols");
    new:=clean(sols);
    f := IO_File(Concatenation("solutions_uptoiso", String(n), ".g"), "w");
    
    IO_WriteLine(f, Concatenation("sols", " := ["));
  for x in new do
    IO_WriteLine(f, Concatenation(String(x),",")); 
  od;
  IO_WriteLine(f, "];\n\n");
  IO_Flush(f);
  IO_Close(f);
    Print(Size(sols),"\n\n",Size(new));
    end;

degenerate_uptoiso:=function(n)    
    local sols,new,x,f;
    Read(Concatenation("solutions_uptoiso", String(n), ".g"));
    sols:=EvalString("sols");
    new:=filter_degenerate(sols);
    f := IO_File(Concatenation("solutions_degenerate_uptoiso", String(n), ".g"), "w");
    
    IO_WriteLine(f, Concatenation("sols", " := ["));
  for x in new do
    IO_WriteLine(f, Concatenation(String(x),",")); 
  od;
  IO_WriteLine(f, "];\n\n");
  IO_Flush(f);
  IO_Close(f);
    Print(Size(sols),"\n\n",Size(new));
    end;

  degenerate:=function(n)    
    local sols,new,x,f;
    Read(Concatenation("solutions", String(n), ".g"));
    sols:=EvalString("sols");
    new:=filter_degenerate(sols);
    f := IO_File(Concatenation("solutions_degenerate", String(n), ".g"), "w");
    
    IO_WriteLine(f, Concatenation("sols", " := ["));
  for x in new do
    IO_WriteLine(f, Concatenation(String(x),",")); 
  od;
  IO_WriteLine(f, "];\n\n");
  IO_Flush(f);
  IO_Close(f);
    Print(Size(sols),"\n\n",Size(new));
end;

same_rank:=function(sol)
    local a;
    return Number(List(sol[1], PermList), a->a=fail) = Number(List(sol[2], PermList), a->a=fail);
end;

filter_involutive:=function(list)
local x, new;
  new := [];
  for x in list do
    if is_involutive(x) then
      Add(new, x);
    fi;
  od;
  return new;
end;

how_many_involutive:=function(file)
  local sols,new,x,f; 
  Read(file);
  sols:=EvalString("sols");
  new:=filter_involutive(sols);
  Print(Size(sols),"\n\n",Size(new));
end;

filter_bijective:=function(list)
local x, new;
  new := [];
  for x in list do
    if is_bijective(x) then
      Add(new, x);
    fi;
  od;
  return new;
end;

how_many_bijective:=function(file)
  local sols,new,x,f; 
  Read(file);
  sols:=EvalString("sols");
  new:=filter_bijective(sols);
  Print(Size(sols),"\n\n",Size(new));
end;
