require 'spec_helper'
require 'crawler/models/user_profile'

module Crawler
  module Models

    describe UserProfile do

      describe "::fetch" do
        before(:each) do

        end

        it 'fetches user profile from vk and returns user_profile_model' do
          expected = FactoryGirl.create(:user_profile_zolin)
          api = Thread.current[:api]
          api.stub(:users_get) do
            VkResponses::user_profile_zolin
          end
          actual = UserProfile.fetch(1)
          actual.id = expected.id
          actual.should == expected
        end
      end

    end

  end
end