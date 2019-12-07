%Harald Tr�et L�greid
%02/12-19
%Routh tabell utregner v2

function y = Routh(inputArray)
syms E
%Forkorter navnet til inputArray, og gj�r om til symbol.
A = sym(inputArray);

%Ordner med st�rrelsen p� arrayet, og i hvilken grad uttrykket er.
sz = size(A);
order = sz(2)*2;
if(A(2, sz(2)) == 0)
    order = order-1;
end
RHP = 0;
%Legger til en rad med nuller til h�yre for, og under arrayet for � ha noen
%verdier � jobbe med.
A = [[A;zeros(order-2,sz(2))],zeros(order,1)];

%Lagrer bredden p� arrayet.
slutt = sz(2);

%G�r gjennom h�yden p� arrayet fra toppen. begynner p� i = 3 for � hoppe
%over de ferdige verdiene.
for i = 3:1:order
    %G�r gjennom bredden p� arrayet, og bytter ut nullene med 
    %de reelle verdiene.
    for j = 1:1:slutt
        %Setter verdien lik determinant/(f�rste kolonne i raden over
        %det() funksjonen funket ikke p� grunn av avrundingsfeil i
        %Matlab.
        A(i,j) = simplify((A(i-2,j+1)*A(i-1,1)-A(i-2,1)*A(i-1,j+1))/A(i-1,1));
    end
    %Sjekker om f�rste kolonne er null.
    if A(i,1) == 0
        %Sjekker om noen andre verdier i raden er ulik 0.
       rad = 1;
       for j = 2:1:slutt
           if A(i,j) ~= 0
               rad = 0;
           end
       end
       switch rad
           %Hvis en annen verdi i raden er ulik 0 betyr det at bare f�rste
           %kolonne er 0.
           case 0
               %Sender melding om at programmet har gjort noe hokus pokus, og
               %hvilken orden hokus pokuset ble gjort.
               formatForste = 'F�rste i rad %d er null.';
               sprintf(formatForste,(order-i))
               %Bytter ut nullen med epsilon(E).
               A(i,1) = E;
           break;
           %Hvis ingen andre verdier er ulik 0 betyr det at hele raden er
           %null.
           case 1
               %Sender melding om at programmet har gjort noe hokus pokus, og
               %hvilken orden hokus pokuset ble gjort.
               formatRad = 'Rad %d er null.';
               sprintf(formatRad,(order-i))
               radNR = i+1;
               radVerdi = A(i-1:i-1,:);
               sz2 = size(radVerdi);
               for j = 1:1:sz2(2)
                  A(i,j) = radVerdi(1,j)*(radNR-2*(j-1));
               end
           break;
       end
    end
    % Teller opp hvor mange poler det er i RHP.
    if (A(i,1)/abs(A(i,1)) ~= A(i-1,1)/abs(A(i-1,1)))
        RHP = RHP + 1;
    end
end
%Legger en kolonne med ordensnavn p� starten av arrayet.
t = zeros(order-1,1);
for i = 1:order
    t(i,1) = order-i;
end

%Publiserer arrayet.

A1 = [str2sym('Orden'),sym(zeros(1,sz(2)+1))];
A2 = [t,A];

display([A1;A2])

formatOut = 'Det er %d poler i RHP.';
y = sprintf(formatOut,RHP);

end