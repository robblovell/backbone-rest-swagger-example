sw = require './../../public/swagger/swagger'
param = require("./../../public/swagger/paramTypes")
url = require("url")

swe = sw.errors

writeResponse = (res, data) ->
  sw.setHeaders(res)
  res.send(JSON.stringify(data))

# the description will be picked up in the resource listing
exports.getPet = {
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
#  'action': (req,res) ->
#    if (!req.params.petId)
#      throw swe.invalid('id');
#    id = parseInt(req.params.petId);
#    pet = petData.getPetById(id);
#
#    if(pet)
#      console.log('getPet:Found: '+JSON.stringify(pet))
#      res.send(JSON.stringify(pet))
#    else
#      console.log("getPet::Not Found.")
#      throw swe.notFound('pet')

}

exports.getPets = {
  'spec': {
    description: "Get a list of pets based on query examples.",
    path: "/pet",
    method: "GET",
    summary: "Find by Query",
    notes: "Return a pet based on query parameters",
    type: "Pet",
    nickname: "getPets",
    produces: ["application/json"],
    parameters: [param.query("name", "Name of the pet.", "string"),param.query("category", "Category of the pet", "string"),param.query("status", "Status of the pet", "string")],
    responseMessages: [swe.notFound('pet')]
  }
}

exports.getAvailablePets = {
  'spec': {
    description: "Get available pets",
    path: "/availablePet",
    method: "GET",
    summary: "Find available pets",
    notes: "Return a list of available",
    type: "Pet",
    nickname: "getAvailablePets",
    produces: ["application/json"],
    parameters: [param.query("name", "Name of the pet.", "string"),param.query("category", "Category of the pet", "string")],
    responseMessages: [swe.notFound('pet')]
  }
  'action': (req,res) ->
    console.log("getAvailablePets Action: #{req.url}")
    queryObject = JSON.stringify(url.parse(req.url,true).query)
    if (!queryObject)
      throw swe.invalid('status')
    if queryObject
      console.log("query: #{queryObject}")
    else
      console.log("getAvailablePets:: No Query")
    Pet = require './pet'

    Pet.find(JSON.parse(queryObject), (err, pets) ->
      throw swe.notFound('pet') if err
      output = (pet for pet in pets when pet.get('status') is 'available')
      res.send(JSON.stringify(output))
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
