class Order < ActiveRecord::Base
  enum state: { 
    pending: 'Pending',
    in_progress: 'In Progress',
    completed: 'Completed'
  }
end