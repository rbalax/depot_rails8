class SupportRequestsController < ApplicationController
  def index
    @support_requests = SupportRequest.order(created_at: :desc)
  end

  def update
    support_request = SupportRequest.find(params[:id])
    support_request.update(response: params.require(:support_request)[
    :response])
    SupportRequestMailer.respond(support_request).deliver_now
    redirect_to support_requests_path, notice: "Support request ##{support_request.id} has been responded to."
  end
end
