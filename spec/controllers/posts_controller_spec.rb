# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  before { @post = user.posts.create(FactoryBot.attributes_for(:post)) }

  describe '#index' do
    context 'as an authenticated user' do
      before { sign_in user }
      it 'responds successfully' do
        get :index
        expect(response).to be_successful
        expect(assigns(:posts)).to eq(Post.all)
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

  describe '#show' do
    context 'as an authenticated user' do
      before { sign_in user }
      it 'responds successfully' do
        get :show, params: { id: @post.id }
        expect(response).to be_successful
        expect(assigns(:post)).to eq(@post)
      end
    end

    context 'as a guest' do
      before { get :show, params: { id: @post.id } }
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

      context 'with valid attributes' do
        it 'adds a post' do
          expect do
            post :create, params: { post: { body: @post.body } }
          end.to change(user.posts, :count).by(1)
        end
      end
    end
    context 'as a guest' do
      before { post :create, params: { post: { content: @post.body } } }
      it 'doesnt respond successfully' do
        expect(response).not_to be_successful
      end

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
