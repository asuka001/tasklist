class Task < ApplicationRecord
  validates :content, precense: true, length: { maximum:255 }
  
end
