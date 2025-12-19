# Admin skills controller
module Admin
  class SkillsController < BaseController
    before_action :set_skill, only: [:edit, :update, :destroy]

    def index
      @skills = current_user.skills.ordered
      @skills_by_category = @skills.group_by(&:category)
    end

    def new
      @skill = Skill.new
    end

    def create
      @skill = current_user.skills.build(skill_params)

      if @skill.save
        redirect_to admin_skills_path, notice: "Skill created successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @skill.update(skill_params)
        redirect_to admin_skills_path, notice: "Skill updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @skill.destroy
      redirect_to admin_skills_path, notice: "Skill deleted successfully"
    end

    private

    def set_skill
      @skill = current_user.skills.find(params[:id])
    end

    def skill_params
      params.require(:skill).permit(:name, :category, :proficiency, :icon)
    end
  end
end
