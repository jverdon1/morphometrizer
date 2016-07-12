function varargout = NuclearMorphometrizer(varargin)
% NUCLEARMORPHOMETRIZER MATLAB code for NuclearMorphometrizer.fig
%      NUCLEARMORPHOMETRIZER, by itself, creates a new NUCLEARMORPHOMETRIZER or raises the existing
%      singleton*.
%
%      H = NUCLEARMORPHOMETRIZER returns the handle to a new NUCLEARMORPHOMETRIZER or the handle to
%      the existing singleton*.
%
%      NUCLEARMORPHOMETRIZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NUCLEARMORPHOMETRIZER.M with the given input arguments.
%
%      NUCLEARMORPHOMETRIZER('Property','Value',...) creates a new NUCLEARMORPHOMETRIZER or raises the
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

% Last Modified by GUIDE v2.5 17-Jun-2016 11:10:48
% Updated by James Verdone, Johns Hopkins School of Medicine, 6/17/2016

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


handles.imgCount = 0;
handles.filesLoaded = 1;
guidata(hObject,handles);
set(handles.pushbutton_begin,'Enable','on');


for i = 1:length(Files);
    
    j = strfind(Files(i).name,'C1-');
    k = strfind(Files(i).name,'C2-');
    l = strfind(Files(i).name,'C3-'); %Uncomment for loading C3 images
    m = strfind(Files(i).name,'C4-');
    
    if isempty(j) == 0
        C1Files{i} = Files(i).name;
    elseif isempty(k) == 0
        C2Files{i} = Files(i).name;
    elseif isempty(l) == 0
        C3Files{i} = Files(i).name; %Uncomment for loading C3 images
    elseif isempty(m) == 0
        C4Files{i} = Files(i).name;
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

handles.C1Files = C1Files;
handles.C2Files = C2Files;
handles.C3Files = C3Files;
handles.C4Files = C4Files;
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
%         handles.Ic2 = struct; %handles.Ic3 = struct;
        handles.Ic4 = struct; handles.Ifull = struct;
        [handles.bwl(1:length(handles.ColorFiles)).bw] = deal([]);
        [handles.bwl(1:length(handles.ColorFiles)).Icut] = deal([]);
        [handles.Ic1(1:length(handles.ColorFiles)).Image] = deal([]);
%         [handles.Ic2(1:length(handles.ColorFiles)).Image] = deal([]);
        %[handles.Ic3(1:length(handles.ColorFiles)).Image] = deal([]);
        [handles.Ic4(1:length(handles.ColorFiles)).Image] = deal([]);
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
    
%     handles.Ic2(handles.imgCount+1).Image = ...
%         imread(handles.C2Files{handles.imgCount+1});
    
    % handles.Ic3(handles.imgCount+1).Image = ...
        %imread(handles.C3Files{handles.imgCount+1});
        
    handles.Ic4(handles.imgCount+1).Image = ...
        imread(handles.C4Files{handles.imgCount+1});
    
    handles.Ifull(handles.imgCount+1).Image = ...
        imread(handles.ColorFiles{handles.imgCount+1});
    
    guidata(hObject,handles);
    %image(Ifull);
    
    %Edit watershed segmentation variables here as necessary%
    Blur = 2;
    Threshold = 0.30;
    minArea = 200; maxArea = 1*10^10;
    WaterShedRegressConst = 2;
    
    %%%%%%%%%%%%%%%%%%%%%%
    %Process Images Below%
    %%%%%%%%%%%%%%%%%%%%%%
    
    %Perform watershed algorithm on greyscale DAPI Image
    
    Ieq = adapthisteq(handles.Ic1(handles.imgCount+1).Image);
    IFilt = imgaussfilt(Ieq,Blur);
    IThres = im2bw(IFilt, Threshold);
    IClean = bwareafilt(IThres,[minArea maxArea]);
    D = bwdist(~IClean);
    D = -D;
    mask = imextendedmin(D,WaterShedRegressConst);
    D2 = imimposemin(D,mask);
    D2(~IClean) = -Inf;
    Ld2 = watershed(D2);
    Icut = IClean;
    Icut(Ld2 ==0)=0;
    handles.bwl(handles.imgCount+1).bw = bwlabel(Icut,8);
    handles.bwl(handles.imgCount+1).Icut = Icut;
    perim = bwperim(Icut);
    
       
    stats =  regionprops(Icut,handles.Ic1(handles.imgCount+1).Image,'all');
    Area = [stats.Area].';
    delInd = zeros(1,length(Area));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Filter out objects with small area
   
    for j = 1:numel(stats)
        if Area(j) < 250
            delInd(j) = 1;
        end
    end
    
    delIndShort = find(delInd);
    delIndShortSort = sort(delIndShort,'descend');
    
    for m = 1:length(delIndShort)
        stats(delIndShortSort(m)) = [];
    end
    [stats(:).C4] = deal([]);
    for j = 1:length(stats)
      stats(j).C4 = handles.Ic4(handles.imgCount+1).Image(stats(j).PixelIdxList);
    end
    handles.stats = stats;
%     if (handles.imgCount)==0
%        handles.stats = stats;
%     else
%        handles.stats = [handles.stats; stats];
%     end
    
    handles.group = zeros(length(stats),1);
    guidata(hObject,handles);
     
    Segout = handles.Ifull(handles.imgCount+1).Image;
    if numel(stats) ~= 0
        for i = 1:size(Segout,1)
            for j = 1:size(Segout,2)
                if perim(i,j) ==1
                    Segout(i,j,:) = 255;
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
    end
    hold on;
    set(handles.popupmenu1,'Visible','on');
    set(handles.response_text,'String','Choose the # of Good CTC Nuclei from Dropdown');
    


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
set(handles.response_text,'String',strcat(num2str(numberPicked),' CTC(s) properly segmented!'));
pause(1);
set(handles.response_text,'String','Click the "Choose Nuclei" button, then click any CTC nuclei');
handles.CTCnum = numberPicked;
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
[x,y] = ginput(handles.CTCnum);
CTCids = zeros(handles.CTCnum,1);
axes(handles.image_frame);

image(handles.Ifull(handles.imgCount+1).Image); 
set(handles.image_frame,'XTick',[]);
set(handles.image_frame,'YTick',[]);
set(handles.response_text,'String','Please wait while computer processes your cells!');

guidata(hObject,handles);
pause(.2);

if handles.CTCnum~=0
    for i = 1:handles.CTCnum;
        for j = 1:length(handles.stats)
            
            temp = find(ismember(handles.stats(j).PixelList,floor([x(i) y(i)])),1);
            if ~isempty(temp)
                CTCids(i) = j;
            end
        end
    end
end



% handles.group(handles.imgCount+1).class = zeros(length(handles.stats(handles.imgCount+1)),1);
% handles.group(handles.imgCount+1).class(CTCids) = 1;
handles.group(CTCids) = 1;
% CTCids
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

% for k = 1 : numel(handles.stats)
%     if handles.group(k)==1
%         text(handles.stats(k).Centroid(1),handles.stats(k).Centroid(2), ...
%             sprintf('%1.3f', handles.NucRatio(k)),'Color','w',...
%             'HorizontalAlignment','center');
%         
%         rectangle('Position',[handles.stats(k).BoundingBox(1),handles.stats(k).BoundingBox(2),...
%             handles.stats(k).BoundingBox(3),handles.stats(k).BoundingBox(4)],...
%             'EdgeColor','r','LineWidth',3 )
%         %             sum([handles.stats(k).Nucleoli].')./handles.dna(k))
%     end
% end
   
   
%     
    outputFile = handles.ColorFiles{handles.imgCount+1};
   
    stats = handles.stats; group = handles.group; 
%     dna = handles.dna; NucRatio = handles.NucRatio;
%     disp('Hey still alive')
%     imgCapt = getframe(handles.image_frame); imgCapt = imgCapt.cdata;
     save([get(handles.text_save_dir,'String') '\' outputFile '.mat'], 'stats','group');
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
guidata(hObject,handles);
% handles.statsWide = struct;
handles.totalLength = 0;
% for r = 1:length(handles.ColorFiles)
%     handles.totalLength = handles.totalLength + length(handles.group(r).class);
%     if r ==1
%         group = [handles.group(r).class].';
%     else
%         group = [group; handles.group(r).class.'];
%     end
%     
% end
% count = 0;
% for r = 1:length(handles.ColorFiles)
%     
%     for i = 1:max(max(handles.bwl(r).bw))
%         count = count +1;
%         Ionly = zeros(size(handles.bwl(r).Icut));
%         Ionly((handles.bwl(r).bw==i)) = 1;
%         IonlyWide = imdilate(Ionly,widenElement);
%         if (i ==1 && r ==1)
%             handles.statsWide = regionprops(IonlyWide,handles.Ic4(r).Image,'all');
%             %            statsWideC3 = regionprops(IonlyWide,Ic3,'all');
%             %             statsWideC4 = regionprops(IonlyWide,Ic4,'all');
%             [handles.statsWide(2:handles.totalLength).Image] = deal([]);
%             %            [statsWideC3(2:max(max(bwl))).Area] = deal([]);
%             %            [statsWideC4(2:max(max(bwl))).Area] = deal([]);
%         else
%             statsWide = regionprops(IonlyWide,'Image','PixelList');
%             handles.statsWide(count) = statsWide;
%         end
%     end
%     
% end
% statsWide = handles.statsWide;
group = handles.group;
stats = handles.stats;
save([get(handles.text_save_dir,'String') '\output.mat'],'stats','group'); %,'statsWide');



% --- Executes during object creation, after setting all properties.
function pushbutton_quant_stain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_quant_stain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off');
