
# tests for Links
# revision: $Revision: 1.3 $

require '../watir'

require 'test/unit'
require 'test/unit/ui/console/testrunner'

require 'testUnitAddons'

$myDir = Dir.getwd



class TC_Links < Test::Unit::TestCase


    def gotoLinksPage()
        $ie.goto("file://#{$myDir}/html/links1.html")
    end

    

   

    def test_Link_Exists
       gotoLinksPage()
       assert($ie.link(:text, "test1").exists?)   
       assert_false($ie.link(:text, "missing").exists?)   

       assert($ie.link(:url, "link_pass.html").exists?)   
       assert_false($ie.link(:url, "alsomissing.html").exists?)   

    end


    def test_Link_click

       gotoLinksPage()

        $ie.link(:text, "test1").click
        assert( $ie.pageContainsText("Links2-Pass") ) 

       gotoLinksPage()

        $ie.link(:url, "link_pass.html").click
        assert( $ie.pageContainsText("Links3-Pass") ) 

       gotoLinksPage()

        $ie.link(:index, 1).click
        assert( $ie.pageContainsText("Links2-Pass") ) 

       gotoLinksPage()

        
        assert_raises(UnknownObjectException  , "UnknownObjectException  was supposed to be thrown" ) {   $ie.link(:index, 199).click }  




    end




end

$ie = IE.new