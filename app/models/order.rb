class Order < ActiveRecord::Base
  include AASM
  
  aasm column: :state do
    state :pending, initial: true
    state :in_progress , :completed

    event :progress do
      transitions from: :pending, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end
  end  
  
##  
# enum state: { 
#   pending: 'Pending',
#   in_progress: 'In Progress',
#   completed: 'Completed'
#  }
##
end