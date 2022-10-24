Function IsXmlElement(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifXMLElement") <> invalid
End Function

Function IsFunction(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifFunction") <> invalid
End Function

Function IsBoolean(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifBoolean") <> invalid
End Function

Function IsInteger(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifInt") <> invalid And (Type(value) = "roInt" Or Type(value) = "roInteger" Or Type(value) = "Integer")
End Function

Function IsFloat(value As Dynamic) As Boolean
    Return IsValid(value) And (GetInterface(value, "ifFloat") <> invalid Or (Type(value) = "roFloat" Or Type(value) = "Float"))
End Function

Function IsDouble(value As Dynamic) As Boolean
    Return IsValid(value) And (GetInterface(value, "ifDouble") <> invalid Or (Type(value) = "roDouble" Or Type(value) = "roIntrinsicDouble" Or Type(value) = "Double"))
End Function

Function IsList(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifList") <> invalid
End Function

Function IsArray(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifArray") <> invalid
End Function

Function IsAssociativeArray(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifAssociativeArray") <> invalid
End Function

Function IsString(value As Dynamic) As Boolean
    Return IsValid(value) And GetInterface(value, "ifString") <> invalid
End Function

Function IsDateTime(value As Dynamic) As Boolean
    Return IsValid(value) And (GetInterface(value, "ifDateTime") <> invalid Or Type(value) = "roDateTime")
End Function

Function IsValid(value As Dynamic) As Boolean
    Return Type(value) <> "<uninitialized>" And value <> invalid
End Function

'***********************************************************************
'* isSGNode(input)
'* Check if an input is roSGNode or not
'***********************************************************************
function isSGNode(input) as boolean
    typeInput = type(input)

    isOk = (typeInput = "roSGNode")

    return isOk
end function