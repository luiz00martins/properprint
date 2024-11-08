--- ProperPrint Library for ComputerCraft
--- @author PentagonLP, SkyTheCodeMaster
--- @version 1.0

--- Helper function to get the last position of a character in a string
--- @param string string: String to search in
--- @param char string: Character to search for
--- @return number?: Position of the last occurrence of char
local function getLastCharPosition(string,char)
    local index = string.find(string, char .. "[^" .. char .. "]*$")
    return index
end

--- Helper function to print text without line breaks
--- @param text string: Text to print
--- @param inclstring string: Indentation string
--- @param xsize number: Maximum line width
--- @param firstline boolean: Whether this is the first line
local function printWithoutLinebreakHelper(text,inclstring,xsize,firstline)

    -- Remaining text fits in one line?
    if #inclstring+#text<=xsize then
        print(inclstring .. text)
        return
    end

    -- Get position for end of line
    local lcp = getLastCharPosition(string.sub(text,0,xsize-#inclstring)," ")
    local cutposition
    if lcp==nil then
        cutposition = xsize
    else
        cutposition = #inclstring+lcp
    end

    -- Print line
    print(string.sub(inclstring .. text,0,cutposition))

    -- All lines from second line onwards have two spaces more indentation
    local inclstringnew
    if firstline then
        inclstringnew = inclstring .. " "
    else
        inclstringnew = inclstring
    end

    -- Recursive call to handle remaining Text
    printWithoutLinebreakHelper(string.sub(text,cutposition+1-#inclstring),inclstringnew,xsize,false)
end

--- Prints text with proper line breaks and indentation
--- @param text string: Text to print
--- @param incl number?: Indentation level (default: 0)
local function pprint(text,incl)
    local xsize,ysize = term.getSize()
    incl = incl or 0
    local inclstring = ""
    for i=1,incl,1 do
        inclstring = " " .. inclstring
    end
    printWithoutLinebreakHelper(text,inclstring,xsize,true)
end

return {
    pprint = pprint,
    printWithoutLinebreakHelper = printWithoutLinebreakHelper,
    getLastCharPosition = getLastCharPosition,
}