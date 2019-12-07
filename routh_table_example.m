%example usage of routh_table_builder

% Ex 1 : Setup transfer function directly
T_r = tf([0 0 0 0 10], [1 7 6 42 8 56]);
d = cell2mat(T_r.Denominator); %Need to convert cells to normal vector if using transfer function directly
r_table = routh_table_builder(d)


% Ex 2 : Setup using seperate vectors for num and den
num = [0 0 0 0 0 0 1];
den = [3 9 6 4 7 8 2 6];
T1 = tf(num, den);
r_table1 = routh_table_builder(den);

%Ex 3 : Setup using symbolic
s = tf('s');
T2 = 1000/(s^3 + 10 * s^2 + 31 * s + 1030)
r_table2 = routh_table_builder(cell2mat(T2.Denominator))


% Ex 4 : Here we get a zero substitued with e
T_r_3 = tf([0 0 0 0 1], [1 2 3 6 5 3]);
r_table_3 = routh_table_builder(cell2mat(T_r_3.Denominator))

