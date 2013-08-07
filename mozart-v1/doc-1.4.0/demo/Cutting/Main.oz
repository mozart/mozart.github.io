%%%
%%% Authors:
%%%   Christian Schulte <schulte@ps.uni-sb.de>
%%%
%%% Copyright:
%%%   Christian Schulte, 1998
%%%
%%% Last change:
%%%   $Date: 1999-01-21 11:01:50 +0100 (Thu, 21 Jan 1999) $ by $Author: schulte $
%%%   $Revision: 10566 $
%%%
%%% This file is part of Mozart, an implementation
%%% of Oz 3
%%%    http://www.mozart-oz.org
%%%
%%% See the file "LICENSE" or
%%%    http://www.mozart-oz.org/LICENSE.html
%%% for information on usage and redistribution
%%% of this file, and for a DISCLAIMER OF ALL
%%% WARRANTIES.
%%%

functor

import
   Tk TkTools

   Edit(page)
   Compute(page)
   Application(exit)
   
   
define
   
   T = {New Tk.toplevel      tkInit(title:    'Glass Plates'
				    delete:   Application.exit # 0
				    withdraw: true)}
   B = {New TkTools.notebook tkInit(parent: T)}
   
   E = {New Edit.page        init(parent:  B
				  compute: C)}
   C = {New Compute.page     init(parent: B
				  edit:   E)}
   
in
   
   {B add(E)} {B add(C)}
   
   {Tk.batch [pack(B)
	      update(idletasks)
	      wm(deiconify T)
	      wm(resizable T false false)]}

end


