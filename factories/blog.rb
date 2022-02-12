FactoryBot.define do
  factory :blog do
    title { 'blog_title' }
    description { 'blog_description' }
  end

  factory :second_blog, class: Blog do
    title { 'second_blog_title' }
    description { 'second_blog_description' }
  end

  factory :third_blog, class: Blog do
    title { 'third_blog_title' }
    description { 'third_blog_description' }
  end
end
