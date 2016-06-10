Rails.application.routes.draw do

  get("/", { :controller => "meetpoint", :action => "enter_addresses" })
  get("/your_meetpoint", { :controller => "meetpoint", :action => "your_meetpoint" })

end
