# Ruby-Trace 
# Brian Marick, marick@visibleworkings.com, www.visibleworkings.com
# $Revision: 1.1 $ ($Tag$) of $Date: 2004/06/22 19:56:34 $
# Copyright (C) 2001 by Brian Marick. See LICENSE.txt in the root directory.

# Load this, and you get ruby-trace plus a method on Object that 
# sends debugging-themed output to stdout.

require 'ruby-trace/all'
require 'ruby-trace/start/method-defmethod'

class Object
  @@trace = Trace::Connector.debugging_printer
end


