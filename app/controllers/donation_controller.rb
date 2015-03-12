class DonationController < ApplicationController
  def index
    
  end

  def donate
    Iugu.api_key = "98f7ca6cc1b969430492d0c8378fc4ce"

    charge = Iugu::Charge.create({
      "token" => params[:token],
      "email" => "paezao@gmail.com",
      "items" => [
        {
          "description" => "Training",
          "quantity" => "1",
          "price_cents" => "1000"
        }
      ]
    })

  end
end
