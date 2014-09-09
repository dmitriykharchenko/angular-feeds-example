express = require("express")
path = require("path")
app = express()

app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use '/fonts', express.static(path.join(__dirname, "/public/fonts"))
app.use '/javascripts', express.static(path.join(__dirname, "/public/javascripts"))
app.use '/stylesheets', express.static(path.join(__dirname, "/public/stylesheets"))


app.all "/*", (req, res, next) ->
  res.render "index",
    title: "Express"


server = app.listen process.env.PORT or 3000, ->
  console.log "Express server listening on port " + server.address().port
