class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :pjax_log
  helper_method :pjax?

  def pjax?
    request.env['HTTP_X_PJAX']
  end

  def pjax_log
    if pjax?
      logger.info '* [INFO] requested by pjax'
    end
  end
end
