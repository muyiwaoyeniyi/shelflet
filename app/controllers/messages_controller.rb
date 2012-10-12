class MessagesController < ApplicationController

	def new
  	  @message = Message.new
    end

 	def create
  	   @message = Message.new(params[:message])
  	   if @message.valid?
     	UserMailer.contact_us_message(@message).deliver
    	redirect_to root_url, notice: "Your message has been sent to a Human! Thank you for contacting us."
      #flash[:notice] = "Sent!"
  		else
    		render "new"
  		end
	end


end
