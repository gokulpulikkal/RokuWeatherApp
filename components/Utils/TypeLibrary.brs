'******************************************************************************************
'* File: TypeLibrary.brs
'* Description: Common function to handle check type of various object
'******************************************************************************************

'***********************************************************************
'* isSGNode(input)
'* Check if an input is roSGNode or not
'***********************************************************************
function isSGNode(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "roSGNode")

    return isOk
end function

'***********************************************************************
'* safeSGNode(input, default=invalid)
'* Return a safe SGNode
'***********************************************************************
function safeSGNode(input, default=invalid as object) as object
    returnObj = input

    if (NOT isSGNode(input))
        if (default <> invalid AND isSGNode(default))
            returnObj = default
        else
            returnObj = CreateObject("roSGNode", "Node")
        end if
    end if

    return returnObj
end function

'***********************************************************************
'* safeObject(input, type as string)
'* Return a safe SGNode
'***********************************************************************
function safeObject(input, objectType as string) as object
    returnObj = input
    if ((invalid <> input) OR (type(input) <>  objectType))
            returnObj = CreateObject(objectType)
    end if
    return returnObj
end function

'***********************************************************************
'* isSGNodeEvent(input)
'* Check if an input is roSGNodeEvent or not
'***********************************************************************
function isSGNodeEvent(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "roSGNodeEvent")

    return isOk
end function

'***********************************************************************
'* isFunc(input)
'* Check if an input is Function or not
'***********************************************************************
function isFunc(input) as boolean
    typeInput = type(input)
    isOk = (typeInput = "roFunction" OR typeInput = "Function")

    return isOk
end function

'***********************************************************************
'* isString(input)
'* Check if an input is string or not
'***********************************************************************
function isString(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "String" OR typeInput = "roString")

    return isOk
end function

'***********************************************************************
'* safeString(input, default=false)
'* Return a safe String
'***********************************************************************
function safeString(input, default="" as string) as string
    returnObj = input

    if (NOT isString(input))
        if(input <> invalid AND GetInterface(input, "ifToStr") <> invalid)
            returnObj = input.toStr()
        else
            returnObj = default
        end if
    end if

    return returnObj
end function

'***********************************************************************
'* isArray(input)
'* Check if an input is Array or not
'***********************************************************************
function isArray(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "roArray")

    return isOk
end function

'***********************************************************************
'* safeArray(input, default=invalid)
'* Return a safe Assoc Array
'***********************************************************************
function safeArray(input, default=invalid as object) as object
    returnObj = input

    if (NOT isArray(input))
        if (default <> invalid AND isArray(default))
            returnObj = default
        else
            returnObj = []
        end if
    end if

    return returnObj
end function

'***********************************************************************
'* isAA(input)
'* Check if an input is Associative Array or not
'***********************************************************************
function isAA(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "roAssociativeArray")

    return isOk
end function

'***********************************************************************
'* safeAA(input, default=invalid)
'* Return a safe Assoc Array
'***********************************************************************
function safeAA(input, default=invalid as object) as object
    returnObj = input

    if (NOT isAA(input))
        if (isAA(default))
            returnObj = default
        else if (isSGNode(input))
            returnObj = input.getFields()
        else
            returnObj = {}
        end if
    end if

    return returnObj
end function

'***********************************************************************
'* isInt(input)
'* Check if an input is integer or not
'***********************************************************************
function isInt(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "Integer" OR typeInput = "roInteger" OR typeInput = "roInt")

    return isOk
end function

'***********************************************************************
'* safeInt(input, default=0)
'* Return a safe Integer
'***********************************************************************
function safeInt(input, default=0 as integer) as integer
    returnObj = input

    if (NOT isInt(input))
        returnObj = default
    end if

    return returnObj
end function

'***********************************************************************
'* isFloat(input)
'* Check if an input is float or not
'***********************************************************************
function isFloat(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "Float" OR typeInput = "roFloat")

    return isOk
end function

'***********************************************************************
'* safeFloat(input, default=0.0)
'* Return a safe Float
'***********************************************************************
function safeFloat(input, default=0.0 as float) as float
    returnObj = input

    if (NOT isFloat(input))
        returnObj = default
    end if

    return returnObj
end function

'***********************************************************************
'* isBoolean(input)
'* Check if an input is boolean or not
'***********************************************************************
function isBoolean(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "Boolean" OR typeInput = "roBoolean")

    return isOk
end function

'***********************************************************************
'* safeBoolean(input, default=false)
'* Return a safe Boolean
'***********************************************************************
function safeBoolean(input, default=false as boolean) as boolean
    returnObj = input

    if (NOT isBoolean(input))
        returnObj = default
    end if

    return returnObj
end function

'***********************************************************************
'* getFieldInPath(node, requiredFields)
'* Check if the roSGNode has the requires Fields value
'***********************************************************************
function getFieldInPath(instance as object, requiredFields as object) as object
    retVal = Invalid
    if (instance = Invalid) return retVal
    if (NOT isArray(requiredFields)) return retVal
    traverser = instance
    for each field in requiredFields
        if((type(field) <> "string") OR (type(field) <> "roString"))
            return retVal
        endif
        if(traverser.hasField(field))
            traverser = traverser.field
        else
            return retVal
        endif
    end for
    retVal = traverser
    return retVal
end function

