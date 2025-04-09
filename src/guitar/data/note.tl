local record Note
  fret: number
  string: number
  rest: boolean
  length: number
  offset: number
end

function Note.new(f: number, s: number, l: number, o: number, r: boolean): Note
  return {
    fret = f,
    string = s,
    length = l,
    offset = o,
    rest = r
  }
end

function Note:isRest(): boolean
  return self.rest
end

return Note
