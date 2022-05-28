function my_comet(varargin)
%COMET  Comet-like trajectory.
%   COMET(Y) displays an animated comet plot of the vector Y.
%   COMET(X,Y) displays an animated comet plot of vector Y vs. X.
%   COMET(X,Y,p) uses a comet of length p*length(Y).  Default is p = 0.10.
%
%   COMET(AX,...) plots into AX instead of GCA.
%
%   Example:
%       t = -pi:pi/200:pi;
%       comet(t,tan(sin(t))-sin(tan(t)))
%
%   See also COMET3.

%   Charles R. Denham, MathWorks, 1989.
%   Copyright 1984-2021 The MathWorks, Inc.

% Parse possible Axes input
[ax,args,nargs] = axescheck(varargin{:});
if nargs < 1
    error(message('MATLAB:narginchk:notEnoughInputs'));
elseif nargs > 3
    error(message('MATLAB:narginchk:tooManyInputs'));
end

% Parse the rest of the inputs
bodyLengthProportion = 0.10;
if nargs < 2, x = args{1}; y = x; x = 1:length(y); end
if nargs == 2, [x,y] = deal(args{:}); end
if nargs == 3, [x,y,bodyLengthProportion] = deal(args{:}); end

if ~isscalar(bodyLengthProportion) || ~isreal(bodyLengthProportion) ||  bodyLengthProportion < 0 || bodyLengthProportion >= 1
    error(message('MATLAB:comet:InvalidP'));
end

x = matlab.graphics.chart.internal.datachk(x);
y = matlab.graphics.chart.internal.datachk(y);

if ~isvector(x) || ~isvector(y) || numel(x) ~= numel(y)
    error(message('MATLAB:comet:XYVectorsSameLength'));
end

ax = newplot(ax);

if ~strcmp(ax.NextPlot,'add')
    % If NextPlot is 'add', assume other objects are driving the limits.
    % Otherwise, set the limits so that the axes limits don't jump around
    % during animation.
    [minx,maxx] = minmax(x);
    [miny,maxy] = minmax(y);
    if ~isa(ax,'matlab.graphics.axis.GeographicAxes')
        axis(ax,[minx - 0.05, maxx + 0.05, miny - 0.05, maxy + 0.05])
    else
        % Latitudes are the first axis (x) and longitudes are the second
        % axis (y).
        latmin = minx;
        latmax = maxx;
        lonmin = miny;
        lonmax = maxy;
        
        % Buffer the limits for better display.
        bufferInPercent = 5;
        f = 1 + bufferInPercent / 100;
        half = f * (latmax - latmin)/2;
        latlim = [-half, half] + (latmin + latmax)/2;
        latlim(1) = max(latlim(1), -90);
        latlim(2) = min(latlim(2),  90);
        half = f * (lonmax - lonmin)/2;
        lonlim = [-half, half] + (lonmin + lonmax)/2;
        
        geolimits(ax,latlim,lonlim)
    end
end
co = get(ax,'colororder');

totalLength = length(x);
bodyLength = round(bodyLengthProportion*totalLength);

if size(co,1)>=3
    colors = [ 'b'; 'b'; 'b' ];
    lstyle = '-';
else
    colors = repmat(co(1,:),3,1);
    lstyle = '--';
end

head = line('parent',ax,'color',colors(1,:),'marker','o','linestyle','none', 'linewidth', 2,...
            'xdata',x(1),'ydata',y(1),'Tag','head');

body = matlab.graphics.animation.AnimatedLine('color',colors(2,:),...
    'linestyle',lstyle, 'linewidth', 2,...
    'Parent',ax,...
    'MaximumNumPoints',max(1,bodyLength),'tag','body');
tail = matlab.graphics.animation.AnimatedLine('color',colors(3,:),...
    'linestyle','-',...
    'linewidth', 2,...
    'Parent',ax,...
    'MaximumNumPoints',1+totalLength,'tag','tail'); %Add 1 for any extra points

if length(x) < 2000
    updateFcn = @()drawnow;
else
    updateFcn = @()drawnow('limitrate');
end

% Grow the body
for i = 1:bodyLength
    % Protect against deleted objects following the call to drawnow.
    if ~(isvalid(head) && isvalid(body))
        return
    end
    set(head,'xdata',x(i),'ydata',y(i));
    addpoints(body,x(i),y(i));
    updateFcn();
end

% Add a drawnow to capture any events / callbacks
drawnow

% Initialize tail with first point. The next point will be added in the
% first iteration of the primary loop below, creating the first line
% segment of the tail.
addpoints(tail,x(1),y(1));

% Primary loop
for i = bodyLength+1:totalLength
    % Protect against deleted objects following the call to drawnow.
    if ~(isvalid(head) && isvalid(body) && isvalid(tail))
        return
    end
    set(head,'xdata',x(i),'ydata',y(i));
    addpoints(body,x(i),y(i));
    
    nextTailIndex = i-bodyLength+1;
    if(nextTailIndex<=totalLength)
        addpoints(tail,x(nextTailIndex),y(nextTailIndex));
    end
    updateFcn();
end
drawnow

% Allow tail to continue on to the full length. The last point added to the 
% tail in the primary loop above was at index (totalLength-bodyLength+1), 
% so this loop starts at the following index. 
for i = totalLength-bodyLength+2:totalLength
    % Protect against deleted objects following the call to drawnow.
    if ~isvalid(tail)
        return
    end
    addpoints(tail,x(i),y(i));
    updateFcn();
end
drawnow

end

function [minx,maxx] = minmax(x)
minx = min(x(isfinite(x)));
maxx = max(x(isfinite(x)));
if minx == maxx
    minx = maxx-1;
    maxx = maxx+1;
end
end
