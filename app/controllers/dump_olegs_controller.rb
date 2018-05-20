class DumpOlegsController < ApplicationController
	include OlegsHelper
	def create
		@dump_oleg = DumpOleg.new(dumpoleg_params)		
		if @dump_oleg.save
			flash[:notice] = good_notice
			@dump_oleg.destroy
			redirect_to root_path
		else
			flash[:notice] = bad_notice
			redirect_to root_path
		end
	end

	private

		def dumpoleg_params
			params.require(:dump_oleg).permit(:answer)
		end
end
