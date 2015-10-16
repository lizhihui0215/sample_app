class Micropost < ActiveRecord::Base
  belongs_to :user
  # introduces the “stabby lambda” syntax for an object called a Proc
  #  (procedure) or lambda, which is an anonymous function (a function created
  # without a name). The stabby lambda -> takes in a block (Section 4.3.2) and
  #  returns a Proc, which can then be evaluated with the call method. We can
  #  see how it works at the console:
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length:{ maximum: 140 }
  validate :picture_size

  private
    # Validates the size of an uploaded pitcure.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
