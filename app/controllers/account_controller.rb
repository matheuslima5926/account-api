class AccountController < ApplicationController
    def event
        
    end

    def balance
    end

    private
    def event_params
        params.permit(:account_id, :transfer, :origin, :amount, :destination)
    end
end
