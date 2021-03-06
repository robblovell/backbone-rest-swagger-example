sw = require './../../public/swagger/swagger'
param = require("./../../public/swagger/paramTypes")
url = require("url")

swe = sw.errors

writeResponse = (res, data) ->
  sw.setHeaders(res)
  res.send(JSON.stringify(data))

# the description will be picked up in the resource listing
exports.getPetById = {
  'spec': {
    description: "Operations about pets",
    path: "/pet/{petId}",
    method: "GET",
    summary: "Find pet by ID",
    notes: "Return a pet based on its ID",
    type: "Pet",
    nickname: "getPetById",
    produces: ["application/json"],
    parameters: [param.path("petId", "ID of pet that needs to be fetched", "string")],
    responseMessages: [swe.invalid('id'), swe.notFound('pet')]
  }
  'action': (req,res) ->
    console.log("hi from getPets")
}

exports.getPets = {
  'spec': {
    description: "Get a list of pets based on query examples.",
    path: "/pet",
    method: "GET",
    summary: "Find by Query",
    notes: "Return a pet based on query parameters",
    type: "array",
    items: {
      $ref: "Pet"
    },
    nickname: "getPets",
    produces: ["application/json"],
    parameters: [param.query("name", "Name of the pet.", "string"),param.query("category", "Category of the pet", "string"),param.query("status", "Status of the pet", "string")],
    responseMessages: [swe.notFound('pet')]
  }
  'action': (req,res) ->
    console.log("hi from getPets")
}

###
  Used the url path "pets" for representations other than CRUD on the model because
  backbone-rest overrides all "noun/path" as the "noun/id" path.  In order to get this
  controller to respond, it needs a different noun.
###
exports.getAvailable = {
  'spec': {
    description: "Get available pets",
    path: "/pets/available",
    method: "GET",
    summary: "Find available pets",
    notes: "Return a list of available",
    type: "array",
    items: {
      $ref: "Pet"
    },
    nickname: "getAvailable",
    produces: ["application/json"],
    parameters: [param.query("name", "Name of the pet.", "string"),param.query("category", "Category of the pet", "string")],
    responseMessages: [swe.notFound('pet'), swe.invalid('input')]
  }
  'action': (req,res) ->
    console.log("getAvailablePets Action: #{req.url}")
    queryObject = JSON.stringify(url.parse(req.url,true).query)
    if (!queryObject)
      throw swe.invalid('query parameters')

    Pet = require './pet'
    Pet.find(JSON.parse(queryObject), (err, pets) ->
      throw swe.notFound('pet') if err
      output = (pet for pet in pets when pet.get('status') is 'available')
      res.send(JSON.stringify(output))
    )
}
exports.getAvailableCows = {
  'spec': {
    description: "Get available cows",
    path: "/pets/available/cows",
    method: "GET",
    summary: "Find available cows",
    notes: "Return a list of available",
    type: "array",
    items: {
      $ref: "Pet"
    },
    nickname: "getAvailableDogs",
    produces: ["application/json"],
    parameters: [param.query("name", "Name of the pet.", "string")],
    responseMessages: [swe.notFound('pet'), swe.invalid('input')]
  }
  'action': (req,res) ->
    console.log("getAvailableDogs Action: #{req.url}")
    queryObject = url.parse(req.url,true).query
    queryObject['category'] = 'cow'
    queryObject['status'] = 'available'
    queryObject = JSON.stringify(queryObject)

    if (!queryObject)
      throw swe.invalid('query parameters')

    Pet = require './pet'
    Pet.find(JSON.parse(queryObject), (err, pets) ->
      throw swe.notFound('pet') if err
      res.send(JSON.stringify(pets))
    )
}

exports.getAvailableCows = {
  'spec': {
    description: "Get available cows",
    path: "/pets/available/cows",
    method: "GET",
    summary: "Find available cows",
    notes: "Return a list of available",
    type: "array",
    items: {
      $ref: "Pet"
    },
    nickname: "getAvailableCows",
    produces: ["application/json"],
    parameters: [param.query("name", "Name of the pet.", "string")],
    responseMessages: [swe.notFound('pet'), swe.invalid('input')]
  }
  'action': (req,res) ->
    console.log("getAvailable/Cows Action: #{req.url}")
    queryObject = url.parse(req.url,true).query
    queryObject['category'] = 'cow'
    queryObject['status'] = 'available'
    queryObject = JSON.stringify(queryObject)

    if (!queryObject)
      throw swe.invalid('query parameters')

    Pet = require './pet'
    Pet.find(JSON.parse(queryObject), (err, pets) ->
      throw swe.notFound('pet') if err
      res.send(JSON.stringify(pets))
    )
}

exports.getAvailableCows2 = {
  'spec': {
    description: "Get available cows 2",
    path: "/pets/availableCows",
    method: "GET",
    summary: "Find available cows",
    notes: "Return a list of available",
    type: "array",
    items: {
      $ref: "Pet"
    },
    nickname: "getAvailableCows2",
    produces: ["application/json"],
    parameters: [param.query("name", "Name of the pet.", "string")],
    responseMessages: [swe.notFound('pet'), swe.invalid('input')]
  }
  'action': (req,res) ->
    console.log("getAvailableCows Action: #{req.url}")
    queryObject = url.parse(req.url,true).query
    queryObject['category'] = 'cow'
    queryObject['status'] = 'available'
    queryObject = JSON.stringify(queryObject)

    if (!queryObject)
      throw swe.invalid('query parameters')

    Pet = require './pet'
    Pet.find(JSON.parse(queryObject), (err, pets) ->
      throw swe.notFound('pet') if err
      res.send(JSON.stringify(pets))
    )
}

exports.postPet = {
  'spec': {
    path: "/pet",
    notes: "Adds a pet to the store",
    summary: "Add a new pet to the store",
    notes: "takes a JSON body with the data.",
    method: "POST",
    parameters : [param.body("Pet", "Pet object that needs to be added to the store", "Pet")],
    responseMessages: [swe.invalid('input')],
    nickname: "addPet"
  }
}

exports.putPet = {
  'spec': {
    path: "/pet/{petId}",
    notes: "Updates a pet in the store",
    method: "PUT",
    summary: "Update an existing pet",
    parameters: [param.path("petId", "ID of pet that needs to be removed", "string"),param.body("Pet", "Pet object that needs to be updated in the store", "Pet")],
    responseMessages: [swe.invalid('id'), swe.notFound('pet'), swe.invalid('input')],
    nickname: "addPet"
  }
}

exports.deletePet = {
  'spec': {
    path: "/pet/{petId}",
    notes: "Removes a pet from the store",
    method: "DELETE",
    summary: "Remove an existing pet",
    parameters : [param.path("petId", "ID of pet that needs to be removed", "string")],
    responseMessages: [swe.invalid('id'), swe.notFound('pet')],
    nickname: "deletePet"
  }
}
