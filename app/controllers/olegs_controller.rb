class OlegsController < ApplicationController
	include OlegsHelper
	before_action :authenticate_user!, except: [:index]
	before_action :find_oleg, only: [:show, :edit, :update, :destroy]
	
	def index
		if user_signed_in? 
			@olegs = Oleg.where(user_id: current_user).order("created_at DESC")
			@users = User.all.order("points DESC")
		else
			@dump_oleg = DumpOleg.new
			#@teaser = film_to_oleg(get_random_film_name)
		end
	end

	def new
		@oleg = current_user.olegs.build
		@oleg.filmTitle = film_to_oleg(get_random_film_name)
	end


	def create
		@oleg = current_user.olegs.build(oleg_params)		
		if @oleg.save
			add_points
			@oleg.filmTitle = $answer
			@oleg.save
			current_user.save
			flash[:notice] = good_notice
			redirect_to new_oleg_path
		else
			flash[:notice] = bad_notice
			redirect_to new_oleg_path
		end
	end

	def show
		#
	end

	private

		def oleg_params
			params.require(:oleg).permit(:answer)
		end

		def find_oleg
			@oleg = Oleg.find(params[:id])
		end

		def add_points
			current_user.points += (2**(((Oleg.where(user_id: current_user).count)/10).round)).to_f
		end
end


