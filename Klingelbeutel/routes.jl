using Genie.Router, JSON

Genie.config.run_as_server = true
Genie.config.cors_allowed_origins = ["*"]

route("/") do
  serve_static_file("welcome.html")
end

route("/service/status") do
  msg = Dict("status" => "OK", "code" => 200)
  JSON.json(msg)
end

route("/app/news/:secret/:userid") do 
  
end