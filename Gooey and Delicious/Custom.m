function varargout = Custom(varargin)
% CUSTOM MATLAB code for Custom.fig
%      CUSTOM, by itself, creates a new CUSTOM or raises the existing
%      singleton*.
%
%      H = CUSTOM returns the handle to a new CUSTOM or the handle to
%      the existing singleton*.
%
%      CUSTOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUSTOM.M with the given input arguments.
%
%      CUSTOM('Property','Value',...) creates a new CUSTOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Custom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Custom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Custom

% Last Modified by GUIDE v2.5 26-Jul-2016 14:36:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Custom_OpeningFcn, ...
                   'gui_OutputFcn',  @Custom_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Custom is made visible.
function Custom_OpeningFcn(hObject, eventdata, handles, varargin)
h= findobj('Tag','GUI1');
if ~isempty(h)
    g1data = guidata(h);
    h1 = g1data.handles;
    img = h1.img;
    imshow(img);
    CC = h1.CC;
    X=h1.X;
else
    img = imread('canada1.png');
    CC=imageSegmenter(img);
    n= CC.NumObjects;
    X = zeros(1,n);
end
handles.CC = CC;
handles.X = X;
handles.img = img;



% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Custom (see VARARGIN)

% Choose default command line output for Custom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Custom wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Custom_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LineMaker.
function LineMaker_Callback(hObject, eventdata, handles)
% hObject    handle to LineMaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lw= 10;
[x1,y1] = ginput(1);
[x2,y2] = ginput(1);
x=[x1,x2];
y=[y1,y2];
plot(x,y,'LineWidth',lw);
x1 = ceil(x1),x2 = ceil(x2),y1=ceil(y1),y2=ceil(y2);
if x1<x2
    if y1<y2
        for i = x1:x2
            for j=y1:y2
            end
        end
    end
end

                
                
            


% --- Executes on button press in ParabolaMaker.
function ParabolaMaker_Callback(hObject, eventdata, handles)
% hObject    handle to ParabolaMaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PolygonMaker.
function PolygonMaker_Callback(hObject, eventdata, handles)

grayy = rgb2gray(handles.img);
BW=roipoly(I);
% hObject    handle to PolygonMaker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
