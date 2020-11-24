function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 24-Nov-2020 09:25:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
handles.radio_fitur = [handles.r_warna, handles.r_tekstur, handles.r_bentukukuran, handles.r_kombinasi];
handles.radio_kombinasi = [handles.r_warnatekstur, handles.r_tekstur_bentukukuran, handles.r_warna_bentukukuran, handles.r_gabungan];
set(handles.radio_kombinasi, 'Enable', 'off');
set(handles.r_warna, 'Value', 1);
set(handles.c_peringkatfitur, 'Enable', 'off');
handles.fiturpilihan = 1;
handles.fiturkombinasi = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in r_warnatekstur.
function r_warnatekstur_Callback(hObject, eventdata, handles)
% hObject    handle to r_warnatekstur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_warnatekstur
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.r_warnatekstur, 'Value', 1);
    handles.fiturkombinasi = 1;
    guidata(hObject, handles);


% --- Executes on button press in r_tekstur_bentukukuran.
function r_tekstur_bentukukuran_Callback(hObject, eventdata, handles)
% hObject    handle to r_tekstur_bentukukuran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_tekstur_bentukukuran
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.r_tekstur_bentukukuran, 'Value', 1);
    handles.fiturkombinasi = 2;
    guidata(hObject, handles);

% --- Executes on button press in r_warna_bentukukuran.
function r_warna_bentukukuran_Callback(hObject, eventdata, handles)
% hObject    handle to r_warna_bentukukuran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_warna_bentukukuran
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.r_warna_bentukukuran, 'Value', 1);
    handles.fiturkombinasi = 3;
    guidata(hObject, handles);

% --- Executes on button press in r_gabungan.
function r_gabungan_Callback(hObject, eventdata, handles)
% hObject    handle to r_gabungan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_gabungan
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.r_gabungan, 'Value', 1);
    handles.fiturkombinasi = 4;
    guidata(hObject, handles);

% --- Executes on button press in r_warna.
function r_warna_Callback(hObject, eventdata, handles)
% hObject    handle to r_warna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_warna
    set(handles.radio_fitur, 'Value', 0);
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.radio_kombinasi, 'Enable', 'off');
    set(handles.r_warna, 'Value', 1);
    set(handles.c_peringkatfitur, 'Enable', 'off');
    set(handles.c_peringkatfitur, 'Value', 0);
    handles.fiturpilihan = 1;
    guidata(hObject, handles);


% --- Executes on button press in r_tekstur.
function r_tekstur_Callback(hObject, eventdata, handles)
% hObject    handle to r_tekstur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_tekstur
    set(handles.radio_fitur, 'Value', 0);
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.radio_kombinasi, 'Enable', 'off');
    set(handles.r_tekstur, 'Value', 1);
    set(handles.c_peringkatfitur, 'Enable', 'off');
    set(handles.c_peringkatfitur, 'Value', 0);
    handles.fiturpilihan = 2;
    guidata(hObject, handles);

% --- Executes on button press in r_bentukukuran.
function r_bentukukuran_Callback(hObject, eventdata, handles)
% hObject    handle to r_bentukukuran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_bentukukuran
    set(handles.radio_fitur, 'Value', 0);
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.radio_kombinasi, 'Enable', 'off');
    set(handles.r_bentukukuran, 'Value', 1);
    set(handles.c_peringkatfitur, 'Enable', 'off');
    set(handles.c_peringkatfitur, 'Value', 0);
    handles.fiturpilihan = 3;
    guidata(hObject, handles);

% --- Executes on button press in r_kombinasi.
function r_kombinasi_Callback(hObject, eventdata, handles)
% hObject    handle to r_kombinasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of r_kombinasi
    set(handles.radio_fitur, 'Value', 0);
    set(handles.radio_kombinasi, 'Value', 0);
    set(handles.radio_kombinasi, 'Enable', 'on');
    set(handles.r_kombinasi, 'Value', 1);
    set(handles.r_warnatekstur, 'Value', 1);
    set(handles.c_peringkatfitur, 'Enable', 'on');
    handles.fiturpilihan = 4;
    handles.fiturkombinasi = 1;
    guidata(hObject, handles);


% --- Executes on button press in b_klasifikasisampel.
function b_klasifikasisampel_Callback(hObject, eventdata, handles)
% hObject    handle to b_klasifikasisampel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.b_klasifikasisampel, 'Enable', 'off');
    acaksampel = get(handles.c_sampelacak, 'Value');
    peringkatfitur = get(handles.c_peringkatfitur, 'Value');
    fig = uifigure;
    s = klasifikasi(handles.fiturpilihan, handles.fiturkombinasi, acaksampel, peringkatfitur, fig);
    set(handles.b_klasifikasisampel, 'Enable', 'on');

% --- Executes on button press in c_sampelacak.
function c_sampelacak_Callback(hObject, eventdata, handles)
% hObject    handle to c_sampelacak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_sampelacak


% --- Executes on button press in c_peringkatfitur.
function c_peringkatfitur_Callback(hObject, eventdata, handles)
% hObject    handle to c_peringkatfitur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_peringkatfitur
