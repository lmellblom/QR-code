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

% divide the message into 8bits strings
divided = reshape(str,8,[]).';  % just nu problem om ej jämnt delbart med 8

% convert the binary string to a number
numbers = bin2dec(divided); 

% convert the number to a char, the message is 
message = char(numbers).';      % transponat så meddalendet skrivs ut "rätt" 

end
