class Listing < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x200", :thumb => "150x150" }, :default_url => "missing.jpg"
	validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png) 
end
