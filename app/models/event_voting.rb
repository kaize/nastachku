class EventVoting < Voting
  belongs_to :voteable, polymorphic: true, counter_cache: true, touch: true
end
