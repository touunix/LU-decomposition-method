%Mateusz Gabryel
%Metoda Dekompozycji LU - rozwi�zywanie uk�adu rowna� liniowych
clc
format short g;
%------------------------------------------------------------
disp('Szukamy wektora X z r�wnania A*X=B')
disp('----------------------------------------------------');
%Macierz wsp�czynnik�w A:
disp('Dana jest macierz wsp�czynnik�w A (4x4):');
A = [  4.510, -1.700,  2.250,  2.170;
      -3.970, -0.960, -8.440,  1.690;
       4.710, -8.340, -9.970, -3.050;
       6.650,  4.420,  3.100, -1.800;];
disp(A);
%------------------------------------------------------------
%Wektor wyraz�w wolnych B:
disp('oraz wektor wyraz�w wolnych B (1x4):');
B = [ -43.890, 83.000, -16.030, -40.260;];
disp(B);
%------------------------------------------------------------     
%Macierz pomocnicza Q(4x4):
Q = [1,1,1,1;
     1,1,1,1;
     1,1,1,1; 
     1,1,1,1;];
%Kolumna numer 1:
for x=1:4
    Q(x,1) = A(x,1);
end
%Kolumna numer 2:
Q(1,2) = A(1,2)/Q(1,1);
for x=2:4
    Q(x,2) = A(x,2)-Q(x,1)*Q(1,2);
end
%Kolumna numer 3:
Q(1,3) = A(1,3)/Q(1,1);
Q(2,3) =(A(2,3)-Q(2,1)*Q(1,3))/Q(2,2);
Q(3,3) = A(3,3)-Q(3,1)*Q(1,3)-Q(3,2)*Q(2,3);
Q(4,3) = A(4,3)-Q(4,1)*Q(1,3)-Q(4,2)*Q(2,3);
%Kolumna numer 4:
Q(1,4) = A(1,4)/Q(1,1);
Q(2,4) =(A(2,4)-Q(2,1)*Q(1,4))/Q(2,2);
Q(3,4) =(A(3,4)-Q(3,1)*Q(1,4)-Q(3,2)*Q(2,4))/Q(3,3);
Q(4,4) = A(4,4)-Q(4,1)*Q(1,4)-Q(4,2)*Q(2,4)-Q(4,3)*Q(3,4);
disp('Macierz operacyjna Q (4x4):');
disp(Q);
%------------------------------------------------------------
%Wektory do zapisywania wyznaczonych X i Y:      
X = [1,1,1,1;];       
Y = [1,1,1,1;];
%------------------------------------------------------------
%Dzia�ania dla wyznaczenia Y (Q*Y=B ==> Y=B/Q):                            
Y(1) =  B(1)/Q(1,1); 
Y(2) = (B(2)-Q(2,1)*Y(1))/Q(2,2);
Y(3) = (B(3)-Q(3,1)*Y(1)-Q(3,2)*Y(2))/Q(3,3);
Y(4) = (B(4)-Q(4,1)*Y(1)-Q(4,2)*Y(2)-Q(4,3)*Y(3))/Q(4,4);
%Dzia�ania dla wyznaczenia X (Q*X=Y ==> X=Y/Q):
X(4) = Y(4);                 
X(3) = Y(3)-(X(4)*Q(3,4));
X(2) = Y(2)-(Q(2,3)*X(3))-(Q(2,4)*X(4));
X(1) = Y(1)-(Q(1,2)*X(2))-(Q(1,3)*X(3))-(Q(1,4)*X(4));
%------------------------------------------------------------
%Wy�wietlenie wektora X:
disp('----------------------------------------------------');
disp('Rozwi�zanie zadania:');
disp('Wektor X z r�wnania A*X=B:');
disp(X);
disp('----------------------------------------------------');
%Wektor Z do zapisania wynik�w dzia�a�:
Z = [1,1,1,1;];
%Dzia�ania do wyznaczenia Z (A*X=Z):
for x=1:4
    Z(x) = A(x,1)*X(1) + A(x,2)*X(2) + A(x,3)*X(3) + A(x,4)*X(4);
end
%Wy�wietlenie wektor�w Z i B do por�wnania i sprawdzenia:
disp('Wektor Z po dzia�aniach A*X:')
disp(Z);
disp('Wy�wietlenie wektora B do por�wnania z wektorem Z:');
disp(B);
%------------------------------------------------------------
%Uci�cie precyzji w celu por�wnania i sprawdzenia poprawno�ci
a = fix(Z);
b = fix(B);

if(a == b)
    disp('Wektory Z oraz B s� identyczne. Rozwi�zanie poprawne.');
else
    disp('Wektory Z oraz B NIE s� identyczne. Rozwi�zanie niepoprawne.');
end
%------------------------------------------------------------
%Koniec
%------------------------------------------------------------