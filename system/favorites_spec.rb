require 'rails_helper'
RSpec.describe "お気に入り機能" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:third_user) { FactoryBot.create(:third_user) }
  let!(:blog) { FactoryBot.create(:blog, user_id: user.id) }
  let!(:second_blog) { FactoryBot.create(:second_blog, user_id: second_user.id) }
  let!(:third_blog) { FactoryBot.create(:third_blog, user_id: third_user.id) }
  let!(:favorite) { Favorite.create(user_id: user.id, blog_id: second_blog.id) }

  describe '評価項目' do
    before do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"
    end
    it 'お気に入り登録と解除するリンクにあらかじめ設定されているHTMLのclass属性を削除しないこと' do
      expect(page).to have_css ".delete-#{second_blog.id}"
      expect(page).to have_css ".post-#{third_blog.id}"
    end
    it 'スターアイコンをクリックした際、お気に入りに登録できること' do
      expect(Favorite.all.count).to eq 1
      find(".post-#{third_blog.id}").click
      sleep 1
      expect(Favorite.all.count).to eq 2
    end
    it 'スターアイコンをクリックした際、お気に入りを解除できること' do
      expect(Favorite.all.count).to eq 1
      find(".delete-#{second_blog.id}").click
      sleep 1
      expect(Favorite.all.count).to eq 0
    end
    it '星マークの横にある数字が正しく増減すること' do
      click_on "Logout"
      fill_in "Email", with: third_user.email
      fill_in "Password", with: third_user.password
      click_on "Log in"
      expect(page).to have_content '0'
      expect(page).to have_content '1'
      find(".post-#{second_blog.id}").click
      expect(page).to have_content '2'
      expect(page).to have_content '0'
      expect(page).not_to have_content '1'
    end
  end
end
