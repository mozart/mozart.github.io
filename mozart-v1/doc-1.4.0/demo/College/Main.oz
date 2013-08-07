%%%
%%% Authors:
%%%   Joerg Wuertz (wuertz@dfki.de)
%%%
%%% Contributors:
%%%   Tobias Mueller (tmueller@ps.uni-sb.de)
%%%
%%% Copyright:
%%%   Joerg Wuertz, 1996
%%%   Tobias Mueller, 1998
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

%%%
%%% Load the application
%%%

\define ALONEDEMO

functor

export

   ControllerLabel
   
import

   Controller(controller: TheController)
   
define

   ControllerLabel = {TheController}
end
