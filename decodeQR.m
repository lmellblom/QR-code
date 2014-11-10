function message = decodeQR(Image)
% right now the Image must be 41x41 pixels 

% creates the images that tell if the pixel is info or fiducal marks
referenceIm = false(41);
referenceIm(1:8,1:8) = 1;       % left-upper corner
referenceIm(34:41, 1:8) = 1;    % left-down corner
referenceIm(1:8, 34:41) = 1;    % right-upper corner
referenceIm(33:37,33:37) = 1;   % small FIP

% to read only the bits that stores information
Image(referenceIm) = NaN;       % makes the fiducal mark NaN in the image
imageVec = Image(:);            % make a row-vector instead
imageVec(isnan(imageVec)) = []; % removes all the NaN values so it is just
                                % to read 8 bits each.

% make a long string of the bits that stores information
str=num2str(imageVec)'; %string, transponat så sträng ex '010101110'
str = '01000001001000000111010001100101011100110111010000100000011011010110010101110011011100110110000101100111011001010010000001110100011011110010000001101010011101010111001101110100001000000111001101100101001000000110100101100110001000000111010001101000011001010010000001101100011000010111001101110100001000000111001101110100011001010111000001110011001000000111011101101111011100100110101101110011001011100010000001001000011000010111011001100101001000000110000100100000011011100110100101100011011001010010000001100100011000010111100100100001';
% above str is just a test string to se if the steps under works. 

% divide the message into 8bits strings
divided = reshape(str,8,[]).';  % just nu problem om ej jämnt delbart med 8

% convert the binary string to a number
numbers = bin2dec(divided); 

% convert the number to a char, the message is 
message = char(numbers).';      % transponat så meddalendet skrivs ut "rätt" 

end
