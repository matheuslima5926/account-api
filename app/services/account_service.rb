class AccountService

    def self.process_event(process_payload)
        case process_payload[:type]
        when "deposit"
            return deposit(process_payload[:destination], process_payload[:amount])
        end
    end

    def self.deposit(destination_account, amount)
        if @accounts.blank?
            account = {:id => destination_account, :balance => amount}
            @accounts.push({:id => destination_account, :balance => amount})
            return {created: true, event_data: {destination: account}}
        end
            account = @accounts.select { |item| item[:id].eql? destination_account }.first
            account[:balance] += amount
            return {created: true, event_data: {destination: account}}
        
    end

    private 
        @accounts = []
end