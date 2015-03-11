class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: Amount.premium_membership_charge
    }
  end
  
  def create   
    @user = current_user
    
    # Create a Stripe Customer object to associate with the charge
    customer = Stripe::Customer.create(
      email: @user.email,
      card: params[:stripeToken]
    )
    
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.premium_membership_charge,
      description: "Premium Membership - #{@user.email}",
      currency: 'usd'
    )
    
    flash[:notice] = "Thanks for signing up!"
    @user.set_role('premium')
    @user.save
    redirect_to root_path
    
  # rescue from any errors
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
  
end