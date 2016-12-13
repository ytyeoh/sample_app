class Picture < ActiveRecord::Base
  belongs_to :listing
  has_attached_file :image,
    :styles => {
        :thumb => "100x100#",
        :small  => "150x150>",
        :medium => "200x200" }
  do_not_validate_attachment_file_type :image

end