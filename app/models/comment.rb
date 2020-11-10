class Comment < ApplicationRecord
  belongs_to :Contributions
  belongs_to :Users
end
