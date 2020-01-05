%Numar de ordine: 5 Bricicaru Lucian Semnal Dreptunghiular
%conform SF, orice semnal poate fi scris ca o suma infinita de sinusuri si cosinusuri de diferite frecvente
%semnalul reconstruit are aproape aceeasi forma ca si semnalul original, avand cateva diferente
%aceasta diferenta poate fi diminuata prin cresterea numarului de coeficienti din SF
%spre final putem observa ca semnalul poate fi scris printr-o suma de SIN, deci semnalul va prezenta un caracter sinusoidal

%atribuim perioadei valoarea data
P = 40; %Perioada semnalului
f = 1/P;
%alegem rezolutia temporala adecvata si ulterior sa mai afisam o perioada la dreapta si alta la stanga
t = -1.5 * P:0.1:1.5 * P;
%atribuim pulsul semnalului in functie de ordine
D = 5;
%calculam factorul de umplere cu formula : duty = D / P * 100;
duty = 12.5;
%setam numarul de coeficienti
N = 50; 
omega = 2 * pi / P; 

%notam semnalul nostru dreptunghiular cu X si cream un semnal dreptunghiular
X = square(omega * t, duty);        
f = @(t)square(omega * t, duty);
%calculam coeficientii CC

CC = 1 / P * integral(f, 0, P);
Ck = zeros(1,N);
Ak = zeros(1,N);
x_modificat = 0;

	for (k = 1 : 1 : N)
   		f = @(t)square(omega * t, duty).*exp(-omega * t * 1j * (k - 25));
		%calculam coeficientii SFC
   		Ck(k) = 1/P * integral(f, 0, P);             
   		Ak(k+1) = 2 * abs(Ck(k));
		%cream un semnal din suma de sinusuri
  		x_modificat = x_modificat + Ck(k) * exp(omega * t *1j * (k - 25));
	end

figure(1);
%afisam semnalul creat din suma de sinusuri peste semnalul original
plot(t, x_modificat, t, X);
title('x(t) si reconstructia');
ylabel('Amplitudinea [V]');
xlabel('Timp [s]');
figure(2)
%facem simetria amplitudinilor Ak pentru spectru
Ak(26) = abs(CC);
Ak(1) = Ak(51);   
%afisam spectrul de valori                 
stem([0:N],Ak); 
title('Spectrul de amplitudini');
grid;
