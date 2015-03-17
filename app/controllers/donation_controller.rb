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
          "price_cents" => "100"
        }
      ]
    })

    if charge.success
      redirect_to thank_you_url
    else
      flash[:danger] = "Erro processando pagamento!" 
      redirect_to root_path
    end

  end
end
