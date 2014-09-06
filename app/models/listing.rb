class Listing < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x200", :thumb => "150x150" }, :default_url => "missing.jpg",
		:storage => :dropbox,
		:dropbox_credentials => Rails.root.join("config/dropbox.yml")
	validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png) 
end
