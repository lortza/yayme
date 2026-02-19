# frozen_string_literal: true

# == Schema Information
#
# Table name: post_types
#
#  id                   :bigint           not null, primary key
#  description_template :text
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_post_types_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe PostType, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:posts) }
  end

  describe "a valid post_type" do
    context "when has valid params" do
      it "is valid" do
        expect(post_type).to be_valid
      end

      it { should validate_presence_of(:name) }
      it { should_not validate_presence_of(:description_template) }

      let!(:post_type) { create(:post_type) }
      it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    end
  end
end
