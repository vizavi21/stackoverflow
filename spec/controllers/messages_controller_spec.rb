require 'spec_helper'

describe MessagesController do
  describe 'POST #create' do
    let!(:topic) { create(:topic) }
    let(:answer) { attributes_for(:answer) }
    let(:user) { create(:user) }

    def create_answer
      post :create, question_id: topic, message: answer, format: :js
    end

    context 'for authenticated user' do
      before { login user }

      it 'creates answer linked to topic' do
        expect { create_answer }.to change(topic.answers, :count).by(1)
      end

      it 'creates answer linked to logged in user' do
        create_answer
        expect(assigns(:answer).author).to eq(user)
      end
    end

    context 'for non authenticated user' do
      it 'should return unauthorized status' do
        create_answer
        expect(response.status).to eq 401
      end
    end
  end
end