%Note: Take a denominator of transfer function in vector form as input
function r_table = routh_table_builder(den)
    syms s
    
    r_table = sym(zeros(length(den), length(den) - 1));
    
    table_length = length(den);
    
    ri= 1; %current row index
    ci = 2; %current col index
    
    for m=1:table_length
        s_power = table_length - m;
        r_table(m, 1) = s^(s_power); %#ok<NODEF>
        r_table(ri, ci) = den(m);
        if ri < 2
            ri = 2;
        else
            ci = ci + 1;
            ri = 1;
        end
    end
    
    s = size(r_table);
    nr_cols = s(2);
    
    for m = 3:table_length
        zero_counter = 0;
        rows_above = [r_table(m-2,(2:nr_cols)); r_table(m-1,(2:nr_cols))];
        divider = r_table(m-1, 2);

        for n=2:nr_cols - 1
            matrix = [rows_above(1,1) rows_above(1, n); rows_above(2, 1) rows_above(2,n)];
            value = -det(matrix)/divider;
            
            if value == 0
                zero_counter = zero_counter + 1;
                if (zero_counter == nr_cols - 1)
                    r_table(m, 2:nr_cols) = diff_without_syms(r_table(m-1, 2:nr_cols));
                elseif ((r_table(m, 2) == 0) && (n == nr_cols - 1))
                    syms e
                    r_table(m,2) = e;
                end
            else
                r_table(m, n) = collect(value);
            end
        end
    end         
end

function d = diff_without_syms(f)
    l = length(f);
    d = zeros(1, l);
    for k=1:l
        index = (l - k);
        d(k) = index * f(k);
    end
end

function b = is_zero(n)
    b = 1;
    for k=1:length(n)
        if n(k) ~= 0
            b = 0;
        end
    end
end