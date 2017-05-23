%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% File:
%%    $RCSfile: README.txt,v $
%% Author:
%%    Sameh El-Ansary (sameh@sics.se)
%% Last Updated:
%%    $Date: 2004/03/02 14:25:33 $ by $Author: sameh $
%% CVS Revision:
%%    $Revision: 1.4 $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

OzSqlite is an Oz interface to sqlite.
Sqlite is a lightweight embeddable sql database engine.


###########################################
I- Building & Installing & Testing OzSqlite
###########################################

This process assumes that you have ozmake installed on your system.


Step 1: Building libsqlite.a
----------------------------
   [a] > cd libsqlite
   [b] In the Makefile uncoment the proper branch for windows or unix.
       Cygwin is assumed on windows
   [c] > make

Step2: Building the ozsqlite builtin and wrapper functor
--------------------------------------------------------
   [d] > cd ..
   [e] > ozmake --build -L ./libsqlite
   

Step 3: Installing ozsqlite 
--------------------------------------
   [f] > ozmake --install


###########################################
II - Simple Usage
###########################################
functor
import
    Sqlite at 'x-ozlib:/sqlite/Sqlite.ozf'
    System(showInfo:ShowInfo)
define
   try
      %%open a database (create if does not exist) 
      DB = {Sqlite.open 'demo.db'}
      R 
   in          
      %%execture arbitrary sql query, e.g. creating a table
      _={Sqlite.exec DB "create table people (name, score);"}
      
      %% insert records
      {Sqlite.insert DB "people" r(name:"sameh" score:"50")}
      {Sqlite.insert DB "people" r(name:"mahmoud" score:70)}
      
      %% Execute a query
      R = {Sqlite.exec DB "select * from people"}
      
      %% Show the result in the emulator
      {Sqlite.showResult R}
      
      %% Save it in .csv file
      {Sqlite.saveResult R "all.csv"}
      
      %% Close the db
      {Sqlite.close DB}
   catch error('Sqlite'(Err Msg) debug:_) then
      {ShowInfo "Sqlite: "#Err#": "#Msg}	
   end
end

% In fact all what you need is "open", "exec" and "close" to do everything.
% there are however some additional incomplete api for people who want
% to avoid writing sql statements which includes :
% -"insert"   
%    e.g. : {Sqlite.insert DB "people" r(name:"sameh" score:"50")}
% - "select" 
%    e.g. : {Sqlite.select DB "people" [name score] [score#gt("50") score#leq("500.0")] }
% - "delete"
%    e.g. : {Sqlite.delete DB "people" [score#leq(50)]}
%
%   Please take a look at demo.oz to see how they are used.

   

###########################################
III - Sqlite info
###########################################
* Look at http://www.sqlite.org for more info on sqlite
* Recommended GUIs
   - for Windows: sqlite control center at http://bobmanc.home.comcast.net/sqlitecc.html
* You can also browse and query your db files using sqlite.exe found in the libsqlite subdir

