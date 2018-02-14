require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'find_or_create_from_auth_hash' do

    let(:auth_hash) do
      {
        provider: 'instagram',
        uid: '12345',
        info: {
          name: 'Test User',
          image: 'dummy_image.jpg'
          },
        credentials: {
          token: '98765'
        }
      }
    end

    let(:subject) { User.find_or_create_from_auth_hash(auth_hash) }

    context 'with persisted user' do
      let!(:user) { FactoryBot.create(:user, uid: '12345', profile_picture: 'foo.jpg', settings: { token: 'abcd' }) }

      it 'does not create a user with same uid' do
        expect { subject }.to_not change(User, :count)
      end

      it 'udaptes the token' do
        expect(user.settings['token']).to_not eq auth_hash[:credentials][:token]
        subject
        expect(user.reload.settings['token']).to eq auth_hash[:credentials][:token]
      end

      it "updates user's profile_picture" do
        expect(user.profile_picture).to_not eq auth_hash[:info][:image]
        subject
        expect(user.reload.profile_picture).to eq auth_hash[:info][:image]
      end
    end

    context 'without persisted user' do
      it 'creates a new user' do
        expect { subject }.to change(User, :count)
      end
    end
  end
end
