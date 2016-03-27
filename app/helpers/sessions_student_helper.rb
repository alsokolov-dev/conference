module SessionsStudentHelper

  # Logs in the given user.
  def log_in(student)
    student[:student_id] = student.id
  end

  # Remembers a user in a persistent session.
  def remember(student)
    student.remember
    cookies.permanent.signed[:student_id] = student.id
    cookies.permanent[:remember_token] = student.remember_token
  end

  # Returns true if the given user is the current user.
  def current_student?(student)
    student == current_student
  end

  # Returns the user corresponding to the remember token cookie.
  def current_student
    if (student_id = session[:student_id])
      @current_student ||= Student.find_by(id: student_id)
    elsif (student_id = cookies.signed[:student_id])
      student = Student.find_by(id: student_id)
      if student && student.authenticated?(:remember, cookies[:remember_token])
        log_in student
        @current_student = student
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_student.nil?
  end

  # Forgets a persistent session.
  def forget(student)
    student.forget
    cookies.delete(:student_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_student)
    session.delete(:student_id)
    @current_student = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
