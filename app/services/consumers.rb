class Consumers
    CONSUMERS_LIST = [ MessageConsumer ]

    def self.run
        CONSUMERS_LIST.each { |c| c.start }
        loop { sleep 5 }
    end
end
