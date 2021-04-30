class AccountService

    def self.process_event(process_payload)
        case process_payload[:type]
        when "deposit"
            return deposit(process_payload[:destination], process_payload[:amount])
        when "balance"
            return balance(process_payload[:account_id])
        when "transfer"
            return transfer(process_payload[:origin],process_payload[:amount],process_payload[:destination])
        end
    end

    def self.deposit(destination_account, amount)
        account = @accounts.select { |item| item[:id].eql? destination_account }.first
        if !account.blank?
            account[:balance] += amount
            return {created: true, event_data: {destination: account}}
        else
            account = {:id => destination_account, :balance => amount}
            @accounts.push({:id => destination_account, :balance => amount})
            return {created: true, event_data: {destination: account}}
        end
    end

    def self.balance(account_id)
        account = @accounts.select { |item| item[:id].eql? account_id }.first
        return account[:balance] if account.present?
        return nil     
    end

    def self.transfer(origin, amount, destination)
        origin_account = @accounts.select{ |item| item[:id].eql? origin }.first
        destination_account = @accounts.select{ |item| item[:id].eql? destination }.first
        if origin_account.present? && destination_account.present?
            if origin_account[:balance] >= amount
                origin_account[:balance] -= amount
                destination_account[:balance] += amount
                return {completed: true, event_data: {origin: origin_account, destination: destination_account}}
            end
        end
    end
    private
        @accounts = [{:id => 300, :balance => 0}]
end