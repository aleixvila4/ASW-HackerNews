class Reply < ApplicationRecord
  belongs_to :Comments, optional: true
  belongs_to :Users, optional: true
end
