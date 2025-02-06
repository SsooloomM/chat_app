require 'rails_helper'
RSpec.describe UpdateMessageCountJob, type: :job do
    describe '#perform' do
        let(:chat) { create(:chat) }

        it 'performs the job' do
            sz = 3
            sz.times { create(:message, chat: chat) }
            chat.reload
            expect(chat.message_count).to eq(0)
            Sidekiq::Testing.inline! do
                UpdateMessageCountJob.perform_async
            end
            chat.reload
            expect(chat.message_count).to eq(sz)
        end
    end
    describe "#enqueues" do
        it 'enqueues the job' do
        expect { UpdateMessageCountJob.perform_async }.to enqueue_sidekiq_job(UpdateMessageCountJob)
        end
    end
end
