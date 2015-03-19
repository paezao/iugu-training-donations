class DonationController < ApplicationController
  def index
  end

  def donate
    Iugu.api_key = "98f7ca6cc1b969430492d0c8378fc4ce"

    charge_options = {
      "email" => "paezao@gmail.com",
      "items" => [
        {
          "description" => "Training",
          "quantity" => "1",
          "price_cents" => "100"
        }
      ]
    }

    if params[:token].blank?
      charge_options["method"] = "bank_slip"
    else
      charge_options["token"] = params[:token]
    end

    charge = Iugu::Charge.create charge_options

    if charge.success
      if params[:token].blank?
        redirect_to charge.pdf
      else
        redirect_to thank_you_url
      end
    else
      flash[:danger] = "Erro processando pagamento!" 
      redirect_to root_path
    end

  end
end
