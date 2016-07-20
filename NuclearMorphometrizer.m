function varargout = NuclearMorphometrizer(varargin)
% NuclearMORPHOMETRIZER MATLAB code for NuclearMorphometrizer.fig
%      NuclearMORPHOMETRIZER, by itself, creates a new NuclearMORPHOMETRIZER or raises the existing
%      singleton*.
%
%      H = NuclearMORPHOMETRIZER returns the handle to a new NuclearMORPHOMETRIZER or the handle to
%      the existing singleton*.
%
%      NuclearMORPHOMETRIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NuclearMORPHOMETRIZER.M with the given input arguments.
%
%      NuclearMORPHOMETRIZER('Property','Value',...) creates a new NuclearMORPHOMETRIZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NuclearMorphometrizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NuclearMorphometrizer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NuclearMorphometrizer

% Last Modified by GUIDE v2.5 14-Jul-2016 13:55:54
% Updated by James Verdone, Johns Hopkins School of Medicine, 7/14/16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NuclearMorphometrizer_OpeningFcn, ...
                   'gui_OutputFcn',  @NuclearMorphometrizer_OutputFcn, ...
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


% --- Executes just before NuclearMorphometrizer is made visible.
function NuclearMorphometrizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NuclearMorphometrizer (see VARARGIN)

% Choose default command line output for NuclearMorphometrizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NuclearMorphometrizer wait for user response (see UIRESUME)


% --- Outputs from this function are returned to the command line.
function varargout = NuclearMorphometrizer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_load_dir.
function pushbutton_load_dir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
loadDir = uigetdir('C:\'); addpath(loadDir); %get and add load directory to path
set(handles.text_load_dir,'String',loadDir); %Output Textbox as load directory
Files = dir(loadDir); %dir(strcat(loadDir,'\*.jpg')); %pull .jpg files from load directory
Files = Files(find([Files.bytes].'));

%set(handles.response_text,'String',Files(1).name);
ColorFiles = cell(length(Files),1);
C1Files = cell(length(Files),1);
C2Files = cell(length(Files),1);
C3Files = cell(length(Files),1); %Uncomment for loading C3 images
C4Files = cell(length(Files),1);
C5Files = cell(length(Files),1);
C6Files = cell(length(Files),1);

handles.imgCount = 0;
handles.filesLoaded = 1;
guidata(hObject,handles);
set(handles.pushbutton_begin,'Enable','on');


for i = 1:length(Files);
    
    j = strfind(Files(i).name,'C1-');
    k = strfind(Files(i).name,'C2-');
    l = strfind(Files(i).name,'C3-'); %Uncomment for loading C3 images
    m = strfind(Files(i).name,'C4-');
    n = strfind(Files(i).name,'C5-');
    o = strfind(Files(i).name,'C6-');
    
    if isempty(j) == 0
        C1Files{i} = Files(i).name;
    elseif isempty(k) == 0
        C2Files{i} = Files(i).name;
    elseif isempty(l) == 0
        C3Files{i} = Files(i).name; %Uncomment for loading C3 images
    elseif isempty(m) == 0
        C4Files{i} = Files(i).name;
    elseif isempty(n) == 0
        C5Files{i} = Files(i).name;
    elseif isempty(o) == 0
        C6Files{i} = Files(i).name;
    else
        ColorFiles{i} = Files(i).name;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This elminates empty entries from the list of image names
ColorFiles(all(cellfun('isempty',ColorFiles),2),:) = [];
C1Files(all(cellfun('isempty',C1Files),2),:) = [];
C2Files(all(cellfun('isempty',C2Files),2),:) = [];
C3Files(all(cellfun('isempty',C3Files),2),:) = [];
C4Files(all(cellfun('isempty',C4Files),2),:) = [];
C5Files(all(cellfun('isempty',C5Files),2),:) = [];
C6Files(all(cellfun('isempty',C6Files),2),:) = [];

handles.C1Files = C1Files;
handles.C2Files = C2Files;
handles.C3Files = C3Files;
handles.C4Files = C4Files;
handles.C5Files = C5Files;
handles.C6Files = C6Files;
handles.ColorFiles = ColorFiles;
guidata(hObject,handles);

set(handles.response_text,'String','Now Choose a Save Directory!');
return;


% --- Executes on button press in pushbutton_save_dir.
function pushbutton_save_dir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveDir = uigetdir('C:\');
set(handles.text_save_dir,'String',saveDir);
set(handles.response_text,'String','If you are ready, press START');


% --- Executes during object creation, after setting all properties.
function text_load_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_load_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text_save_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_save_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function image_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate image_frame


% --- Executes on button press in pushbutton_begin.
function pushbutton_begin_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton_begin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Port File info into function!
set(handles.response_text,'String','Please be patient, the computer is running!');
set(handles.pushbutton_begin,'Enable','off');
set(handles.pushbutton_load_dir,'Enable','off');
set(handles.pushbutton_save_dir,'Enable','off');
pause(.25);

    if handles.imgCount == 0
        handles.bwl = struct; handles.stats = struct;
        handles.group = struct; handles.Ic1 = struct;
        handles.Ic2 = struct; 
        handles.Ic3 = struct;
        handles.Ic4 = struct; 
        handles.Ic5 = struct;
        handles.Ic6 = struct; handles.Ifull = struct;
        [handles.bwl(1:length(handles.ColorFiles)).bw] = deal([]);
        [handles.bwl(1:length(handles.ColorFiles)).Icut] = deal([]);
        [handles.Ic1(1:length(handles.ColorFiles)).Image] = deal([]);
      [handles.Ic2(1:length(handles.ColorFiles)).Image] = deal([]);
        [handles.Ic3(1:length(handles.ColorFiles)).Image] = deal([]);
        [handles.Ic4(1:length(handles.ColorFiles)).Image] = deal([]);
         [handles.Ic5(1:length(handles.ColorFiles)).Image] = deal([]);
          [handles.Ic6(1:length(handles.ColorFiles)).Image] = deal([]);
        [handles.Ifull(1:length(handles.ColorFiles)).Image] = deal([]);
        [handles.group(1:length(handles.ColorFiles)).class] = deal([]);
        guidata(hObject,handles);
    end

    if handles.imgCount == length(handles.ColorFiles)
        return
    else
    set(handles.current_image_text,'String',handles.ColorFiles{handles.imgCount+1});
    end   
   
    handles.Ic1(handles.imgCount+1).Image = ...
        imread(handles.C1Files{handles.imgCount+1});
    
     handles.Ic2(handles.imgCount+1).Image = ...
         imread(handles.C2Files{handles.imgCount+1});
    
    handles.Ic3(handles.imgCount+1).Image = ...
        imread(handles.C3Files{handles.imgCount+1});
        
    handles.Ic4(handles.imgCount+1).Image = ...
        imread(handles.C4Files{handles.imgCount+1});
    
     handles.Ic5(handles.imgCount+1).Image = ...
        imread(handles.C5Files{handles.imgCount+1});
    
     handles.Ic6(handles.imgCount+1).Image = ...
        imread(handles.C6Files{handles.imgCount+1});
    
    handles.Ifull(handles.imgCount+1).Image = ...
        imread(handles.ColorFiles{handles.imgCount+1});
    
    guidata(hObject,handles);
    %image(Ifull);
    
    
    
    
    %up to this point C6 is encoded
    
    
    %Edit watershed segmentation variables here as necessary%
    Blur = 2;
    ThresholdC1 = 0.3;
    ThresholdC2 = 0.3;
    ThresholdC4 = 0.15;
    minArea = 200; maxArea = 1*10^10;
    WaterShedRegressConst = 2;
    
    %%%%%%%%%%%%%%%%%%%%%%
    %Process Images Below%
    %%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    
    
    
    
    
    %Perform watershed algorithm on greyscale DAPI Image
    % Define perimeter of nucleus using C1 which should have DAPI nuclear
    % marker
%     
    IeqC1 = adapthisteq(handles.Ic1(handles.imgCount+1).Image);
    IFiltC1 = imgaussfilt(IeqC1,Blur);
    IThresC1 = im2bw(IFiltC1, ThresholdC1);
    ICleanC1 = bwareafilt(IThresC1,[minArea maxArea]);
    DC1 = bwdist(~ICleanC1);
    DC1 = -DC1;
    maskC1 = imextendedmin(DC1,WaterShedRegressConst);
    D2C1 = imimposemin(DC1,maskC1);
    D2C1(~ICleanC1) = -Inf;
    Ld2C1 = watershed(D2C1);
    IcutC1 = ICleanC1;
    IcutC1(Ld2C1 ==0)=0;
%     handles.bwl(handles.imgCount+1).bw = bwlabel(IcutC1,8);
%     handles.bwl(handles.imgCount+1).Icut = IcutC1;
    perimC1 = bwperim(IcutC1);
    
   
    handles.statsC1 =  regionprops(IcutC1,handles.Ic1(handles.imgCount+1).Image,'all');
    AreaC1 = [handles.statsC1.Area].';
    delIndC1 = zeros(1,length(AreaC1));
    
   
    % Define perimeter of cytoplasm using C2
%     
    IeqC2 = adapthisteq(handles.Ic2(handles.imgCount+1).Image);
    IFiltC2 = imgaussfilt(IeqC2,Blur);
    IThresC2 = im2bw(IFiltC2, ThresholdC2);
    ICleanC2 = bwareafilt(IThresC2,[minArea maxArea]);
    DC2 = bwdist(~ICleanC2);
    DC2 = -DC2;
    maskC2 = imextendedmin(DC2,WaterShedRegressConst);
    D2C2 = imimposemin(DC2,maskC2);
    D2C2(~ICleanC2) = -Inf;
    Ld2C2 = watershed(D2C2);
    IcutC2 = ICleanC2;
    IcutC2(Ld2C2 ==0)=0;
    perimC2 = bwperim(IcutC2);
    handles.statsC2 =  regionprops(IcutC2,handles.Ic2(handles.imgCount+1).Image,'all');
    AreaC2 = [handles.statsC2.Area].';
    delIndC2 = zeros(1,length(AreaC2));
    
 % Code to create perimeter for C4 (prostate specific marker) is below:  
    
    IeqC4 = adapthisteq(handles.Ic4(handles.imgCount+1).Image);
    IFiltC4 = imgaussfilt(IeqC4,Blur);
    IThresC4 = im2bw(IFiltC4, ThresholdC4);
    ICleanC4 = bwareafilt(IThresC4,[minArea maxArea]);
    DC4 = bwdist(~ICleanC4);
    DC4 = -DC4;
    maskC4 = imextendedmin(DC4,WaterShedRegressConst);
    D2C4 = imimposemin(DC4,maskC4);
    D2C4(~ICleanC4) = -Inf;
    Ld2C4 = watershed(D2C4);
    IcutC4 = ICleanC4;
    IcutC4(Ld2C4 ==0)=0;
    perimC4 = bwperim(IcutC4);

    handles.statsC4 =  regionprops(IcutC4,handles.Ic4(handles.imgCount+1).Image,'all');
    AreaC4 = [handles.statsC4.Area].';
    delIndC4 = zeros(1,length(AreaC4));
    
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %Filter out objects with small area for C1
%    
%     for j = 1:numel(statsC1)
%         if AreaC1(j) < 250
%             delIndC1(j) = 1;
%         end
%     end
%     
%     delIndShort = find(delIndC1);
%     delIndShortSort = sort(delIndShort,'descend');
%     
%     for m = 1:length(delIndShort)
%         stats(delIndShortSort(m)) = [];
%     end
%     [stats(:).C3] = deal([]);
%     [stats(:).C4] = deal([]);
%     for j = 1:length(stats)
%         stats(j).C3 = handles.Ic3(handles.imgCount+1).Image(stats(j).PixelIdxList);
%         stats(j).C4 = handles.Ic4(handles.imgCount+1).Image(stats(j).PixelIdxList);
%     end


%Begin drawing C4 perimeter

   
    handles.group = zeros(length(handles.statsC4),1);
    guidata(hObject,handles);
     
    Segout = handles.Ifull(handles.imgCount+1).Image;
%     if numel(stats) ~= 0
        for i = 1:size(Segout,1)
            for j = 1:size(Segout,2)
                
                if perimC1(i,j) ==1
                   Segout(i,j,:) = 255;
                end
                
                if perimC4(i,j) ==1
                    Segout(i,j,1) = 255;
                    Segout(i,j,2) = 0;
                    Segout(i,j,3) = 0;
                end
            end
        end
        
%         for k = 1 : numel(stats)
%             %
%             handles.dna(k) = sum(handles.stats(k).PixelValues);
%             handles.stats(k).Nucleoli = handles.Ired(stats(k).PixelIdxList);
%             
%         end
        guidata(hObject,handles);
        set(handles.progress_text,'String',['Image ' num2str(handles.imgCount+1) ...
            ' of ' num2str(length(handles.C1Files))]);
        set(handles.progress_text,'Visible','On');
        imshow(Segout, [], 'InitialMagnification', 'fit');
%         image(Segout);
        set(handles.image_frame,'XTick',[]);
        set(handles.image_frame,'YTick',[]);
         zoom(4);
%     end
    hold on;
    set(handles.popupmenu1,'Visible','on');
    set(handles.response_text,'String','Choose the # of Good Nuclear Nuclei from Dropdown');

    

return;



% --- Executes during object creation, after setting all properties.
function response_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to response_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numberPicked = get(hObject,'Value');
set(handles.response_text,'String',strcat(num2str(numberPicked),' Nuclear(s) properly segmented!'));
pause(1);
set(handles.response_text,'String','Click the "Choose Nuclei" button, then click any Nuclear nuclei');
handles.Nuclearnum = numberPicked;
set(handles.pushbutton_nuc_crossing,'Enable','on');
guidata(hObject,handles);
set(handles.popupmenu1,'Visible','off');
return

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(hObject,'Visible','off');
set(hObject,'Value',1);
set(hObject,'String',1:15);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function current_image_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_image_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_nuc_crossing.
function pushbutton_nuc_crossing_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nuc_crossing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_nuc_crossing,'Enable','off');
guidata(hObject,handles);
[x,y] = ginput(handles.Nuclearnum);
Nuclearids = zeros(handles.Nuclearnum,1);
axes(handles.image_frame);

image(handles.Ifull(handles.imgCount+1).Image); 
set(handles.image_frame,'XTick',[]);
set(handles.image_frame,'YTick',[]);
set(handles.response_text,'String','Please wait while computer processes your cells!');

guidata(hObject,handles);
pause(.2);

if handles.Nuclearnum~=0
    for i = 1:handles.Nuclearnum;
        for j = 1:length(handles.statsC1)
            
            temp = find(ismember(handles.statsC1(j).PixelList,floor([x(i) y(i)]),'rows'));
            if ~isempty(temp)
                Nuclearids(i) = j;
            end
        end
    end
end



% handles.group(handles.imgCount+1).class = zeros(length(handles.stats(handles.imgCount+1)),1);
% handles.group(handles.imgCount+1).class(Nuclearids) = 1;
handles.group(Nuclearids) = 1;
% Nuclearids
% for k = 1 : numel(handles.stats)
%     
%         handles.NucRatio(k) = [handles.stats(k).MajorAxisLength].'/...
%             mean([handles.stats(handles.group~=1).MajorAxisLength].');
%     
% end

guidata(hObject,handles);



axes(handles.image_frame);

image(handles.Ifull(handles.imgCount+1).Image); 
set(handles.image_frame,'XTick',[]);
set(handles.image_frame,'YTick',[]);

hold on;    
%define centroids of perimeters C1, C2, C4

centroidC1 = zeros(length(handles.statsC1),2);
centroidC2 = zeros(length(handles.statsC2),2);
centroidC4 = zeros(length(handles.statsC4),2);

for i = 1:length(handles.statsC1)
    centroidC1(i,:) = handles.statsC1(i).Centroid(:);
end
for i = 1:length(handles.statsC2)
    centroidC2(i,:) = handles.statsC2(i).Centroid(:);
end
for i = 1:length(handles.statsC4)
    centroidC4(i,:) = handles.statsC4(i).Centroid(:);
end

% Find closest C2 and C4 blob to the C1 blob
Dist4 = zeros(size(centroidC1,1),size(centroidC4,1));
Dist2 = zeros(size(centroidC1,1),size(centroidC2,1));
for i = 1:size(centroidC1,1)
    for j = 1:size(centroidC4,1)
        Dist4(i,j) = sqrt((centroidC1(i,1)-centroidC4(j,1))^2+(centroidC1(i,2)-centroidC4(j,2))^2 );
    end
    for k = 1:size(centroidC2,1)
        Dist2(i,k) = sqrt((centroidC1(i,1)-centroidC2(k,1))^2+(centroidC1(i,2)-centroidC2(k,2))^2 );
    end
end


    
minDistIdx4 = zeros(length(handles.statsC1),1);
minDist4 = zeros(length(handles.statsC1),1);
for i = 1:length(minDistIdx4)
   [minDist4(i), minDistIdx4(i)] = min(Dist4(i,:));
end


minDistIdx2 = zeros(length(handles.statsC1),1);
minDist2 = zeros(length(handles.statsC1),1);
for i = 1:length(minDistIdx2)
   [minDist2(i), minDistIdx2(i)] = min(Dist2(i,:));
end

%define Areas of C1, C2, C4

AreaC1 = [handles.statsC1(:).Area].';
AreaC2 = [handles.statsC2(minDistIdx2).Area].';
AreaC4 = [handles.statsC4(minDistIdx4).Area].';




% MASTER EQUATION
% C1 dapi
% c2 ck
% c3 cs
% c4 nucleolin
% 

% !!!!!!exclude things too far away instead of matching!!!!!!!






% 
% 
% master equation
% 
% c1 area
AreaC1;

% c1 amount

C1sum = zeros(length(handles.statsC1),1);
for i = 1:length(handles.statsC1)
    C1sum(i) = sum(handles.statsC1(i).PixelValues);
end

% c2 area
AreaC2;

% c2 amount
C2sum = zeros(length(handles.statsC1),1);
for i = 1:length(handles.statsC1)
    C2sum(i) = sum(handles.statsC2(minDistIdx2(i)).PixelValues);
end


% amount of c4 in c1 nucleolin in nucleus

C4img = handles(handles.imgCount+1).Ic4;

C4overC1 = struct;
[C4overC1(1:length(handles.statsC1)).Ic4] = deal([]);
C4overC1sum = zeros(length(handles.statsC1),1);
[C4overC1(1:length(handles.statsC1)).pixels] = deal([]);

for i = 1:length(handles.statsC1)
  
    C4overC1(i).Ic4 = im2double(handles.statsC1(i).Image);
    C4overC1(i).pixels = C4img.Image(handles.statsC1(i).PixelIdxList);
    temp= find(C4overC1(i).Ic4); C4overC1(i).Ic4(temp) = C4overC1(i).pixels;
    C4overC1sum(i) = sum(C4overC1(i).pixels);


end


% c4 in c1 entropy nucleolin staining pattern
[C4overC1(1:length(handles.statsC1)).wentropy] = deal([]);
for i = 1:length(handles.statsC1)
   C4overC1(i).wentropyC4 = wentropy(C4overC1(i).Ic4,'shannon'); 
end
wentropyC4 = [C4overC1(:).wentropyC4].';

% amount of c4 in c2 nucleolin in the "cell" 



C4overC2 = struct;
[C4overC2(1:length(minDistIdx2)).Ic4] = deal([]);
C4overC2sum = zeros(length(minDistIdx2),1);
[C4overC2(1:length(minDistIdx2)).pixels] = deal([]);
for i = 1:length(minDistIdx2)
  
    C4overC2(i).Ic4 = im2double(handles.statsC2(minDistIdx2(i)).Image);
    C4overC2(i).pixels = C4img.Image(handles.statsC2(minDistIdx2(i)).PixelIdxList);
    temp= find(C4overC2(i).Ic4); C4overC2(i).Ic4(temp) = C4overC2(i).pixels;
    C4overC2sum(i) = sum(C4overC2(i).pixels);


end


% counts against your score
% amount of c3 in c1 counterstain in "cell" 


C3img = handles(handles.imgCount+1).Ic3;

C3overC1 = struct;
[C3overC1(1:length(handles.statsC1)).Ic3] = deal([]);
C3overC1sum = zeros(length(handles.statsC1),1);
[C3overC1(1:length(handles.statsC1)).pixels] = deal([]);
for i = 1:length(handles.statsC1)
  
    C3overC1(i).Ic3 = im2double(handles.statsC1(i).Image);
    C3overC1(i).pixels = C3img.Image(handles.statsC1(i).PixelIdxList);
    temp= find(C3overC1(i).Ic3); C3overC1(i).Ic3(temp) = C3overC1(i).pixels;
    C3overC1sum(i) = sum(C3overC1(i).pixels);


end

handles.statsC1(Nuclearids(1)).Image

%EQUATION COMPONENTS:
% AreaC1 % c1 area 2 size 20
% C1sum % c1 amount 3  10
% AreaC2 % c2 area 2 size 20
% C2sum % c2 amount 1 presence of keratin 100
% C4overC1sum % amount of c4 in c1 nucleolin in nucleus 2 20
% wentropyC4 % c4 in c1 entropy nucleolin staining pattern 2 20
% C4overC2sum % amount of c4 in c2 nucleolin in the "cell" 3 10
% 
% C3overC1sum  % amount of c3 in c1 counterstain in "cell" % counts against
% your score 2 20 
% if minDist2 is too large then equation is assigned really
% score 50 *****
% dividing by minDist2****
eqData = [AreaC1,C1sum,AreaC2,C2sum,C4overC1sum,wentropyC4,C4overC2sum,C3overC1sum,minDist2];
% median(AreaC1)/210
% median(C1sum)/210
% median(AreaC2)/210
% median(C2sum)/210
% median(C4overC1sum)/210
% median(wentropyC4)/210
% median(C4overC2sum)/210
% median(C3overC1sum)/210
% median(minDist2)/210
% median(minDist4)/210
% % 
% % equation
a= 20/6.21;
b= 10/474;
c= 20/1;
d= 100/97.5;
e= 20/65.8;
f= -20/3330; %because wentropy is negative
g= 10/22.3;
%h and i should be negative
h= -20/246;
i= -50/4.47;
equation = a*AreaC1+b*C1sum+(c*AreaC2./minDist2)+(d*C2sum./minDist2)...
    +e*C4overC1sum+f*wentropyC4+(g*C4overC2sum./minDist2)+h*C3overC1sum+i*minDist2




% 
[~,maxIdx]=max(equation);

 rectangle('Position',[handles.statsC1(maxIdx).BoundingBox(1),handles.statsC1(maxIdx).BoundingBox(2),...
            handles.statsC1(maxIdx).BoundingBox(3),handles.statsC1(maxIdx).BoundingBox(4)],...
            'EdgeColor','g','LineWidth',3 )






% 
% 
% RECTANGLZ DO NOT DELETE PER JAMES OR ELSE!
% 
% for k = 1 : numel(handles.statsC1)
%     if handles.group(k)==1
% %         centroidstring(i)=[num2str(handles.statsC1(k).Centroid(1)),', ',num2str(handles.statsC1(k).Centroid(2))];
%         
%         
%         rectangle('Position',[handles.statsC1(k).BoundingBox(1),handles.statsC1(k).BoundingBox(2),...
%             handles.statsC1(k).BoundingBox(3),handles.statsC1(k).BoundingBox(4)],...
%             'EdgeColor','g','LineWidth',3 )
%         %             sum([handles.stats(k).Nucleoli].')./handles.dna(k))
%     end
%     
%    
% end

   
   
%     
    outputFile = handles.ColorFiles{handles.imgCount+1};
   
    statsC1 = handles.statsC1; group = handles.group; 
%     dna = handles.dna; NucRatio = handles.NucRatio;
%     disp('Hey still alive')
%     imgCapt = getframe(handles.image_frame); imgCapt = imgCapt.cdata;
     save([get(handles.text_save_dir,'String') '\' outputFile '.mat'], 'equation','group');
%      imwrite(imgCapt,[get(handles.text_save_dir,'String') '\' outputFile]);
%     print(handles.image_frame,strcat(handles.ColorFiles{handles.imgCount},...
%         '.annotated.jpg'),'-djpeg');
    
% clear global handles.stats handles.group handles.dna handles.NucRatio

handles.imgCount = handles.imgCount+1; 
guidata(hObject,handles);

pause(1.5)
set(handles.pushbutton_nextCell,'Enable','on');
set(handles.response_text,'String','Click the Next Image Button to Move on!');
guidata(hObject,handles);


return


% --- Executes during object creation, after setting all properties.
function progress_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to progress_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_nextCell.
function pushbutton_nextCell_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nextCell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_nextCell,'Enable','off');
guidata(hObject,handles);
%  group = handles.group(:).class; % delete for non-example
%  stats = handles.stats;
if handles.imgCount == length(handles.C1Files);
    set(handles.response_text,'String',...
        'That is all the files in the directory!');
%     save([get(handles.text_save_dir,'String') '\output.mat'],'stats','group') % delete for non-example
    pause(0.5);
    set(handles.pushbutton_quant_stain,'Enable','on');
    set(handles.response_text,'String',...
        'Press Quantify Staining button to begin image analysis');
    
%     set(handles.pushbutton_load_dir,'Enable','on');
%     set(handles.pushbutton_save_dir,'Enable','on');
    return 
else
    axes(handles.image_frame);
    set(handles.image_frame,'Visible','off');
%     image(handles.Ifull);
    zoom(0.25);
    set(handles.image_frame,'XTick',[]);
    set(handles.image_frame,'YTick',[]);
    set(handles.progress_text,'String','Loading next image');
%     clear global handles.Ifull;
    guidata(hObject,handles);
    pushbutton_begin_Callback(hObject,[],handles);

end


% --- Executes during object creation, after setting all properties.
function pushbutton_save_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function pushbutton_load_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.filesLoaded = 0; guidata(hObject,handles);
return


% --- Executes during object creation, after setting all properties.
function pushbutton_nuc_crossing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_nuc_crossing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off');


% --- Executes during object creation, after setting all properties.
function pushbutton_nextCell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_nextCell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off');


% --- Executes on button press in pushbutton_quant_stain.
function pushbutton_quant_stain_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_quant_stain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(hObject,'Enable','off'); 
% widenElement = strel('disk',10,4);
set(handles.response_text,'String',...
    'Please wait, this could take up to 1 minute per image read');








group = handles.group;
stats = handles.stats;
save([get(handles.text_save_dir,'String') '\output.mat'],'stats','group'); %,'statsWide');



% --- Executes during object creation, after setting all properties.
function pushbutton_quant_stain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_quant_stain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off');
