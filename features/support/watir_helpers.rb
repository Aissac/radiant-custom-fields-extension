module WatirHelpers
  Watir::Browser.default = "firefox"
  
  def browser
    @browser ||= Watir::Browser.new
  end
  
  def h(x)
    ERB::Util.h(x)
  end
end

World(WatirHelpers)
