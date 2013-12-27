module.exports =
  Pet:
    id:"Pet",
    required: ["id", "name", "status"],
    properties:
      id:
        type:"integer",
        format:"int64",
        description: "Unique identifier for the Pet, a GUID assigned by persistence.",
      name:
        type:"string",
        description: "Friendly name of the pet"
      status:
        type:"string",
        description:"pet status in the store",
        enum:[
          "available",
          "pending",
          "sold"
        ]
