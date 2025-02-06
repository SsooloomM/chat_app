require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!


RSpec.describe UpdateChatCountJob, type: :job do
  describe "#perform" do
    let(:testing_app) { create(:app) }
    it 'performs the job' do
      sz = 3
      sz.times { create(:chat, app: testing_app) }
      testing_app.reload
      expect(testing_app.chat_count).to eq(0)
      Sidekiq::Testing.inline! do
        UpdateChatCountJob.perform_async
      end
      testing_app.reload
      expect(testing_app.chat_count).to eq(sz)
    end

    describe "#enqueues" do
      it 'enqueues the job' do
        # Test job enqueueing
        expect { UpdateChatCountJob.perform_async }.to enqueue_sidekiq_job(UpdateChatCountJob)
      end
    end
  end
end
