class DonationController < ApplicationController
  protect_from_forgery except: [:callback]

  before_filter :require_login

  skip_before_filter :require_login, only: [:callback]

  def index
    @donations = Donation.where(status: "paid")
  end

  def callback
    if params[:event] == "invoice.status_changed" && params[:data][:status] == "paid"
      invoice = Iugu::Invoice.fetch params[:data][:id]

      if invoice && invoice.status == "paid"
        donation = Donation.find_by_invoice_id params[:data][:id]
        donation.status = "paid"
        donation.save
      end
    end
  end

  def donate
    Iugu.api_key = "98f7ca6cc1b969430492d0c8378fc4ce"

    if params[:email].blank? || params[:amount].blank?
      flash[:danger] = "Favor preencher e-mail e valor!" 
      return redirect_to root_path
    end

    message = "Doação"
    price_cents = (params[:amount].to_f * 100).to_i

    unless params[:message].blank?
      message = params[:message]
    end

    charge_options = {
      "email" => params[:email],
      "items" => [
        {
          "description" => message,
          "quantity" => "1",
          "price_cents" => price_cents
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
      status = "paid"
      status = "pending" if params[:token].blank?

      Donation.create({
        invoice_id: charge.invoice_id,
        amount_cents: price_cents,
        donated_at: Time.now,
        status: status
      })

      if params[:token].blank?
        redirect_to charge.pdf
      else
        redirect_to thank_you_url
      end
    else
      flash[:danger] = "Erro processando pagamento!" 
      #flash[:danger] = price_cents
      redirect_to root_path
    end

  end
end
