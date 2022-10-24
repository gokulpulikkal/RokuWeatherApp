function writeToRegistry(key as string, data as string) as void
    sec = CreateObject("roRegistrySection", "locationData")
    sec.Write(key, data)
    sec.Flush()
end function

function readFromRegistry(key as string) as object
    sec = CreateObject("roRegistrySection", "locationData")
    if sec.Exists(key)
        return sec.Read(key)
    end if
    return invalid
end function

