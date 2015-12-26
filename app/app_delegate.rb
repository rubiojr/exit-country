class AppDelegate
  attr_accessor :status_menu

  def applicationDidFinishLaunching(notification)
    @app_name = NSBundle.mainBundle.infoDictionary['CFBundleDisplayName']

    @status_menu = NSMenu.new

    @status_image = NSImage.imageNamed "es.png"

    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).init
    #@status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSSquareStatusItemLength).init
    @status_item.setMenu(@status_menu)
    @status_item.setHighlightMode(true)
    #@status_item.setTitle(@app_name)
    #@status_item.setImage @status_image
    @status_menu.addItem createMenuItem("About #{@app_name}", 'orderFrontStandardAboutPanel:')
    @status_menu.addItem createMenuItem("Quit", 'terminate:')

    @countryDetector = CountryDetector.new.start
    NSNotificationCenter.defaultCenter.addObserver self,
      selector:'locationRetrieved:',
      name:CountryDetector::LocationRetrievedNotification,
      object:nil
  end

  def locationRetrieved(notification)
    detector = notification.object
    details = detector.result.split(',')
    return unless details[1]
    setFlag "#{details[1].downcase}.png"
    #@countryDetails = createMenuItem(details[2], 'pressAction')
    if @countryDetails
      @countryDetails.title = details[2]
    else
      @countryDetails = NSMenuItem.alloc.initWithTitle(details[2],
                                                       action: nil,
                                                       keyEquivalent: '')
      @status_menu.addItem @countryDetails
    end
    if @ipDetails
      @ipDetails.title = details[0]
    else
      @ipDetails = NSMenuItem.alloc.initWithTitle(details[0],
                                                  action: nil,
                                                  keyEquivalent: '')
      @status_menu.addItem @ipDetails
    end
  end

  def setFlag(img)
    @status_item.button.image = NSImage.imageNamed(img)
  end

  def createMenuItem(name, action)
    NSMenuItem.alloc.initWithTitle(name, action: action, keyEquivalent: '')
  end

  def pressAction
    alert = NSAlert.alloc.init
    alert.setMessageText "Action triggered from status bar menu"
    alert.addButtonWithTitle "OK"
    alert.runModal
  end
end
