require 'win32ole'

class IEDomViewer
  def initialize(aIEController, verbose=false)
    @verbose = verbose
    @iec = aIEController
    @rootNodeWrapper = DomNodeWrapper.new(@iec.htmlNode, 'HTML')
    buildNodeWrapperTree(@rootNodeWrapper)
  end

  def outputDom
    dumpWrapperNode(@rootNodeWrapper, "-")
  end

  def buildNodeWrapperTree(rootNodeWrapper)
    rootNodeWrapper.node.childNodes.length.times do |i|
      nodeWrapper = rootNodeWrapper.addChild(rootNodeWrapper.node.childNodes(i))
      if @verbose
        print '.'
        $stdout.flush
      end
      buildNodeWrapperTree(nodeWrapper)
    end
  end

  def dumpWrapperNode(aNode, path)
    p 'nodeName: ' + path + aNode.name
    p 'nodeValue: ' + aNode.node.nodeValue if !aNode.node.nodeValue.nil?
    # p 'outerText: ' + aNode.outerText if !aNode.outerText.nil?
    aNode.childArray.each do | childNodeWrapper |
      dumpWrapperNode(childNodeWrapper, path + aNode.name + "-")
    end
  end

  def getNodeWrapperFromPath(path)
    pathParts = path.split('-')
    pathParts.delete_at(0) if pathParts[0] == 'HTML'
    nodeWrapper = @rootNodeWrapper
    pathParts.each do | nodeWrapperName |
      nodeWrapper.childArray.each do | childNodeWrapper |
        if childNodeWrapper.name == nodeWrapperName
          nodeWrapper = childNodeWrapper
          break
        end
      end
    end
    return nodeWrapper
  end
end

class IEController
  attr_reader :ie

  READYSTATE_COMPLETE = 4

  def initialize
    @ie = WIN32OLE.new('InternetExplorer.Application')
  end

  def navigate(href)
    @ie.navigate(href)
    waitForIE
  end

  def htmlNode
    @ie.document.childNodes.length.times do |i|
      if @ie.document.childNodes(i).nodeName == 'HTML'
        return @ie.document.childNodes(i)
        break
      end
    end
  end

  def waitForIE
    # busy seems to return control too soon, but going
    # direct to another check of readyState is too fast,
    # browser can still be in READYSTATE_COMPLETE
    while @ie.busy
    end

    until @ie.readyState == READYSTATE_COMPLETE
    end
  end
end

class DomNodeWrapper
  attr_accessor :name
  attr_reader :node, :childArray

  def initialize(aNode, name = '')
    @node = aNode
    @name = name
    @childArray = Array.new
  end

  def addChild(childNode)
    newWrapperNode = DomNodeWrapper.new(childNode, getChildName(childNode))
    @childArray << newWrapperNode
    newWrapperNode
  end

  def getChildName(childNode)
    inc = 1
    @childArray.each do | childNodeWrapper |
      inc = inc + 1 if childNodeWrapper.node.nodeName == childNode.nodeName
    end
    return childNode.nodeName + inc.to_s
  end
end

