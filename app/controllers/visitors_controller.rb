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
    csv  = "Date,All visits,Unique Visitors\n"
    Visitor.find_by_sql("select date, count(id) as id, sum(times) as times from visitors group by date").each do |visitor|
      csv << "#{visitor.date},#{visitor.times},#{visitor.id}\n"
    end
    render text: csv
  end

  def show
    render json: Visitor.find_by(date: params["id"])
  end
end