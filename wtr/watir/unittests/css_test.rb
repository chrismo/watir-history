#
#
#  test file for css
#
# revision: $Revision: 1.2 $

require '../watir'

require 'test/unit'
require 'test/unit/ui/console/testrunner'

require 'testUnitAddons'
$myDir = Dir.getwd




class TC_CSS < Test::Unit::TestCase

    def divTester( message )

       divs = $ie.getIE.document.getElementsByTagName("DIV")
       puts "Found #{divs.length} div tags"
       divs.each do |d|
           puts "Checking div #{d.id}"
           puts "div #{d.invoke("id") } style is #{d.invoke("className")  	}"
       end
    end

    def isMessageDisplayed(message)

       s = false
       divs = $ie.getIE.document.getElementsByTagName("DIV")
       #puts "Found #{divs.length} div tags"
       divs.each do |d|
           #puts "----Checking div #{d.id} innertext is ( #{d.innerText}  )"
          
           if d.innerText.to_s.downcase.match( /#{message}/i )

               #puts "div #{d.invoke("id") } style is #{d.invoke("className")  	}"
               if d.invoke("className").to_s.downcase.match(/show/i)
                   puts "message is shown!!!"
                   s = true
               end

           end
       end

       puts "Not Shown " if s== false
       return s

    end



    def gotoCSSPage()
        $ie.goto("file://#{$myDir}/html/cssTest.html")

    end



    def test_SuccessMessage

        gotoCSSPage()
        $ie.button( :caption , "Success").click

        #isMessageDisplayed( "Success" )
        #divTester( "Success" )
        assert( isMessageDisplayed("Success") )


        $ie.button( :caption , "Failure").click

        assert_false(isMessageDisplayed("Success") )


    end



end

$ie = IE.new
