require "test_helper"

describe User do
  describe "relations" do
    it "has a list of votes" do
      dan = users(:dan)
      expect(dan).must_respond_to :votes
      dan.votes.each do |vote|
        expect(vote).must_be_kind_of Vote
      end
    end

    it "has a list of ranked works" do
      dan = users(:dan)
      expect(dan).must_respond_to :ranked_works
      dan.ranked_works.each do |work|
        expect(work).must_be_kind_of Work
      end
    end
  end

  describe "validations" do
    it "requires a username" do
      user = User.new(uid: 1, provider:"github")
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it "requires a unique uid" do
      uid = 1
      user1 = User.new(username: "a", uid: 1, provider: 'github')

      # This must go through, so we use create!
      user1.save!

      user2 = User.new(username: "a", uid: 1, provider: 'github')
      result = user2.save
      expect(result).must_equal false
      expect(user2.errors.messages).must_include :uid
    end
  end
end
