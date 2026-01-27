# frozen_string_literal: true

require "rails_helper"

RSpec.describe PostPolicy do
  let(:owner) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:other_user) { create(:user) }
  let(:post_type) { create(:post_type, user: owner) }
  let(:post) { create(:post, post_type: post_type) }

  describe "#create?" do
    context "when user is present" do
      it "grants access" do
        policy = PostPolicy.new(owner, Post.new)
        expect(policy.create?).to be true
      end
    end

    context "when user is nil" do
      it "denies access" do
        policy = PostPolicy.new(nil, Post.new)
        expect(policy.create?).to be_falsey
      end
    end
  end

  describe "#show?" do
    context "when user is the post owner" do
      it "grants access" do
        policy = PostPolicy.new(owner, post)
        expect(policy.show?).to be true
      end
    end

    context "when user is an admin" do
      it "grants access" do
        policy = PostPolicy.new(admin, post)
        expect(policy.show?).to be true
      end
    end

    context "when user is not the owner" do
      it "denies access" do
        policy = PostPolicy.new(other_user, post)
        expect(policy.show?).to be false
      end
    end

    context "when user is nil" do
      it "denies access" do
        policy = PostPolicy.new(nil, post)
        expect(policy.show?).to be_falsey
      end
    end
  end

  describe "#edit?" do
    context "when user is the post owner" do
      it "grants access" do
        policy = PostPolicy.new(owner, post)
        expect(policy.edit?).to be true
      end
    end

    context "when user is an admin" do
      it "grants access" do
        policy = PostPolicy.new(admin, post)
        expect(policy.edit?).to be true
      end
    end

    context "when user is not the owner" do
      it "denies access" do
        policy = PostPolicy.new(other_user, post)
        expect(policy.edit?).to be false
      end
    end

    context "when user is nil" do
      it "denies access" do
        policy = PostPolicy.new(nil, post)
        expect(policy.edit?).to be_falsey
      end
    end
  end

  describe "#update?" do
    context "when user is the post owner" do
      it "grants access" do
        policy = PostPolicy.new(owner, post)
        expect(policy.update?).to be true
      end
    end

    context "when user is an admin" do
      it "grants access" do
        policy = PostPolicy.new(admin, post)
        expect(policy.update?).to be true
      end
    end

    context "when user is not the owner" do
      it "denies access" do
        policy = PostPolicy.new(other_user, post)
        expect(policy.update?).to be false
      end
    end

    context "when user is nil" do
      it "denies access" do
        policy = PostPolicy.new(nil, post)
        expect(policy.update?).to be_falsey
      end
    end
  end

  describe "#destroy?" do
    context "when user is the post owner" do
      it "grants access" do
        policy = PostPolicy.new(owner, post)
        expect(policy.destroy?).to be true
      end
    end

    context "when user is an admin" do
      it "grants access" do
        policy = PostPolicy.new(admin, post)
        expect(policy.destroy?).to be true
      end
    end

    context "when user is not the owner" do
      it "denies access" do
        policy = PostPolicy.new(other_user, post)
        expect(policy.destroy?).to be false
      end
    end

    context "when user is nil" do
      it "denies access" do
        policy = PostPolicy.new(nil, post)
        expect(policy.destroy?).to be_falsey
      end
    end
  end

  describe "Scope" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:post_type1) { create(:post_type, user: user1) }
    let(:post_type2) { create(:post_type, user: user2) }
    let!(:user1_post) { create(:post, post_type: post_type1) }
    let!(:user2_post) { create(:post, post_type: post_type2) }

    it "returns only posts belonging to the user" do
      resolved_scope = PostPolicy::Scope.new(user1, Post.all).resolve

      expect(resolved_scope).to include(user1_post)
      expect(resolved_scope).not_to include(user2_post)
    end

    it "returns empty when user has no posts" do
      user3 = create(:user)
      resolved_scope = PostPolicy::Scope.new(user3, Post.all).resolve

      expect(resolved_scope).to be_empty
    end

    it "returns all posts belonging to the user" do
      additional_post = create(:post, post_type: post_type1)
      resolved_scope = PostPolicy::Scope.new(user1, Post.all).resolve

      expect(resolved_scope).to include(user1_post, additional_post)
      expect(resolved_scope.count).to eq(2)
    end
  end
end
