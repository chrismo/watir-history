# Ruby-Trace 
# Brian Marick, marick@visibleworkings.com, www.visibleworkings.com
# $Revision: 1.1 $ ($Tag$) of $Date: 2004/06/22 19:56:34 $
# Copyright (C) 2001 by Brian Marick. See LICENSE.txt in the root directory.

# Define methods on object. Someone else must initialize Object.@@trace.

require 'ruby-trace/all'

class Object

  def trace
    @@trace
  end

  def trace=(val)
    @@trace=val
  end
end


