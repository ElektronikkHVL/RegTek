%sys        : input transfer function
%input_p    : desired phase margin
%p_lag      : phase lag (range 5 - 12)
%precision  : decimal precision when looking for correct phases and
%             magnitues, increase for higher precision
function [m, p, lag_c, wn, wp]= lag_comp(sys, input_p, p_lag, precision)
    if (p_lag < 5) || (p_lag > 12)
        disp("Error! Desired lag should be in range 5-12");
        return
    else
        if precision < 0
            precision = 0; %%can't have negative digits
        end
        num = cell2mat(sys.Numerator);
        den = cell2mat(sys.Denominator);
        
        phase = -180 + input_p + p_lag
        [m, p, w] = bode(sys, logspace(-2, 3, 10^6));
        p_index = phase_index_lookup(p, phase, precision)
        wc = w(p_index)
        amp_decrease_index = mag_index_lookup(w, wc, precision);
        amp_decrease_log = 20 * log10(m(amp_decrease_index));
        amp_decrease = m(amp_decrease_index);
        wn = wc/(tand(90 - p_lag))
        wp = wn/amp_decrease
        
        s = tf('s');
        lag_c = (1 + s/wn)/(1 + s/wp)
        zpk(-wn, -wp, 1/amp_decrease)
    end
end

%Find magnitude index of given a frequency
function mag_index = mag_index_lookup(freq_vector, w, precision)
    mag_index = - 1;
    for i=1:length(freq_vector)
        if (round(freq_vector(i), precision) == round(w, precision))
            mag_index = i;
            break;
        end
    end
    if mag_index < 0
        disp("ERROR! No magnitude index found, try reducing digit precision (2 or 3 is typically fine)");
        return
    end     
end

%Find index of given phase
function phase_index = phase_index_lookup(phase_vector, phase, precision)
    phase_index = -1;
    for i=1:length(phase_vector)
        if (round(phase_vector(i), precision) == phase) 
            phase_index = i;
            break;
        end
    end
    
    if phase_index < 1
        disp("ERROR! No phase index found, try reducing digit precision (2 or 3 is typically fine)");
        return
    end
end