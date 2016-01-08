class VisitorsController < ApplicationController
  def create
    today = Date.today
    v = Visitor.find_by(ip: request.ip, date: today)

    if v
      v.times = v.times + 1
    else
      v = Visitor.new do |v|
        v.ip = request.ip
        v.times = 1
        v.date = today
        v.referer = params["referer"]
      end
    end

    v.save

    render nothing: true
  end

  def index
  end
end