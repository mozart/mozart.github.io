%%%
%%% Chapter: Getting started
%%%

declare
W={New Tk.toplevel tkInit(title:'Capitalization')}
E={New Tk.entry    tkInit(parent:W)}
B={New Tk.button   tkInit(parent: W
                          text:   'Change Capitalization'
                          action: proc {$}
                                     S={E tkReturn(get $)}
                                  in
                                     {E tk(delete 0 'end')}
                                     {E tk(insert 0 {Map S fun {$ I}
                                                              case {Char.type I}
                                                              of lower then {Char.toUpper I}
                                                              [] upper then {Char.toLower I}
                                                              else I
                                                              end
                                                           end})}
                                  end)}
{Tk.send pack(E B fill:x padx:4 pady:4)}





%%%
%%% Chapter: Widgets
%%%

%%
%% Toplevel widgets
%%

%% Creating a toplevel widget
declare
W={New Tk.toplevel tkInit(width:150 height:50)}

%% Changing its backgound
{W tk(configure background:purple)}

%% Closing the toplevel widget
{W tkClose}


%%
%% Frames
%%

declare
W ={New Tk.toplevel tkInit}
Fs={Map [groove ridge flat sunken raised]
    fun {$ R}
       {New Tk.frame tkInit(parent:W width:2#c height:1#c
                            relief:R borderwidth:4)}
    end}
{{Nth Fs 3} tk(configure background:black)}
{Tk.send pack(b(Fs) side:left padx:4 pady:4)}


{W tkClose}


%%
%% Label Widgets
%%

declare
W ={New Tk.toplevel tkInit}
L1={New Tk.label tkInit(parent:W bitmap:info)}
L2={New Tk.label tkInit(parent:W text:'Labels: bitmaps and text')}
{Tk.send pack(L1 L2 side:left padx:2#m pady:2#m)}

{L1 tk(configure bitmap:warning)}



%%
%% Bitmap options
%%

{L2 tk(configure bitmap:     '@'#{Property.get 'oz.home'}#
                             '/doc/wp/queen.xbm'
                 foreground: orange)}


{W tkClose}


declare
W={New Tk.toplevel tkInit}
{List.forAllInd [error     gray75 gray50    gray25   gray12
                 hourglass info   questhead question warning]
 proc {$ I D}
    R=(I-1) div 5 
    C=(I-1) mod 5
 in
    {Tk.batch [grid(row:R*2   column:C
                    {New Tk.label tkInit(parent:W bitmap:D)})
               grid(row:R*2+1 column:C
                    {New Tk.label tkInit(parent:W text:D)})]}
 end}


{W tkClose}



%%
%% Font options
%%

declare
W={New Tk.toplevel tkInit}
{ForAll [times helvetica courier]
 proc {$ Family}
    {ForAll [normal bold]
     proc {$ Weight}
        F={New Tk.font  tkInit(family: Family 
                               weight: Weight 
                               size:   12)}
        L={New Tk.label tkInit(parent: W
                               text:   'A '#Weight#' '#Family#' font.'
                               font:   F)}
     in
        {Tk.send pack(L)}
     end}
 end}


{W tkClose}



%%
%% Images
%%

declare
W ={New Tk.toplevel tkInit}
D ={Property.get 'oz.home'}#'/doc/wp/'
I ={New Tk.image tkInit(type:photo format:ppm file:D#'truck-left.ppm')}
L1={New Tk.label tkInit(parent:W image:I)}
L2={New Tk.label tkInit(parent:W image:I)}
L3={New Tk.label tkInit(parent:W image:I)}
{Tk.send pack(L1 L2 L3 padx:1#m pady:1#m side:left)}

{I tk(configure file:D#'truck-right.ppm')}


{W tkClose}



%%
%% Messages
%%

declare
W ={New Tk.toplevel tkInit(bg:white)}
S ='Text extending over several lines.'
Ms={Map [left#200 center#100 right#50]
    fun {$ J#A}
       {New Tk.message tkInit(parent:W text:S justify:J aspect:A)}
    end}
{Tk.send pack(b(Ms) side:left padx:2#m pady:2#m)}


{W tkClose}




%%%
%%% Chapter: Geometry Managers
%%%

%%
%% The Packer
%%

declare
fun {NewLabels}
   W={New Tk.toplevel tkInit(background:white)}
in
   {Map ['label' 'Second label widget' '3rd label']
    fun {$ A}
       {New Tk.label tkInit(parent:W text:A)}
    end}
end

declare
[L1 L2 L3] = {NewLabels}
{Tk.send pack(L1 L2 L3)}

{Tk.send pack(b({NewLabels}))}


%% Side Options
{Tk.send pack(b({NewLabels}) side:left)}

{Tk.send pack(b({NewLabels}) side:bottom)}


%% Padding
{Tk.send pack(b({NewLabels}) padx:1#m pady:1#m)}

{Tk.send pack(b({NewLabels}) ipadx:2#m ipady:2#m)}


%% Anchors
{Tk.send pack(b({NewLabels}) anchor:w padx:1#m pady:1#m)}


%% Filling and Expansion
{Tk.send pack(b({NewLabels}) fill:x)}

{Tk.send pack(b({NewLabels}) expand:true)}

{Tk.send pack(b({NewLabels}) fill:both expand:true)}



%%
%% The Grid Geometry Manager
%%

declare
W={New Tk.toplevel tkInit(bg:white)}
proc {GL W R C S}
   L={New Tk.label tkInit(parent:W text:S)}
in
   {Tk.send grid(L row:R column:C padx:4 pady:4)}
end
{GL W 1 1 nw}   {GL W 1 2 north} {GL W 1 3 ne}
{GL W 2 1 west}                  {GL W 2 3 east}
{GL W 3 1 sw}   {GL W 3 2 south} {GL W 3 3 sw}


%% Span Options
declare
W={New Tk.toplevel tkInit(bg:white)}
{Tk.send grid({New Tk.label tkInit(parent:W text:'Upper left')} 
              row:1    rowspan:2
              column:1 columnspan:2
              padx:4 pady:4)}
{GL W 1 3 ne} {GL W 2 3 east}
{GL W 3 1 sw} {GL W 3 2 south} {GL W 3 3 sw}


%% Sticky Options
declare
W={New Tk.toplevel tkInit(bg:white)}
{Tk.send grid({New Tk.label tkInit(parent:W text:'Upper left')} 
              row:1    rowspan:2
              column:1 columnspan:2
              sticky: nse
              padx:4 pady:4)}
{GL W 1 3 ne} {GL W 2 3 east}
{GL W 3 1 sw} {GL W 3 2 south} {GL W 3 3 sw}


%% Weight Options
{Tk.batch [grid(rowconfigure    W 3 weight:1)
           grid(columnconfigure W 3 weight:1)]}



%%
%% Using Anchors for Widgets
%%

declare
[L1 L2 L3]={NewLabels}
{Tk.send pack(L1 L2 L3 fill:x)}
{L1 tk(configure anchor:w)} 
{L3 tk(configure anchor:e)}





%%%
%%% Chapter: More Widgets
%%%

%%
%% Buttons and Actions
%%

declare
W ={New Tk.toplevel tkInit}
B1={New Tk.button tkInit(parent: W 
                         text:   'Press me!'
                         action: proc {$}
                                    {Browse pressed}
                                 end)}
B2={New Tk.button tkInit(parent: W 
                         bitmap: error
                         action: W#tkClose)}
{Tk.send pack(B1 B2 fill:x padx:1#m pady:1#m)}

{B1 tkAction}
{B2 tkAction(action: B1 # tkClose)}

{W tkClose}



%%
%% Checkbuttons, Radiobuttons, and Variables
%%

declare
W ={New Tk.toplevel tkInit}
V1={New Tk.variable tkInit(false)}
C ={New Tk.checkbutton tkInit(parent:W variable:V1
                              text:'Bold' anchor:w)}
V2={New Tk.variable tkInit('Helvetica')}
Rs={Map ['Times' 'Helvetica' 'Courier']
    fun {$ F}
       {New Tk.radiobutton tkInit(parent:W 
                                  variable:V2 value:F
                                  text:F anchor:w)}
    end}
{Tk.batch [grid(C     padx:2#m columnspan:3)
           grid(b(Rs) padx:2#m)]}

{Browse state(bold:   {V1 tkReturnInt($)}==1
              family: {V2 tkReturnAtom($)})}

declare
fun {GetWeight}
   if {V1 tkReturnInt($)}==1 then bold else normal end
end
F={New Tk.font tkInit(size:24
                      family: {V2 tkReturn($)}
                      weight: {GetWeight})}
L={New Tk.label tkInit(parent:W text:'A test text.' font:F)}
{C  tkAction(action: proc {$}
                        {F tk(configure weight:{GetWeight})}
                        {L tk(configure font:F)}
                     end)}
{List.forAllInd ['Times' 'Helvetica' 'Courier']
 proc {$ I Family}
    {{Nth Rs I} tkAction(action: proc {$}
                                    {F tk(configure family:Family)}
                                    {L tk(configure font:F)}
                                 end)}
 end}
{Tk.send grid(L padx:2#m pady:2#m sticky:ew columnspan:3)}


{W tkClose}



%%
%% Menus, Menuitems and Menubuttons
%%

declare
W  ={New Tk.toplevel tkInit}
Cs =['Wheat' 'Firebrick' 'Navy' 'Darkorange']
M1 ={New Tk.menu tkInit(parent:W  tearoff:false)}
M2 ={New Tk.menu tkInit(parent:M1 tearoff:false)}
E1 ={New Tk.menuentry.cascade
     tkInit(parent:M1 label:'Background Color' menu:M2)}
E2 ={New Tk.menuentry.separator tkInit(parent:M1)}
E3 ={New Tk.menuentry.command
     tkInit(parent:M1 label:'Quit' action: W#tkClose)}
V  ={New Tk.variable tkInit(Cs.1)}
CEs={Map Cs fun {$ C}
               {New Tk.menuentry.radiobutton
                tkInit(parent:M2 label:C var:V val:C
                       action: W#tk(configure bg:C))}
            end}

{M1 tk(post 0 0)}



%%
%% Events
%%

{W tkBind(event:  '<Button-1>'
          args:   [int(x) int(y)]
          action: proc {$ X Y}
                     TX={Tk.returnInt winfo(rootx W)}
                     TY={Tk.returnInt winfo(rooty W)}
                  in
                     {Tk.send tk_popup(M1 X+TX Y+TY)}
                  end)}

{W tkBind(event:  '<1>' 
          append: true
          action: proc {$} {Browse pop} end)}

{W tkClose}



%%
%% More on Actions: Listeners
%%

declare
W ={New Tk.toplevel tkInit}
L ={New class $ from Tk.listener
            meth b1 {Browse b1} end
            meth b2 {Browse b2} end
         end tkInit}
B1={New Tk.button tkInit(parent:W text:'One' action: L#b1)}
B2={New Tk.button tkInit(parent:W text:'Two' action: L#b2)}
{Tk.send pack(B1 B2 side:left)}

{L tkServe(b1)}

{W tkClose}



%%
%% Entries and Focus
%%

declare
W={New Tk.toplevel tkInit}
L={New Tk.label tkInit(parent:W text:'File name:')}
E={New Tk.entry tkInit(parent:W width:20)}
{Tk.batch [pack(L E side:left pady:1#m padx:1#m)
           focus(E)]}

{Browse {E tkReturnAtom(get $)}}

{W tkClose}



%%
%% Scales
%%

declare
W ={New Tk.toplevel tkInit}
L ={New class $ from Tk.listener
           attr red:0 green:0 blue:0
           meth bg(C I)
              C := I {F tk(configure bg:c(@red @green @blue))}
           end
        end tkInit}
F ={New Tk.frame tkInit(parent:W height:2#c)}
Ss={Map [red green blue]
    fun {$ C}
       {New Tk.scale tkInit(parent:W orient:horizontal length:8#c
                            label:C 'from':0 to:255
                            action: L # bg(C)
                            args:   [int])}
    end}
{Tk.send pack(b(Ss) F fill:x)}

{W tkClose}



%%
%% Listboxes and Scrollbars
%%

declare
W={New Tk.toplevel tkInit}
L={New Tk.listbox tkInit(parent:W height:6)}
{L tkBind(event:  '<1>'
          action: proc {$}
                     I={L tkReturn(curselection $)}
                     C={L tkReturn(get(I) $)}
                  in
                     {L tk(configure bg:C)}
                  end)}
S={New Tk.scrollbar tkInit(parent:W)}
{ForAll [aliceblue         antiquewhite         aquamarine          
         azure             beige                bisque              
         black             blanchedalmond       blue                
         blueviolet        brown                burlywood           
         cadetblue         chartreuse           chocolate           
         coral             cornflowerblue       cornsilk            
         cyan              darkblue             darkcyan            
         darkgoldenrod     darkgray             darkgreen           
         darkgrey          darkkhaki            darkmagenta         
         darkolivegreen    darkorange           darkorchid          
         darkred           darksalmon           darkseagreen        
         darkslateblue     darkslategray        darkslategrey       
         darkturquoise     darkviolet           deeppink            
         deepskyblue       dimgray              dimgrey             
         dodgerblue        firebrick            floralwhite         
         forestgreen       gainsboro            ghostwhite          
         gold              goldenrod            gray                
         green             greenyellow          grey                
         honeydew          hotpink              indianred           
         ivory             khaki                lavender            
         lavenderblush     lawngreen            lemonchiffon        
         lightblue         lightcoral           lightcyan           
         lightgoldenrod    lightgoldenrodyellow lightgray           
         lightgreen        lightgrey            lightpink           
         lightsalmon       lightseagreen        lightskyblue        
         lightslateblue    lightslategray       lightslategrey      
         lightsteelblue    lightyellow          limegreen           
         linen             magenta              maroon              
         mediumaquamarine  mediumblue           mediumorchid        
         mediumpurple      mediumseagreen       mediumslateblue     
         mediumspringgreen mediumturquoise      mediumvioletred     
         midnightblue      mintcream            mistyrose           
         moccasin          navajowhite          navy                
         navyblue          oldlace              olivedrab           
         orange            orangered            orchid              
         palegoldenrod     palegreen            paleturquoise       
         palevioletred     papayawhip           peachpuff           
         peru              pink                 plum                
         powderblue        purple               red                 
         rosybrown         royalblue            saddlebrown         
         salmon            sandybrown           seagreen            
         seashell          sienna               skyblue             
         slateblue         slategray            slategrey           
         snow              springgreen          steelblue           
         tan               thistle              tomato              
         turquoise         violet               violetred           
         wheat             white                whitesmoke          
         yellow            yellowgreen]           
 proc {$ C}
    {L tk(insert 'end' C)}
 end}
{Tk.addYScrollbar L S}
{Tk.send pack(L S fill:y side:left)}

{W tkClose}



%%
%% Toplevel Widgets and Window Manager Commands
%%

declare
W={New Tk.toplevel tkInit(title:'Something different')}

{W tkClose}


declare
W={New Tk.toplevel tkInit(withdraw:true)}

{Tk.send wm(deiconify W)}

{W tkClose}



%%
%% Selecting Files
%%

case {Tk.return tk_getOpenFile}
of nil then skip
elseof S then {Browse file({String.toAtom S})}
end



%%
%% Example: Help Popups
%%

declare
local
   fun {MakePopup Parent Text}
      fun {$}
         [X Y H]={Map [rootx rooty height]
                  fun {$ WI}
                     {Tk.returnInt winfo(WI Parent)}
                  end}
         W={New Tk.toplevel tkInit(withdraw:true bg:black)}
         M={New Tk.message
            tkInit(parent:W text:Text bg:khaki aspect:400)}
      in
         {Tk.batch [wm(overrideredirect W true)
                    wm(geometry W '+'#X+10#'+'#Y+H)
                    pack(M padx:2 pady:2)
                    wm(deiconify W)]}
         W
      end
   end
   class HelpListener from Tk.listener
      attr
         cancel: unit
         popup:  unit
      meth init(parent:P text:T)
         popup := {MakePopup P T}
         Tk.listener,tkInit
      end
      meth enter
         C
      in
         cancel := C
         thread A={Alarm 1000} in
            {WaitOr C A}
            if {IsDet A} then W={@popup} in
               {Wait C} {W tkClose}
            end
         end
      end
      meth leave
         @cancel=unit
      end
   end
in
   proc {AttachHelp Widget Text}
      L={New HelpListener init(parent:Widget text:Text)}
   in
      {Widget tkBind(event:'<Enter>'  action:L#enter append:true)}
      {Widget tkBind(event:'<Leave>'  action:L#leave append:true)}
      {Widget tkBind(event:'<Button>' action:L#leave append:true)}
   end
end

declare 
W={New Tk.toplevel tkInit}
Bs={Map ['Okay'   # 'Do nothing meaningful.'
         'Cancel' # 'Do nothing at all.'
         'Quit'   # 'Close the window.']
    fun {$ Text # Help}
       B={New Tk.button tkInit(parent:W text:Text)}
    in
       {AttachHelp B Help} B
    end}
{Tk.send pack(b(Bs) side:left padx:2#m pady:2#m)}


{W tkClose}




%%%
%%% Chapter: Canvas Widgets
%%%

%%
%% Getting started
%%

declare
W={New Tk.toplevel tkInit}
C={New Tk.canvas tkInit(parent:W)}
{Tk.send pack(C)}
{C tk(create rectangle 10 10 1#c 1#c fill:red outline:blue)}


{W tkClose}



%%
%% Example: Drawing Bar Charts
%%

declare
local          
   O=if Tk.isColor then o(fill:wheat)
     else               o(stipple:gray50 fill:black)
     end
   D=10  D2=2*D B=10
in
   class BarCanvas from Tk.canvas
      meth DrawBars(Ys H X)
         case Ys of nil then skip
         [] Y|Yr then 
            {self tk(create rectangle X H X+D H-Y*D2 O)}
            {self tk(create text      X H+D text:Y anchor:w)}
            {self DrawBars(Yr H X+D2)}
         end
      end
      meth configure(SX SY)
         {self tk(configure scrollregion:q(B ~B SX+B SY+B))}
      end
      meth bars(Ys)
         WY=D2*({Length Ys}+1) HY=D2*({FoldL Ys Max 0}+1)
      in
         {self configure(WY HY)}
         {self DrawBars(Ys HY D)}
      end
   end
end

declare
W={New Tk.toplevel tkInit}
C={New BarCanvas    tkInit(parent:W bg:white width:300 height:120)}
H={New Tk.scrollbar tkInit(parent:W orient:horizontal)}
V={New Tk.scrollbar tkInit(parent:W orient:vertical)}
{Tk.addXScrollbar C H} {Tk.addYScrollbar C V}
{Tk.batch [grid(C row:0 column:0)
           grid(H row:1 column:0 sticky:we)
           grid(V row:0 column:1 sticky:ns)]}
{C bars([1 3 4 5 3 4 2 1 7 2 3 4 2 4 
         5 6 7 7 8 4 3 5 6 7 7 8 4 3])}



%%
%% Canvas Tags
%%

declare
W={New Tk.toplevel tkInit}
C={New Tk.canvas tkInit(parent:W)}
{Tk.send pack(C)}
R={New Tk.canvasTag tkInit(parent:C)}
{C tk(create rectangle 10 10 40 40 fill:red tags:R)}

{C tk(create oval 20 20 40 40 tags:R)}

{R tk(move 40 0)}

{W tkClose}


declare
W={New Tk.toplevel tkInit}
C={New Tk.canvas    tkInit(parent:W width:300 height:200 bg:white)}
R={New Tk.canvasTag tkInit(parent:C)}
O={New Tk.canvasTag tkInit(parent:C)}
{C tkBind(event:  '<1>' 
          args:   [int(x) int(y)]
          action: proc {$ X Y}
                     {C tk(create rectangle X-10 Y-10 X+10 Y+10
                           tags:R fill:steelblue)}
                  end)}
{C tkBind(event:  '<2>' 
          args:   [int(x) int(y)]
          action: proc {$ X Y}
                     {C tk(create oval X-10 Y-10 X+10 Y+10
                           tags:O fill:orange)}
                  end)}
{Tk.send pack(C)}

{R tk(itemconfigure fill:wheat)}
{O tk(itemconfigure fill:blue)}

{O tk(delete)}

declare
Colors={New class $ from BaseObject
               attr cs:(Cs=red|green|blue|yellow|orange|Cs 
                           in 
                        Cs)
               meth get(?C) 
                  Cr in C|Cr = (cs := Cr) 
               end
            end noop}
{O tkBind(event:  '<3>' 
          action: proc {$}
                     {O tk(itemconfigure 
                           fill:{Colors get($)})}
                  end)}




%%
%% Example: An Animated Time Waster
%%

declare
local
   fun {RandCoord} {OS.rand} mod 20 + 15 end
in
   class RandMag from Tk.canvasTag
      meth init(parent:P done:D stopped:S)
         {self tkInit(parent:P)}
         {P tk(create bitmap 0 0
                  bitmap:'@'#{Property.get 'oz.home'}#
                      '/doc/wp/magnifier.xbm'
                  tags:self foreground:blue)}
         thread {self move(D S)} end
      end
      meth move(D S)
         {WaitOr {Alarm 400} D}
         if {IsDet D} then S=unit else
            {self tk(coords {RandCoord} {RandCoord})}
            {self move(D S)}
         end
      end
   end
end

declare
proc {WaitDone Done}
   W={New Tk.toplevel tkInit(withdraw:true)}
   L={New Tk.label    tkInit(parent:W text:'Computing...')}
   C={New Tk.canvas   tkInit(parent:W width:50 height:50)}
   Stopped
in
   {Tk.batch [wm(overrideredirect W true)
              pack(L C side:left pady:2#m padx:2#m)
              wm(deiconify W)]}
   _={New RandMag init(parent:C done:Done stopped:Stopped)}
   thread {Wait Stopped} {W tkClose} end
end


declare Done
{WaitDone Done}

Done=unit




%%%
%%% Chapter: Text Widgets
%%%

%%
%% Inserting Text
%%

declare
W={New Tk.toplevel tkInit}
T={New Tk.text tkInit(parent:W width:28 height:5 bg:white)}
{T tk(insert 'end' "The quick brown fox jumps over the lazy dog.")}
{Tk.send pack(T)}

{T tk(configure wrap:word)}

{Browse {T tkReturnAtom(get p(1 4) p(1 9) $)}}

{T tk(insert p(1 4) "very very ")}

{T tk(delete p(1 4) p(1 14))}

{T tk(configure state:disabled)}


{W tkClose}



%%
%% Text Tags
%%

declare
W={New Tk.toplevel tkInit}
T={New Tk.text tkInit(parent:W width:28 height:5 bg:white)}
{T tk(insert 'end' "The quick brown fox jumps over the lazy dog.")}
{Tk.send pack(T)}

declare
B={New Tk.textTag tkInit(parent:T foreground:brown)}

{B tk(add p(1 10) p(1 15))}

{B tk(configure font:{New Tk.font tkInit(size:18)})}

{T tk(insert 'end' "\nDogs are ")}
{T tk(insert 'end' "brown" B)}
{T tk(insert 'end' " as well.")}


{W tkClose}



%%
%% Example: A ToyText Browser
%%

declare
proc {ToyBrowse ToyText Root}
   W={New Tk.toplevel tkInit}
   T={New Tk.text tkInit(parent:W width:40 height:8 bg:white wrap:word)}
   local
      HF={New Tk.font    tkInit(family:helvetica size:18 weight:bold)}
      HT={New Tk.textTag tkInit(parent:T font:HF foreground:orange)}
   in
      proc {Head E Rs}
         {T tk(insert p(0 0) E#'\n' HT)}
         {HT tkBind(event:  '<1>'
                    action: proc {$} {Display Rs} end)}
      end
   end
   local
      BF={New Tk.font    tkInit(family:helvetica size:12 weight:normal)}
      BT={New Tk.textTag tkInit(parent:T font:BF)}
      proc {Do Es CT Rs}
         case Es of nil then skip
         [] E|Er then
            case E
            of a(ref:R Es) then
               RT={New Tk.textTag tkInit(parent:T font:BF
                                         foreground:blue underline:true)}
            in
               {RT tkBind(event: '<1>'
                          action: proc {$} {Display R|Rs} end)}
               {Do Es RT Rs}
            else
               {T tk(insert 'end' E CT)}
            end
            {Do Er CT Rs}
         end
      end
   in
      proc {Body Es Rs}
         {Do Es BT Rs}
      end
   end
   proc {Display Rs}
      case Rs of nil then skip
      [] R|Rr then
        {T tk(delete p(0 0) 'end')}
        {Head ToyText.R.head Rr} {Body ToyText.R.body Rs}
      end      
   end
in
   {Tk.send pack(T)}
   {Display [Root]}
end
{ToyBrowse hyper(canvas:        
                    e(head:'Canvas'
                      body:['A canvas widget displays items. '
                            'An item is of one the following types: '
                            a(ref:arc       ['arc']) ', '
                            a(ref:bitmap    ['bitmap']) ', '
                            a(ref:image     ['image']) ', '
                            a(ref:line      ['line']) ', '
                            a(ref:oval      ['oval']) ', '
                            a(ref:polygon   ['polygon']) ', '
                            a(ref:rectangle ['rectangle']) ', '
                            a(ref:text      ['text']) ', and '
                            a(ref:window    ['window']) '.'])
                 arc:
                    e(head:'Arc'
                      body:['An arc item displays a piece of a ' 
                            'circle.'])
                 bitmap:
                    e(head:'Bitmap'
                      body:['A bitmap item displays a bitmap '
                            'with a given name.'])
                 image:
                    e(head:'Image'
                      body:['Displays an image.'])
                 line:
                    e(head:'Line'
                      body:['A line item consists of several '
                            'connected segments.'])
                 oval:
                    e(head:'Oval'
                      body:['An oval can either be a circle or '
                            'an ellipsis.'])
                 polygon:
                    e(head:'Polygon'
                      body:['A polygon is described by three or '
                            'more ' a(ref:line ['line']) 
                            ' segments.'])
                 rectangle:
                    e(head:'Rectangle'
                      body:['Displays a rectangle.'])
                 text:
                    e(head:'Text'
                      body:['Displays text consisting of a single '
                            'or several lines.'])
                 window:
                    e(head:'Window'
                      body:['Displays a widget in the canvas where '
                            'the canvas widget serves as geometry '
                            'manager for the widget. '
                            'See also ' 
                            a(ref:canvas ['the canvas widget']) '.'])) canvas}





%%%
%%% Chapter: Tools for Tk
%%%

%%
%% Dialogs
%%

declare
D={New TkTools.dialog
   tkInit(title:   'Remove File'
          buttons: ['Okay' #
                    proc {$}
                       try
                          {OS.unlink {E tkReturn(get $)}}
                          {D tkClose}
                       catch _ then skip
                       end
                    end
                    'Cancel' # tkClose]
          default: 1)}
L={New Tk.label tkInit(parent:D text:'File name:')}
E={New Tk.entry tkInit(parent:D bg:wheat width:20)}
{Tk.batch [pack(L E side:left pady:2#m) focus(E)]}



%%
%% Error Dialogs
%%

declare
W={New Tk.toplevel tkInit}
E={New TkTools.error
   tkInit(master:W
          text: 'Error in system configuration: '#
                'too much memory.')}



%%
%% Menubars
%%

declare
W={New Tk.toplevel tkInit}
V={New Tk.variable tkInit(0)}
B={TkTools.menubar W W
   [menubutton(text:'Test' underline:0
               menu: [command(label:   'About test'
                              action:  Browse#about
                              key:     alt(a)
                              feature: about)
                      separator
                      command(label:   'Quit'
                              action:  W#tkClose
                              key:     ctrl(c)
                              feature: quit)]
                      feature: test)
    menubutton(text:'Options' underline:0
               menu: [checkbutton(label: 'Incremental'
                                  var: {New Tk.variable tkInit(false)})
                      separator
                      cascade(label: 'Size'
                              menu: [radiobutton(label:'Small'
                                                 var:V value:0)
                                     radiobutton(label:'Middle'
                                                 var:V value:1)
                                     radiobutton(label:'Large'
                                                 var:V value: 2)])])]
   nil}
F={New Tk.frame tkInit(parent:W width:10#c height:5#c bg:ivory)}
{Tk.send pack(B F fill:x)}

{B.test.about tk(entryconfigure state:disabled)}

{B.test.menu tk(configure tearoff:false)}


declare
A={New Tk.menuentry.command tkInit(parent:B.test.menu
                                   before:B.test.quit
                                   label: 'Exit')}

{A tkClose}



%%
%% Images
%%

declare
U='http://www.mozart-oz.org/home-1.1.0/doc/wp/'
I={TkTools.images [U#'wp.gif' 
                   U#'queen.xbm' 
                   U#'truck-left.ppm']}




