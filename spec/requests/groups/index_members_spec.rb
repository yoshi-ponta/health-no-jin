require "rails_helper"

RSpec.describe "Groups#index members", type: :request do
  it "在籍中のメンバーが一覧に表示される" do
    owner = User.create!(email: "owner@example.com", password: "password")
    group = Group.create!(name: "testgroup", owner_id: owner.id)
    GroupMembership.create!(group: group, user: owner, joined_at: Time.current, left_at: nil)

    member = User.create!(email: "member@example.com", password: "password")
    GroupMembership.create!(group: group, user: member, joined_at: Time.current, left_at: nil)

    post user_session_path, params: { user: { email: owner.email, password: "password" } }
    follow_redirect!
    get groups_path

    expect(response.body).to include(member.email)
  end
end
