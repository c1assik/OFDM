clear all
close all
clc
load OFDM_FRAME.txt;

s=OFDM_FRAME(:,3);

j = 1;
for i=1:7000
    if (s(i) == 1) 
        INDEX(j) = i;
        j = j + 1;
    end
end

OFDM_I = OFDM_FRAME(INDEX(2)+1:INDEX(5),1);

j = 1;
for i = 1:3072
    if (OFDM_I(i) ~= 0 && abs(OFDM_I(i)) < 32000) 
        NEW_I(j) = OFDM_I(i);  
        j = j+1;
    end
end

OFDM_Q = OFDM_FRAME(INDEX(2)+1:INDEX(5),2);

j = 1;
for i = 1:3072
    if (OFDM_Q(i) ~= 0 && abs(OFDM_Q(i)) < 32000) 
        NEW_Q(j) = OFDM_Q(i);  
        j = j+1;
    end
end


for i = 1:2415
    if (NEW_I(i) == 24573 && NEW_Q(i) == 24573) DEMOD(i) = 0;
    else if (NEW_I(i) == 24573 && NEW_Q(i) == 8191) DEMOD(i) = 1;
        else if (NEW_I(i) == 8191 && NEW_Q(i) == 24573) DEMOD(i) = 2;
             else if (NEW_I(i) == 8191 && NEW_Q(i) == 8191) DEMOD(i) = 3;
                  else if (NEW_I(i) == 24573 && NEW_Q(i) == -24573) DEMOD(i) = 4;
                       else if (NEW_I(i) == 24573 && NEW_Q(i) == -8191) DEMOD(i) = 5;
                            else if (NEW_I(i) == 8191 && NEW_Q(i) == -24573) DEMOD(i) = 6;
                                 else if (NEW_I(i) == 8191 && NEW_Q(i) == -8191) DEMOD(i) = 7;
                                      else if (NEW_I(i) == -24573 && NEW_Q(i) == 24573) DEMOD(i) = 8;
                                           else if (NEW_I(i) == -24573 && NEW_Q(i) == 8191) DEMOD(i) = 9;
                                                else if (NEW_I(i) == -8191 && NEW_Q(i) == 24573) DEMOD(i) = 10;
                                                     else if (NEW_I(i) == -8191 && NEW_Q(i) == 8191) DEMOD(i) = 11;
                                                          else if (NEW_I(i) == -24573 && NEW_Q(i) == -24573) DEMOD(i) = 12;
                                                               else if (NEW_I(i) == -24573 && NEW_Q(i) == -8191) DEMOD(i) = 13;
                                                                    else if (NEW_I(i) == -8191 && NEW_Q(i) == -24573) DEMOD(i) = 14;
                                                                         else if (NEW_I(i) == -8191 && NEW_Q(i) == -8191) DEMOD(i) = 15;
                                                                             end
                                                                        end
                                                                   end
                                                              end
                                                         end
                                                    end
                                               end
                                          end
                                     end
                                end
                           end
                      end
                 end
            end
        end
    end
end



fff = OFDM_FRAME(INDEX(1):INDEX(2),1);
fff2 = OFDM_FRAME(INDEX(5):INDEX(6),1);

for i = 1:1024
       if (fff(i) == fff2(i)) ERROR(i) = 0;
       else ERROR(i) = 1;
       end
end

OFDM_I = OFDM_FRAME(INDEX(1)+1:INDEX(5),1);
OFDM_Q = OFDM_FRAME(INDEX(1)+1:INDEX(5),2);

FRAME = OFDM_I + OFDM_Q * sqrt(-1);

stem(abs(FRAME));

figure
scatterplot(FRAME);

figure
plot(abs(ifft(FRAME)));


figure
plot(abs(fft(ifft(FRAME))));

