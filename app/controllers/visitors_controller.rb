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
    @data = Visitor.find_by_sql("select date, count(id) as id, sum(times) as times from visitors group by date order by date asc")
  end

  def show
    result = []
    Visitor.where(date: params["id"]).each do |visitor|
      item = {}
      item["ip"] = visitor.ip
      item["times"] = visitor.times
      item["referer"] = visitor.referer
      item["date"] = visitor.date
      item["created_at"] = visitor.created_at
      item["updated_at"] = visitor.updated_at

      ip_json = JSON.parse(Curl.get("http://ip-api.com/json/" + visitor.ip).body)

      item["org"] = ip_json["org"]
      item["country"] = ip_json["country"]
      item["region"] = ip_json["regionName"]
      item["city"] = ip_json["city"]
      item["isp"] = ip_json["isp"]
      item["address"] = ip_json["as"]

      result.append(item)
    end
    render json: result
  end
end