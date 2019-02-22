#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'
   
PAGE_URL = ARGV[0].to_s

IMG_URL = ARGV[1].to_s

JAVASCRIPT_URL = ARGV[2].to_s

CSS_URL = ARGV[3].to_s

VERSION = ARGV[4].to_s

# PAGE_URL = "https://s3-ap-southeast-1.amazonaws.com/yoose-tmp/Banner_for_v4/TheCoffeeHouse_1/flashing_creatives_base.html"

# IMG_URL = "https://s3-ap-southeast-1.amazonaws.com/tuan.vu.yoose/The_Coffee_House/static_html/banner003_300x250px_22jan.jpg"

#get the page, parse it
page = Nokogiri::HTML(open(PAGE_URL))

puts PAGE_URL

#get the image tag img
img = page.css('img')
img[0]["src"] = IMG_URL

#link to css
style = page.css('link')
style[0]["href"] = CSS_URL

#link to the Javascript
script  = page.css('script')
script[1]["src"]= JAVASCRIPT_URL

# Open the script file, read and store it in the last script tag

tracking_script = ""

fi = File.open("v4_tracking.js", "r")
fi.each_line do |line|
	tracking_script = tracking_script + line  		
end
# puts tracking_script
fi.close

#add the tracking script in
V4_tracking_script = Nokogiri::XML::Node.new "script", page
V4_tracking_script["id"] = "tracking_script"
V4_tracking_script.content = tracking_script
script.last.add_next_sibling(V4_tracking_script)

# script.last.add_next_sibling "<script>" + tracking_script + "</script>"

#puts script

puts page.to_html

f = File.new('after_processed' + VERSION + '.html', 'w')
f.write(page.to_html)
f.close    

ARGV.each do|a|
  #puts "Argument: #{a}"
end




