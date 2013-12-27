[![Build Status](https://secure.travis-ci.org/vidigami/backbone-orm.png)](http://travis-ci.org/vidigami/backbone-orm)

![logo](https://github.com/vidigami/backbone-orm/raw/master/media/logo.png)

BackboneREST full example using bog standard express code.

A few obvious things that need to be stated to be clear:

* Make sure the header contains Content-Type=application/json in all requests. Without it, the server will just make new records with no fields and just return an id.
* To create a record, just send the fields you want in the record as a JSON object in the body of the request:

  POST /pet/
  Content-Type: application/json
  {
    "name": "butch",
    "category": "rabbit",
    "status": "available"
  }

  The server will send the object back in the response with the primary id assigned.

* To update a record, use PUT.  The ID is sent in the url, and the updated fields are put in the body of the message.

  PUT /pet/52bc781a2448cc0000000004
  Content-Type: application/json
  {
    "name": "really-butch",
    "status": "not available"
  }

* Use GET to retrieve the object in various ways using mongodb like query by example with the query parameters in the url.

  GET /pet?id=52bc781a2448cc0000000004
  GET /pet??category=dog&name="really-butch"

* Use DELETE to remove an object pass the id of the object in the url.

  DELETE /pet/52bc781a2448cc0000000004

* Make sure you have mongodb installed. This example assumes a standard mongodb install on port 27017. You won't have to create the database or the collection.
* If you are playing around with the in memory Models and the MongoDB models, be aware that the sync property changes between backbone-orm and backbone-mongo.

I have grafted on Swagger for documentation and demonstration purposes.  Swagger creates a REST documenation website by
creating an /api-docs endpoint with some JSON that describes the interface.  Swagger-UI queries this endpoint and
generates on the fly a nice looking documentation website where you can try out the API.

To make swagger work, I create a "Mdoel" and a "Resource" file along side the backbone-rest object.  These are just Swagger
style definitions of the REST model and the methods available to get the resource representation.
