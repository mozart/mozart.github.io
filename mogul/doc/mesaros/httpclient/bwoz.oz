%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                      % 
%  Simple web browser for using the HTTPClient module  %
%  made by Valentin Mesaros <valentin@info.ucl.ac.be>  %
%                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functor
import 
   HTTPClient(urlGET:UrlGET
	      urlHEAD:UrlHEAD
	      cgiGET:CgiGET
	      cgiPOST:CgiPOST
	      cgiISINDEX:CgiISINDEX) at 'x-ozlib://mesaros/net/HTTPClient.ozf'
   QTk 
   Application(exit:Exit)
   
define

%  Entity Headers
   EntHead = entHead(allow:"Allow:"
		     content_language:"Content-Language:"
		     content_encoding:"Content-Encoding:"
		     content_type:"Content-Type:"
		     expires:"Expires:"
		     last_modified:"Last-Modified:"
		     link:"Link:"
		     title:"Title:"
		     uri:"URI:")
   %content_language:"Content-Length:" % explicit added

%  General Headers
   GenHead = genHead(date:"Date:"
		     pragma:"Pragma:")
   
%  Request Headers
   ReqHead = reqHead(accept:"Accept:"
		     accept_charset:"Accept-Charset:"
		     accept_encoding:"Accept-Encoding:"
		     accept_language:"Accept-Language:"
		     authorization:"Authorization:"
		     'from':"From:"
		     if_modified_since:"If-Modified-Since:"
		     refer:"Refer:"
		     user_agent:"User-Agent:")
   
%% Returns a new list having the same elements as Ls but the Pos(th) element which is changed with El 
   fun {ChangeEl Ls El Pos}
      if {IsFree Ls} then [El]
      elseif Pos>{List.length Ls} then
	 {List.append Ls [El]}
      else
	 case Ls of nil then nil
	 [] X|Xr then
	    if Pos\=1 then X|{ChangeEl Xr El Pos-1} 
	    else El|{ChangeEl Xr El Pos-1} end
	 end
      end
   end
%% Clears the display area and initialise some variables
   proc {ClearBoard}
      {Win.line2.board set(state:normal)}
      {Win.line2.board set("")}
      {Win.line2.board set(state:disabled)}
      {Win.line3.lpct set("")}
      {Cell.assign OutPrms _}
      {Cell.assign HttpPrms _}
      {HeadersHandle set(state:disabled)}
      {ClearHandle set(state:disabled)}
   end
%% Closes the connection
   proc {CloseCon}
      try
	 if {IsDet {Cell.access HttpObj}} then
	    {{Cell.access HttpObj} closeAll(true)}
	 end
      catch E then
	 {ErrTreat E}
      finally
	 {StopProc}
      end
   end
%% Displays the exceptions in the 'error' window    
   proc {ErrTreat Err}      
      {{QTk.build td(title:'Error' 
		    lr(label(bitmap:error glue:w) 
		       td(lr(label(glue:nswe padx:5 pady:5 text:"The following error occured:"))		 
			  lr(label(glue:nswe padx:5 pady:5 text:Err))))
		    lrline(glue:swe pady:2) 
		    button(glue:s text:"Okay" padx:5 pady:5 
			      action:toplevel#close))
       } show(wait:true modal:true)}
   end
%% Computes and display the rate and the nr of bytes read   
   proc {GetRate Stream}
      fun {StringForm NrBytes}
	 Cont = {Cell.access HttpPrms}.content_length
      in
	 if {IsDet Cont} andthen Cont\=nil then
	    {List.flatten NrBytes|"  of  "|Cont|Tail}
	 else
	    {List.flatten NrBytes|Tail}
	 end
      end
      Tail = " bytes"
   in
      if {IsFree WindowClosed} then
	 case Stream of nil then
	    {Win.line3.lrate set("")}
	 [] X|Xr then
	    if X\=nil then
	       {Win.line3.lrate set({List.flatten {Float.toString X.1} |" KB/sec"})}
	       {Win.line3.lpct set({StringForm {Int.toString{{Cell.access HttpObj} bytesRead($)}}})}
	       {GetRate Xr}
	    else
	       {Win.line3.lrate set("")}
	       {Win.line3.lpct set({List.flatten {Int.toString{{Cell.access HttpObj} bytesRead($)}}|Tail})}
	    end
	 end
      end
   end
%% Initialises HttpReqPrms list
   proc {HttpReqPrmsInit}
      fun {AddEl Ls}
	 case Ls of nil then nil
	 [] X|Xr then
	    case X of Y#Yr then
	       Y#Yr#nil|{AddEl Xr}
	    else {AddEl Xr} end
	 end
      end
   in
      {Cell.assign HttpReqPrms {AddEl {List.flatten {Record.toListInd GenHead}|
				       {Record.toListInd ReqHead}|
				       {Record.toListInd EntHead}}}}
   end
%% Builds the request HttpPrms list 
   fun {HttpReqListInit Ls} 
      case Ls of nil then nil
      [] X|Xr then
	 case X of E#_#G andthen G\=nil then
	    E#G|{HttpReqListInit Xr}
	 else {HttpReqListInit Xr} end
      end
   end
%% Inserts text into display area, while it is constructing
   proc {InsertText String}
      proc {TillBound Q Ol Or N}
	 if {IsFree WindowClosed} then
	    case Q of nil then Ol=nil Or=nil
	    [] X|Xr then
	       if {IsDet X} andthen {IsDet Xr} then 
		  {List.append [X] {TillBound Xr $ Or N+1} Ol}	 
	       else
		  Ol=nil Or=Q
	       end
	    end
	 else Ol=nil Or=nil end
      end
      Oleft
      Oright
   in
      {TillBound String Oleft Oright 1}
      {Win.line2.board set(state:normal)}
      {Win.line2.board insert('end' Oleft)}
      {Win.line2.board set(state:disabled)}
      if Oright\=nil then
	 {InsertText Oright}
      end      
   end
%% Opens an HTTP connection    
   proc {OpenCon Pairs}
      RetAddr GetRateEnd 
   in
      {Win.line1.urlAddrFeat get(RetAddr)}
      if RetAddr \= nil then
	 try
	    thread
	       {InsertText {Cell.access OutPrms}.sOut}
	    end
	    thread
	       {Win.line3.lrate set("0.0 KB/sec")}
	       {GetRate {Cell.access OutPrms}.rateStrm}
	       GetRateEnd=unit
	    end
	    if {IsDet Pairs} andthen Pairs==nil then
	        {{Cell.access HttpObj} getService(RetAddr {Cell.assign OutPrms} {Cell.assign HttpPrms})}
	    else
	       {{Cell.access HttpObj} getService(RetAddr Pairs {Cell.assign OutPrms} {Cell.assign HttpPrms})}
	    end
	    {Cell.assign CgiPairsList _}
	    {Cell.assign CgiIsIndexStr _}
	 catch E then
	    {ErrTreat E}
	 finally
	    {Wait GetRateEnd}
	 end  
      end
   end
%% Displays and manages About frame   
   proc {ShowAbtDialog}
      {{QTk.build td(title:'About bwoz' 
		     lr(glue:w 
			label(text:"Aim : " glue:w padx:5 pady:5)
			label(text:"Make use of HttpClient package." glue:w padx:5 pady:5 font:'helvetica 8'))
		     lr(glue:w
			label(text:"App name : " glue:w padx:5 pady:5)
			label(text:"Woz browser." glue:w padx:5 pady:5 font:'helvetica 8'))
		     lr(label(text:"Author : " glue:w padx:5 pady:5)
		       label(text:"Valentin Mesaros <valentin@info.ucl.ac.be>" glue:w padx:5 pady:5 font:'helvetica 8'))
		    lrline(glue:swe pady:2) 
		    button(glue:s text:"Okay" padx:5 pady:5 
			      action:toplevel#close))
       } show(wait:true modal:true)}
   end
%% Displays and manages Cgi Params frame   
    proc {ShowCgiPrms}
      proc {EntryInit P}
	 {Cell.assign Pos P}
	 {NameEntryHandle set("")}
	 {ValueTextHandle set("")}
	 if IsCGI then Str in
	    if P > 1 then {LessButHandle set(state:active)} end
	    if {IsDet {Cell.access CgiPairsList}} andthen
	       {List.length {Cell.access CgiPairsList}} >= P then
	       Str = {List.nth {Cell.access CgiPairsList} P}.1
	       if Str\=nil then
		  {MoreButHandle set(state:active)}
		  {ClButHandle set(state:active)}
	       end
	       {NameEntryHandle set(Str)}
	       {ValueTextHandle set({List.nth {Cell.access CgiPairsList} P}.2)}
	    end
	 else
	    if {IsDet {Cell.access CgiIsIndexStr}} then
	       {ValueTextHandle set({Cell.access CgiIsIndexStr})}
	       {ClButHandle set(state:active)}
	    end
	    {NameEntryHandle set(state:disabled bg:gray)}
	 end
      end
      proc {PrmsProc}
	 NamePrm ValPrm
      in
	 {ValueTextHandle gettext(p(1 0) "end - 1 chars" ValPrm)}
	 if IsCGI then
	    {NameEntryHandle get(NamePrm)}
	    if NamePrm\=nil then 
	       {Cell.assign CgiPairsList {ChangeEl {Cell.access CgiPairsList} NamePrm#ValPrm {Cell.access Pos}}}
	    end
	 else
	    if ValPrm\=nil then 
	       {Cell.assign CgiIsIndexStr ValPrm}
	    end
	 end     
      end
      CgiPrmsWin
      TopLevel
      NameEntryHandle ValueTextHandle
      LessButHandle MoreButHandle ClButHandle
      IsCGI TopInLabel
      Pos = {Cell.new _}
    in
       if {CgiPOSTHandle get($)} then
	  IsCGI=true
	  TopInLabel="CGI POST Parameters\nas name and value pairs"
       elseif {CgiISINDEXHandle get($)} then
	  IsCGI=false
	  TopInLabel="CGI ISINDEX Parameter"
       else%{CgiGETHandle get($)}
	  IsCGI=true
	  TopInLabel="CGI GET Parameters\nas name and value pairs"
       end      
       CgiPrmsWin=td(title:"CGI Parameters"
		     label(text:TopInLabel glue:n padx:20 pady:20)
		     lr(glue:nwe
			label(text:"Name" glue:nw padx:10 pady:10 width:5)
			entry(width:21 bg:white glue:nwe handle:NameEntryHandle  padx:10 pady:10)
		       )
		     lr(glue:nswe
			label(text:"Value" glue:nw padx:10 pady:10 width:5)
			text(lrscrollbar:true width:21 height:7
			     tdscrollbar:true 
			     glue:nswe bg:white
			     wrap:none padx:10 pady:10
			     handle:ValueTextHandle
			    )
		       )
		     lr(button(glue:s text:"Okay" padx:15 pady:15
			       action:proc{$}
					 {PrmsProc}
					 {TopLevel close}
				      end)
			button(glue:s text:"Less" padx:15 pady:15
			       handle:LessButHandle
			       state:disabled
			       action: proc{$}
					  {MoreButHandle set(state:active)}
					  {LessButHandle set(state:disabled)}
					  {PrmsProc}
					  {EntryInit {Cell.access Pos}-1}
				       end)
			button(glue:s text:"More" padx:15 pady:15
			       handle:MoreButHandle
			       state:disabled
			       action: proc{$}
					  {MoreButHandle set(state:disabled)}
					  {LessButHandle set(state:active)}
					  {PrmsProc}
					  {EntryInit {Cell.access Pos}+1}
				       end)
			button(glue:s text:"ClearAll" padx:15 pady:15
			       handle:ClButHandle
			       state:disabled
			       action:proc{$}
					 {ClButHandle set(state:disabled)}
					 if IsCGI then
					    {Cell.assign CgiPairsList _}
					    {LessButHandle set(state:disabled)}
					    {MoreButHandle set(state:disabled)}	    
					    {NameEntryHandle set("")}
					 else {Cell.assign CgiIsIndexStr _}
					 end
					 {ValueTextHandle set("")}
				      end
			      )))
       {QTk.build CgiPrmsWin TopLevel}
       {ValueTextHandle bind(event: '<KeyPress>' 
			     action: proc {$} Str in
					{ValueTextHandle gettext(p(1 0) "end - 1 chars"Str)}
					if Str\=nil then
					   {ClButHandle set(state:active)}
					else
					   {ClButHandle set(state:disabled)}
					end
				     end)} 
       {NameEntryHandle bind(event: '<KeyPress>' 
			     action: proc {$} Str in
					{NameEntryHandle get(Str)}
					if Str\=nil then
					   if {Cell.access Pos}>1 then
					      {LessButHandle set(state:active)}
					   end
					   {ClButHandle set(state:active)}
					   {MoreButHandle set(state:active)}
					else
					   if {Cell.access Pos}==0 then
					      {LessButHandle set(state:disabled)}
					   end
					   {ClButHandle set(state:disabled)}
					   {MoreButHandle set(state:disabled)}
					end
				     end)}
       {NameEntryHandle getFocus}
       {EntryInit 1}
       {TopLevel show(wait:true modal:true)}
   end
%% Displays and manages Response Headers frame 
   proc {ShowRepHeaders}
      fun {InsertHeader R}
	 case R
	 of nil then ""
	 [] X|Xr then
	    case X of F#V then
	       Str={Atom.toString F}
	    in
	       if {IsDet V} then
		  {List.flatten Str|Dots|V|CR|{InsertHeader Xr}}
	       else
		  {List.flatten Str|Dots|UnBound|CR|{InsertHeader Xr}}
	       end
	    else
	       {List.flatten ""|{InsertHeader Xr}}
	    end
	 else 
	    ""
	 end		       
      end
      HeadersWin
      TopLevel
      HeaderText TextHandle
      Headers={Cell.access HttpPrms}
      Dots=" : " UnBound="_" CR="\n"
   in
      HeaderText=text(glue:nswe width:50 height:8 bg:ivory
		      lrscrollbar:true
		      tdscrollbar:true
		      wrap:none
		      state:disabled
		      handle:TextHandle
		     )
      HeadersWin=td(title:"Response Headers"
		    label(text: "Document\'s HTTP Response Headers" glue:n padx:5 pady:5 )
		    HeaderText
		    button(glue:s text:"Okay" padx:5 pady:5 
			   action:toplevel#close))
      {QTk.build HeadersWin TopLevel}
      if {IsDet Headers} then
	 {TextHandle set(state:normal)}
	 {TextHandle insert('end' {InsertHeader {Record.toListInd Headers}})}
	 {TextHandle set(state:disabled)}
      end
      {TopLevel show(wait:true modal:true)}
   end
%% Displays and manages Request Headers frame 
   proc {ShowReqHeaders}
      fun {ClearList Ls}
	 case Ls of nil then nil
	 [] X|Xr then
	    case X of E#F#_ then
	       E#F#nil|{ClearList Xr}
	    else {ClearList Xr} end
	 end
      end
      fun {GetAtom Pos}
	 {List.nth {Cell.access HttpReqPrms} Pos}.1
      end
      fun {GetValue Pos}
	 {List.nth {Cell.access HttpReqPrms} Pos}.3
      end
      fun {GetName Pos}
	 {List.nth {Cell.access HttpReqPrms} Pos}.2
      end
      fun {SetList Ls}
	 case Ls of nil then nil
	 [] X|Xr then
	    X.2|{SetList Xr}
	 end
      end
      HeadersWin
      TopLevel
      ListHandle LabelHandle EntryHandle
      Pos={Cell.new 1}
   in
      HeadersWin=lr(title:"Reqest Headers"
		    td(glue:ns
		       label(text:"Headers" padx:5 pady:5 glue:n)
		       label(text:"" padx:5 pady:5 glue:ws handle:LabelHandle)
		       listbox(padx:5 pady:5 handle:ListHandle bg:white glue:ns 
			       tdscrollbar:true
			       height:15
			       selectmode:single
			       init:{SetList {Cell.access HttpReqPrms}}
			       action: proc{$}
					   El 
					in
					  El={GetAtom {Cell.access Pos}}#{GetName {Cell.access Pos}}#{EntryHandle get($)}
					  {Cell.assign HttpReqPrms {ChangeEl {Cell.access HttpReqPrms} El {Cell.access Pos}}}
					  {Cell.assign Pos {ListHandle get(firstselection:$)}}
					  {ListHandle getFocus}
					  {LabelHandle set({GetName {Cell.access Pos}})}
					  {EntryHandle set({GetValue {Cell.access Pos}})}
				       end))
		    td(glue:nwe
		       label(text:"Value" padx:5 pady:5 glue:nwe)
		       entry(width:40 padx:5 pady:5 glue:nwe bg:white handle:EntryHandle)
		       lr(button(text:"Okay" padx:15 pady:15 glue:s
				 action:proc{$}
					   El 
					in
					   El={GetAtom {Cell.access Pos}}#{GetName {Cell.access Pos}}#{EntryHandle get($)}
					   {Cell.assign HttpReqPrms {ChangeEl {Cell.access HttpReqPrms} El {Cell.access Pos}}}
					   {TopLevel close}
					end)
			  button(text:"ClearAll" padx:15 pady:15 glue:s
				 action: proc{$}
					    {Cell.assign Pos 1}
					    {Cell.assign HttpReqPrms {ClearList {Cell.access HttpReqPrms}}}
					    {ListHandle getFocus}
					    {EntryHandle set({GetValue {Cell.access Pos}})}
					    {LabelHandle set({GetName {Cell.access Pos}})}
					 end))))
      {QTk.build HeadersWin TopLevel}
      {ListHandle getFocus}
      {EntryHandle set({GetValue {Cell.access Pos}})}
      {LabelHandle set({GetName {Cell.access Pos}})}
      {TopLevel show(wait:true modal:true)}
   end
%% Displays and manages Rate Fetch frames 
   proc {ShowRateFetchWin Type TopInLabel XTitle TopCell}
      proc {OkProc}
	 Val
      in
	 if Type==filen orelse Type==psrv then
	    {EntryHandle get(Val)}
	    if Val==nil then
	       {Cell.assign TopCell _}
	       {TopLevel close}
	    elseif {String.is Val} then
	       {Cell.assign TopCell Val}
	       {TopLevel close}
	    else
	       {ErrTreat "It is not a Sring"}
	    end
	 else
	    {EntryHandle get(Val)}
	    if Val==nil then
	       {Cell.assign TopCell _}
	       {TopLevel close}
	    else
	       IntVal
	    in
	       if {String.isInt Val} andthen {String.toInt Val}>=0 then
		  IntVal = {String.toInt Val}
		  {Cell.assign TopCell IntVal}
		  {TopLevel close}
	       else	    
		  {ErrTreat "It is not a positive Integer"}
	       end
	    end
	 end
      end
      RateFetchWin TopLevel EntryHandle
      
   in
      RateFetchWin = td(title: XTitle
			label(text:TopInLabel padx:5 pady:5)
			entry(width:25 bg:white handle:EntryHandle padx:20 pady:5 glue:we)
			lr(button(glue:s text:"Okay" padx:20 pady:5 action:proc{$}{OkProc}end)
			   empty
			   button(glue:s text:"Cancel" padx:20 pady:5 action:toplevel#close)))
		       
      {QTk.build RateFetchWin TopLevel}
      if {IsDet {Cell.access TopCell}} then
	 {EntryHandle set({Cell.access TopCell})}
      else {EntryHandle set("")} end
      {EntryHandle bind(event:'<KeyPress-Return>' action: proc{$}{OkProc}end)}
      {TopLevel show(wait:true modal:true)}  
   end
%% Istantiates the proper Http Object
   proc {StartProc KeyPress}
      HttpReq HttpReqList
   in
      if {Win.line1.goBut get($)}=="Start"
      then InPrms Pairs
      in
	 InPrms = inPrms(file:{Cell.access FileName}
			 tInterval:{Cell.access TInterval}
			 toFile:{ToFileHandle get($)}
			 toStrm:{ToStreamHandle get($)}
			 proxySrv:{Cell.access ProxyServer}
			 proxyPort:{Cell.access ProxyPort}
			)
	 {ClearBoard}
	 HttpReqList={HttpReqListInit {Cell.access HttpReqPrms}}
	 if HttpReqList\=nil then
	    HttpReq={List.toRecord httpReq HttpReqList}
	 end
	 if {UrlHEADHandle get($)} then
	    {Cell.assign HttpObj {New UrlHEAD init(InPrms HttpReq)}}
	    Pairs = nil
	 elseif {CgiGETHandle get($)} then
	    {Cell.assign HttpObj {New CgiGET init(InPrms HttpReq)}}
	    Pairs = {Cell.access CgiPairsList}
	 elseif {CgiPOSTHandle get($)} then
	    {Cell.assign HttpObj {New CgiPOST init(InPrms HttpReq)}}
	    Pairs = {Cell.access CgiPairsList}
	 elseif {CgiISINDEXHandle get($)} then
	    {Cell.assign HttpObj {New CgiISINDEX init(InPrms HttpReq)}}
	    Pairs = {Cell.access CgiIsIndexStr}
	 else %%{UrlGETHandle get($)} 
	    {Cell.assign HttpObj {New UrlGET init(InPrms HttpReq)}}
	    Pairs = nil
	 end
	 {Win.line1.goBut set(text:'Stop' fg:firebrick)}
	 {Win.line1.tempBut set(state:active)}
	 {HeadersHandle set(state:active)}
	 {OpenCon Pairs}
	 {StopProc}
      else
	 if KeyPress==false then 
	    {CloseCon}
	 end
      end
   end
%% De-initialises some variables
   proc {StopProc}
      {Win.line1.goBut set(text:'Start' fg:black)}
      {Win.line1.tempBut set(text:"TempStop" state:disabled)}
      {ClearHandle set(state:active)}
   end
%% Temporarely stop and start   
   proc {TempButProc}
      if {Win.line1.goBut get($)}=="Stop" then
	 if {Win.line1.tempBut get($)}=="TempStop"
	 then 
	    {Win.line1.tempBut set(text:'TempStart' fg:firebrick)}
	    {{Cell.access HttpObj} stopTemp}
	 elseif {Win.line1.tempBut get($)}=="TempStart" then
	    {Win.line1.tempBut set(text:'TempStop' fg:black)}
	    {{Cell.access HttpObj} startTemp}
	 end
      end
   end
   
   HttpObj = {Cell.new _}
   OutPrms = {Cell.new _}
   HttpPrms = {Cell.new _}
   HttpReqPrms = {Cell.new _}
   FileName = {Cell.new _}
   TInterval = {Cell.new 1500}
   CgiPairsList = {Cell.new _}
   CgiIsIndexStr = {Cell.new _}
   ProxyPort = {Cell.new _}
   ProxyServer = {Cell.new _}
   HeadersHandle
   ClearHandle
   UrlHEADHandle
   CgiGETHandle
   CgiPOSTHandle
   CgiISINDEXHandle
   ToFileHandle
   ToStreamHandle
   CGIPrmsHandle
   WindowClosed

   MenuWin=menu(command(text: "About"
			action: proc{$} {ShowAbtDialog} end)
		command(text: "Clear"
			accelerator:alt(l)
			state: disabled
		        action: ClearBoard
			handle:ClearHandle
		       )
		separator
		command(text: "Exit"
			accelerator:alt(q)
			action: proc{$}
				   WindowClosed=unit
				   {CloseCon}
				   {Win close}
				end
		       )
	       )
   MenuServ=menu(radiobutton(text: "UrlGET"
			     init: true
			     action: proc{$}
					{CGIPrmsHandle set(state:disabled)}
				     end
			     group:radiogroup
			    )
		 radiobutton(text: "UrlHEAD"
			     action: proc{$}
					{CGIPrmsHandle set(state:disabled)}   
				     end
			     group:radiogroup
			     handle:UrlHEADHandle
			    )
		 radiobutton(text: "CgiGET"
			     action: proc{$}
					{CGIPrmsHandle set(state:active)}
				     end
			     group:radiogroup
			     handle:CgiGETHandle
			    )
		 radiobutton(text: "CgiPOST"
			     action: proc{$}
					{CGIPrmsHandle set(state:active)}
				     end
			     group:radiogroup
			     handle:CgiPOSTHandle
			    )
		 radiobutton(text: "CgiISINDEX"
			     action: proc{$}
					{CGIPrmsHandle set(state:active)}
				     end
			     group:radiogroup
			     handle:CgiISINDEXHandle
			    )
		)
   MenuView=menu(command(text: "Rep Headers"
			 state: disabled
			 action:proc{$}{ShowRepHeaders}end
			 handle:HeadersHandle)
		)
   MenuOpt=menu(checkbutton(text: "ToFile"
			    init: false
			    handle:ToFileHandle
			   )
		checkbutton(text: "ToStream"
			    init: true			      
			    handle:ToStreamHandle
			   )
		command(text: "Req Headers"
			action: proc{$}{ShowReqHeaders}end)
		command(text: "File Name"
			action: proc{$}
				   {ShowRateFetchWin filen "The filename the document to be saved" "File Name" FileName}
				end
		       )
		command(text: "Time Interval"
			action: proc{$}
				   {ShowRateFetchWin tinterval "The time interval to take into account\nwhen compting the rate (ms)" "Time Interval" TInterval}
				end)
		command(text: "CGI Params"
			state: disabled
			handle:CGIPrmsHandle
			action: proc{$}
				   {ShowCgiPrms}
				end
		       )
		cascade(text:"Proxy"
			menu:menu(tearoff:false
				  command(text: "Server"
					  action: proc{$}
						     {ShowRateFetchWin psrv "Proxy Server""Proxy"  ProxyServer}
						  end
					 )
				  command(text: "Port"
					  action: proc{$}
						     {ShowRateFetchWin pport "Proxy Port" "Proxy" ProxyPort}
						  end
					 )
				 )
		       )
	       )
   LocLabel=label(text:"Location:" font:'helvetica 8' glue:e)
   UrlAddr=entry(bg:white
		 feature:urlAddrFeat glue:we)
   GoBut=button(text: 'Start'
		font: 'helvetica 8'
		glue:ne
		action: proc{$} thread {StartProc false} end end
		feature:goBut
	       )
   TempBut=button(text: 'TempStop'
		  font: 'helvetica 8'
		  state:disabled
		  glue:e
		  feature:tempBut
		  action: proc {$} thread {TempButProc} end end
		 )
   TextWidget=text(glue:nswe width:85 height:30 bg:ivory
		   lrscrollbar:true
		   tdscrollbar:true
		   wrap:none
		   state:disabled
		   feature:board
		   )
   RateLabel=label(width:28 height:1 font:'helvetica 8' glue:w feature:lrate justify:left)
   PctLabel=label(width:38 height:1 font:'helvetica 8' glue:w feature:lpct justify:left)   
   WinDesc=td(title:"Woz browser"
	      lr(glue:nw
		 feature:line0
		 menubutton(glue:nw text:"Window" menu:MenuWin feature:window)
		 menubutton(glue:nw text:"Services" menu:MenuServ)
		 menubutton(glue:nw text:"View" menu:MenuView feature:view)
		 menubutton(glue:nw text:"Options" menu:MenuOpt feature:options)
		)
	      lr(glue:nwe
		 feature:line1
		 LocLabel UrlAddr GoBut TempBut empty)
	      lr(glue:nswe
		 feature:line2
		 TextWidget)
	      lr(glue:w
		 feature:line3
		 RateLabel tdline(glue:wns) PctLabel)
	      action:proc{$}
			WindowClosed=unit
			{CloseCon}
			{Win close}
		     end
	     )
   Win={QTk.build WinDesc}
in
   {Win.line1.urlAddrFeat getFocus}
   {Win.line1.urlAddrFeat bind(event:"<KeyPress-Return>"
                               action: proc{$} thread {StartProc true} end end
			      )}
   {HttpReqPrmsInit}
   {Win show(wait:true)}
   {Application.exit 0}
end
