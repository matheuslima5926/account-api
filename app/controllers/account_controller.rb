class AccountController < ApplicationController
    def event
        @request = AccountService.process_event(event_params)
        if @request[:created]
            return render json: @request[:event_data], status: :created
        end
        
    end

    def balance
        @balance = AccountService.process_event({type: "balance", account_id: event_params[:account_id]})
        if @balance.present?
            return render json: @balance, status: :ok
        else
            return render json: 0, status: 404
        end

    end

    private
    def event_params
        params.permit(:account_id, :type, :transfer, :origin, :amount, :destination)
    end
end
