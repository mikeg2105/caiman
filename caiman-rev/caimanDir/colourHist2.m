function [h_hue_sat,h_hue_val,dataHue2,dataSaturation2,dataValue2]=colourHist2(dataHSV,sizeHue,sizeSaturation,sizeValue)
%function [h_hue_sat,h_hue_val,h_hue_sat_val,profMaxSat]=colourHist2(dataHSV,sizeHue,sizeSaturation,sizeValue)
%function [h_hue_sat,h_hue_val,h_hue_sat_val]=colourHist(dataHSV,sizeHue,sizeSaturation);
%
%-------- this function obtains the joint Hue-Saturation and Hue-Value histograms together
%-------- with the Hue-Saturation-Value image to analyse the colour in images
%-------------------------------------------------------------------------------------
%------  Author :   Constantino Carlos Reyes-Aldasoro                       ----------
%------             Postdoc  Sheffield University                           ----------
%------             http://tumour-microcirculation.group.shef.ac.uk         ----------
%------  29 May 2008   ---------------------------
%----------------------------------------------------
% input data:       dataHSV: an image with cells stained by immunohistochemsitry or any other colour image
%                   [sizeHue, sizeSaturation] : sizes of the histogram
% output data:      Corresponding Joint Histograms


%------ no input data is received, error -------------------------
%------ at least 2 parameters are required
if nargin <1;     help colourHist; h_hue_sat=[]; return;  end;
if ~exist('sizeHue','var');
    sizeHue         = 32;
    sizeSaturation  = 32;
    sizeValue       = 32;
end
if ~exist('sizeSaturation','var'); sizeSaturation  = ceil(sizeHue/2);                          end
if ~exist('sizeValue','var');      sizeValue       = ceil(sizeHue/2);                          end

%----- set H,S,V in different matrices
%----- if data has been previously quantised, uncomment following lines
dataHue                                     = dataHSV(:,:,1);
dataSaturation                              = dataHSV(:,:,2);
dataValue                                   = dataHSV(:,:,3);


[y,x]=hist(dataHue(:),(0:255)/255);
%if (numel(find(y)))~=sizeHue

    %%----- If data is not quantised, uncomment following lines
    dataHue             = 1+(sizeHue-1)*        quanti_r(dataHSV(:,:,1),log2(sizeHue));
    dataSaturation      = 1+(sizeSaturation-1)* quanti_r(dataHSV(:,:,2),log2(sizeSaturation));
    if max(max(dataHSV(:,:,3)))>1
        dataHSV(:,:,3)   = dataHSV(:,:,3)/255;
    end
    dataValue           = 1+(sizeValue-1)*      quanti_r(dataHSV(:,:,3),log2(sizeValue));


%else
%    dataHue             =  dataHue(:);
%    dataSaturation      =  dataSaturation(:);
%    dataValue           =  dataValue(:);

%end
dataHue2                                    = dataHue;
dataSaturation2                             = dataSaturation;
dataValue2                                  = dataValue;

chromaticity3D(sizeSaturation,sizeHue,sizeValue)=0;
%----- loop over the levels determined by the linspace xx
kk3=(1:32) ;
for k=1:sizeHue
    tempHue=find(dataHue==k);
    if ~isempty(tempHue)
        for k2=1:sizeSaturation
            %            tempSat=find(dataSaturation(tempHue)==k2);
            tempVal=(dataValue(tempHue));
            tempSat=tempVal(dataSaturation(tempHue)==k2);
            if ~isempty(tempSat)
                chromaticity3D(k2,k,kk3)=histc(tempSat,kk3);
            end
        end
        dataHue(tempHue)=[];
        dataSaturation(tempHue)=[];
        dataValue(tempHue)=[];
    end

end

h_hue_sat=sum(chromaticity3D,3);
h_hue_val=chromaticity3D;
