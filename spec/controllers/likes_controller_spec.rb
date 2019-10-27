# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:post_) { FactoryBot.create(:post) }
  let(:like) { FactoryBot.create(:like, user: user) }

  describe '#create' do
    context 'as an authenticated user' do
      before { sign_in user }

      it 'adds a like to post' do
        expect do
          post :create, params: { like: { user_id: user.id, post_id: post_.id } }
        end.to change(post_.likes, :count).by(1)
      end

      context 'already liked' do
        before { post :create, params: { like: { user_id: user.id, post_id: post_.id } } }
        it 'so delete a like' do
          expect do
            post :create, params: { like: { user_id: user.id, post_id: post_.id } }
          end.to change(post_.likes, :count).by(-1)
        end
      end
    end

    context 'as a guest' do
      before { post :create, params: { like: { user_id: user.id, post_id: post_.id } } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
