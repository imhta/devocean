# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  before { @comment = FactoryBot.create(:comment, user_id: user.id) }

  describe '#create' do
    context 'as an authenticated user' do
      before { sign_in user }

      context 'with valid attributes' do
        it 'adds a comment' do
          expect do
            post :create, params: { comment: {user_id: @comment.user.id, post_id: @comment.post.id, body: @comment.body } }
          end.to change(user.comments, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        let(:comment_params) { FactoryBot.attributes_for(:comment, :invalid) }
        let(:create_comment_with_invalid) {post :create, params: { comment: {user_id: @comment.user.id, post_id: @comment.post.id, body: @comment.body } }}
        it 'does not add a project' do
          expect(create_comment_with_invalid).not_to be_successful
        end
      end
    end

    context 'as a guest' do
      before { post :create, params: { comment: { post_id: @comment.post.id, body: @comment.body } } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
