# Admin projects controller
module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: [:show, :edit, :update, :destroy, :publish, :unpublish, :feature, :unfeature]

    def index
      @pagy, @projects = pagy(policy_scope(Project).recent, limit: 20)
    end

    def show
      authorize @project
    end

    def new
      @project = Project.new
      authorize @project
    end

    def create
      @project = current_user.projects.build(project_params)
      authorize @project

      if @project.save
        ImageProcessingJob.perform_later(@project.id) if @project.featured_image.attached?
        redirect_to admin_project_path(@project), notice: "Project created successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize @project
    end

    def update
      authorize @project

      if @project.update(project_params)
        ImageProcessingJob.perform_later(@project.id) if @project.featured_image.attached?
        redirect_to admin_project_path(@project), notice: "Project updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @project
      @project.destroy
      redirect_to admin_projects_path, notice: "Project deleted successfully"
    end

    def publish
      authorize @project
      @project.publish!
      redirect_to admin_project_path(@project), notice: "Project published"
    end

    def unpublish
      authorize @project
      @project.unpublish!
      redirect_to admin_project_path(@project), notice: "Project unpublished"
    end

    def feature
      authorize @project
      @project.update!(featured: true)
      redirect_to admin_project_path(@project), notice: "Project featured"
    end

    def unfeature
      authorize @project
      @project.update!(featured: false)
      redirect_to admin_project_path(@project), notice: "Project unfeatured"
    end

    private

    def set_project
      @project = Project.friendly.find(params[:id])
    end

    def project_params
      params.require(:project).permit(
        :title, :description, :technologies, :live_url, :github_url,
        :published, :featured, :featured_image, gallery_images: []
      )
    end
  end
end
