#  Dependencies
express = require 'express'
http = require('http')
path = require('path')
routes = require('./routes')
user = require('./routes/user')

url = require("url")
swagger = require './public/swagger/swagger'

## Rest Dependencies
RestController = require 'backbone-rest'



# express
app = express()
app.set('port', process.env.PORT || 8002)
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.json())
app.use(express.urlencoded())
app.use(express.methodOverride())
app.use(app.router)
app.use(require('stylus').middleware(path.join(__dirname, 'public')))
app.use(express.static(path.join(__dirname, 'public')))
if ('development' == app.get('env'))
  app.use(express.errorHandler())

## Routes
app.get('/', routes.index)
app.get('/users', user.list)

## Models
pet = require './app/models/pet'
petModel = require './app/models/petmodel'
petResources = require './app/models/petresource'

## Rest Controllers
new RestController(app, {model_type: pet, route: '/pet'})

swagger.setAppHandler(app)

# to restrict access to certain paths and verbs:
#swagger.addValidator(
#  validate = (req, path, httpMethod) ->  # example, only allow POST for api_key="special-key"
#    if ("POST" == httpMethod || "DELETE" == httpMethod || "PUT" == httpMethod)
#      apiKey = req.headers["api_key"]
#      if (!apiKey)
#        apiKey = url.parse(req.url,true).query["api_key"]
#      if ("special-key" == apiKey)
#        return true
#      return false
#    return true
#)

# Add models and methods to swagger
swagger.addModels(petModel)
  .addGet(petResources.getPet)
  .addGet(petResources.getPets)
  .addPost(petResources.postPet)
  .addPut(petResources.putPet)
  .addDelete(petResources.deletePet)

swagger.configureDeclaration("pet", {
  description : "REST for Pets",
  authorizations : ["oauth2"],
  produces: ["application/json"]
})

# set api info
swagger.setApiInfo({
  title: "Backbone-REST Pet Example API",
  description: "Learning REST server. For this sample, you can use the api key \"special-key\" to test the authorization filters",
  termsOfServiceUrl: "Whatever",
  contact: "robb@appnovation.com",
  license: "Apache 2.0",
  licenseUrl: "http://www.apache.org/licenses/LICENSE-2.0.html"
})

swagger.setAuthorizations({
  apiKey: {
    type: "apiKey",
    passAs: "header"
  }
})

swagger.configureSwaggerPaths("", "/api-docs", "")
swagger.configure("http://localhost:8002", "0.1")

# Serve up swagger ui at /docs via static route
docs_handler = express.static(path.join(__dirname, './public'))

app.get(/^\/docs(\/.*)?$/, (req, res, next) ->
  if (req.url == '/docs')  # express static barfs on root url w/o trailing slash
    res.writeHead(302, { 'Location' : req.url + '/' })
    res.end()
    return

  # take off leading /docs so that connect locates file correctly
  req.url = req.url.substr('/docs'.length)
  return docs_handler(req, res, next)
)

# Startup
http.createServer(app).listen(
  app.get('port'),
  () -> console.log('express server listening on port ' + app.get('port') + '!')
)






