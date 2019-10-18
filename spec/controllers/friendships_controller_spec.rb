# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe '#index' do
    context 'as an authenticated user' do
      before { sign_in user }

      it 'responds successfully' do
        get :index
        expect(response).to be_successful
      end
    end

    context 'as a guest' do
      before { get :index }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end
      it 'redirects to sign in path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    context 'as an authenticated user' do
      before { sign_in user }

      context 'to a non friend nor self' do
        it 'create a non confirmed firendship' do
          expect do
            post :create, params: { user_id: other_user.id }
          end.to change(user.friendships, :count).by(1)
        end
      end

      context 'to self' do
        it 'does not create a firendship' do
          expect do
            post :create, params: { user_id: user.id }
          end.not_to change(user.friendships, :count)
        end
      end

      context 'to already existing friendship' do
        it 'does not create a firendship' do
          user.friend_request(other_user)
          other_user.accept(user)
          expect do
            post :create, params: { user_id: user.id }
          end.not_to change(user.friendships, :count)
        end
      end
    end

    context 'as a guest' do
      before { post :create, params: { user_id: other_user.id } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    before do
      user.friend_request(other_user)
    end

    context 'as an authenticated user' do
      before { sign_in other_user }

      it 'confirms the friendship' do
        patch :update, params: { id: user.id }
        expect(other_user.friend_with?(user)).to be true
      end
    end

    context 'as an unauthorized user' do
      before { sign_in user }

      it 'doesnt update the post' do
        patch :update, params: { id: other_user.id }
        expect(user.friend_with?(other_user)).to be false
      end
    end

    context 'as a guest' do
      before { post :update, params: { id: user.id } }
      it 'doesnt confirm friendship' do
        expect(user.friend_with?(user)).to be false
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    before do
      user.friend_request(other_user)
      other_user.accept(user)
    end
    context 'as an authenticated user' do
      before { sign_in user }

      it 'unfriend existing friend' do
        expect do
          delete :destroy, params: { id: other_user.id }
        end.to change(user.friends, :count).by(-1)
      end

      it 'redirects to the root url' do
        delete :destroy, params: { id: other_user.id }
        expect(response).to redirect_to root_url
      end
    end

    context 'as a guest' do
      before { delete :destroy, params: { id: other_user.id } }
      it 'doesnt delete the post' do
        expect(response).not_to be_successful
      end
      it 'redirects to sign in path' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
