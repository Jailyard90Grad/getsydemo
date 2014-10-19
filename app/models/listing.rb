class Listing < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_items

	belongs_to :user

	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "300x200", :thumb => "150x150" }, :default_url => "missing.jpg"
	else
		has_attached_file :image, :styles => { :medium => "300x200", :thumb => "150x150" }, :default_url => "missing.jpg",
			:storage => :dropbox,
			:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
			:path => ":style/:id_:filename"
	end
	validates_attachment_presence :image
	validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png)
	validates :name, :description, :price, presence: true
	validates :price, numericality: { greater_than: 0.01 }


	private

		#ensure that there are no line items referencing this listing
		def ensure_not_referenced_by_any_line_items
			if line_items.empty?
				return true
			else
				errors.add(:base, 'Line Items present')
				return false
			end
		end
end
