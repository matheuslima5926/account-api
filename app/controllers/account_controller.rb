class AccountController < ApplicationController
    def event
        @request = AccountService.process_event(event_params)
        if @request[:created]
            return render json: @request[:event_data], status: :created
        end
        
    end

    def balance
    end

    private
    def event_params
        params.permit(:account_id, :type, :transfer, :origin, :amount, :destination)
    end
end
