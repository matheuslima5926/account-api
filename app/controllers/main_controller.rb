class MainController < ApplicationController
    def reset
        render json: "OK", status: :ok
    end
end
