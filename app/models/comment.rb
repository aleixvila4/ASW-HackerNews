class Comment < ApplicationRecord
  belongs_to :contribution, optional: true
  belongs_to :user, optional: true
end
