# Admin experiences controller
module Admin
  class ExperiencesController < BaseController
    before_action :set_experience, only: [:edit, :update, :destroy]

    def index
      @experiences = current_user.experiences.chronological
    end

    def new
      @experience = Experience.new
    end

    def create
      @experience = current_user.experiences.build(experience_params)

      if @experience.save
        redirect_to admin_experiences_path, notice: "Experience created successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @experience.update(experience_params)
        redirect_to admin_experiences_path, notice: "Experience updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @experience.destroy
      redirect_to admin_experiences_path, notice: "Experience deleted successfully"
    end

    private

    def set_experience
      @experience = current_user.experiences.find(params[:id])
    end

    def experience_params
      params.require(:experience).permit(:company, :role, :description, :start_date, :end_date, :location, :current)
    end
  end
end
