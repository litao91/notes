SHOES_APP = File.expand_path(__FILE__)
require 'shoes'
Shoes.app do
    @time = title "0:00"
    every l do
        @time.replace(Time.now.strftime("%I:%M %p"))
    end
end

