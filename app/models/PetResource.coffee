sw = require './../../swagger/swagger'
param = require("./../../swagger/paramTypes")
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
}

exports.getPets = {
  'spec': {
    description: "Operations about pets",
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

exports.postPet = {
  'spec': {
    path: "/pet",
    notes: "adds a pet to the store",
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
    notes: "updates a pet in the store",
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
    notes: "removes a pet from the store",
    method: "DELETE",
    summary: "Remove an existing pet",
    parameters : [param.path("petId", "ID of pet that needs to be removed", "string")],
    responseMessages: [swe.invalid('id'), swe.notFound('pet')],
    nickname: "deletePet"
  }
}
