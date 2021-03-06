FactoryBot.define do
  factory :orange, class: Micropost do
    content { 'I just ate an orange!' }
    created_at { 10.minutes.ago }
  end
  
  factory :micropost, class: Micropost do
    content { "hello, it's micropost!" }
    created_at { 10.minutes.ago }
  end
 
  factory :most_recent, class: Micropost do
    content { 'Writing a short test' }
    created_at { Time.zone.now }
    user { association :user, email: 'recent@example.com' }
  end

  factory :post_by_user, class: Micropost do
    content { 'Posted by User' }
    created_at { Time.zone.now }
    user
  end
   
  factory :post_by_archer, class: Micropost do
    content { 'Posted by Archer' }
    created_at { Time.zone.now }
    user factory: :archer
  end
end