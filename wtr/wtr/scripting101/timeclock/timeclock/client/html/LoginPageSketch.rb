require 'timeclock/util/ruby-extensions'
require 'timeclock/client/html/PageSketch'

module Timeclock
  module Client
    module Html

      class LoginPageSketch < PageSketch

        def initialize
          super 'Timeclock Login Page'
        end

        def body_guts
          [p("Welcome to Timeclock. Please log in by typing your name and
              striking Enter/Return."),
            form({:method => 'get',
                   :action => "login"},
                 input({:type => 'text',
                         :name => 'name',
                         :value => '',
                         :size => '20',
                         :maxlength => '100'})),
            p("If you have never logged in before, simply type
               in a name and an account will be created for you."),
            p("(There are no passwords in this program because it's
               just a demo.)")]

        end
      end
    end
  end
end
