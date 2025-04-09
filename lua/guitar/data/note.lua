local Note = {}







function Note.new(f, s, l, o, r)
   return {
      fret = f,
      string = s,
      length = l,
      offset = o,
      rest = r,
   }
end

function Note:isRest()
   return self.rest
end

return Note
