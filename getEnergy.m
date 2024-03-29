%{ 
N = node count
s = source node
d = destination node
u = energy function terms
a = path inclusion matrix
B = connection matrix
t = delay matrix
t0 = maximum delay
c = cost matrix
%}
function E = getEnergy(N, s, d, u, a, B, t, t0, c)

b1 = 0;  
for i = 1:N
  for j = 1:N
    if (j != i)
      b1 = b1 + (c(i,j) * a(i,j));
    endif
  endfor
endfor
b1 = u(1)/2 * b1

b2 = 0;  
for i = 1:N
  for j = 1:N
    if (j != i)
      b2 = b2 + (B(i,j)*a(i,j));
    endif
  endfor
endfor
b2 = u(2)/2 * b2

b3 = 0;
for i = 1:N
  for j = 1:N
    if (j != i)
      b3 = b3 + a(i,j);
    endif
  endfor
  
  for j = 1:N
    if (j != i && i == s)
      b3 = b3 - (a(i,j) - 1);
    elseif (j != i && i == d)
      b3 = b3 - (a(i,j) + 1);
    elseif (j != i)
      b3 = b3 - a(i,j);
    endif
  endfor
endfor
b3 = u(3)/2 * b3

b4 = 0;
for i = 1:N
  for j = 1:N
    if (j != i)
      b4 = b4 + a(i,j) * (1 - a(i,j));
    endif
  endfor
endfor
b4 = u(4)/2 * b4

b5 = 0;
for i = 1:N
  for j = 1:N
    if (j != i)
      b5 = b5 + a(i,j) * a(j,i);
    end
  endfor
endfor
b5 = u(5)/2 * b5

b6 = 0;
for i = 1:N
  for j = 1:N
    if (j != i)
      sum = 0;
    
      for k = 1:N
        if (k != i && k != j)
          sum = sum + (a(i,k) - 1);
        endif
      endfor
    
      sum = sum * (a(i,j) * a(i,j));
      b6 = b6 + sum;
    endif
  endfor
endfor
b6 = u(6)/2 * b6

b7 = 0;
for i = 1:N
  for j = 1:N
    if (j != i)
      sum = 0;
    
      for k = 1:N
        if (k != i && k != j)
          sum = sum + (a(k,j) - 1);
        endif
      endfor
    
      sum = sum * (a(i,j) * a(i,j));
      b7 = b7 + sum;
    endif
  endfor
endfor
b7 = u(7)/2 * b7

b8 = 0;
b81 = 0;
b82 = 0;
b83 = 0;
for i = 1:N
  for j = 1:N
    if (j != i)
      b81 = b81 + (t(i,j) * a(i,j));
    endif    
  endfor
endfor
b81 = t0 - b81;

for i = 1:N
  for j = 1:N
    if (j != i)
      b82 = b82 + (t(i,j) * a(i,j));
    endif    
  endfor
endfor
b82 = t0 - b82;

for i = 1:N
  for j = 1:N
    if (j != i)
      b83 = b83 + (t(i,j) * a(i,j));
    endif    
  endfor
endfor
b83 = t0 - b83;

b8 = u(8)/2 * b81 * (b82 - abs(b83))

E = b1 + b2 + b3 + b4 + b5 + b6 + b7 + b8;